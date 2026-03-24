import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';

class ChatController extends GetxController {
  final Dio dio = Dio();
  final box = GetStorage();
  final TextEditingController messageController = TextEditingController();

  var isLoading = false.obs;
  var isSending = false.obs;
  var messages = <Map<String, dynamic>>[].obs;

  var hasMoreMessages = true.obs;
  var isFetchingMore = false.obs;
  var offset = 0.obs;
  final int limit = 20;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  // ============================================================
  // 🔹 1. FETCH MESSAGES
  // ============================================================
  Future<void> fetchMessages({bool reset = true}) async {
    if (reset) {
      isLoading(true);
      offset(0);
      hasMoreMessages(true);
      messages.clear();
    } else {
      if (!hasMoreMessages.value || isFetchingMore.value) return;
      isFetchingMore(true);
    }
    update();

    try {
      final token = box.read('token');

      print('--- Fetching Messages ---');
      print('URL: ${ApiConstants.getMessages}');
      print('Query: {limit: $limit, offset: ${offset.value}}');

      final response = await dio.get(
        ApiConstants.getMessages,
        queryParameters: {
          "limit": limit,
          "offset": offset.value,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "*/*",
          },
        ),
      );

      print('Status Code: ${response.statusCode}');
      // print('Response Data: ${response.data}');

      final data = response.data;
      if (data != null && data['status'] == true) {
        final rawData = data['data'];
        final List fetchedMessages =
            (rawData != null && rawData['messages'] is List)
                ? rawData['messages']
                : [];

        // Map API response to local structure
        final mapped = fetchedMessages.map((m) {
          final isMe = m['is_from_customer'] == true;

          return {
            'isMe': isMe,
            'text': m['message'] ?? '',
            'sender': isMe ? "Me" : "Support",
            'id': m['id'],
          };
        }).toList();

        if (reset) {
          messages.assignAll(mapped);
        } else {
          messages.addAll(mapped);
        }

        offset.value += mapped.length;
        hasMoreMessages.value = mapped.length >= limit;
      } else {
        hasMoreMessages.value = false;
      }
    } on DioException catch (e) {
      print('DioException in fetchMessages: ${e.message}');
      hasMoreMessages.value = false;
    } catch (e) {
      print('Exception in fetchMessages: $e');
      hasMoreMessages.value = false;
    } finally {
      isLoading(false);
      isFetchingMore(false);
      update();
    }
  }

  Future<void> loadMoreMessages() async {
    await fetchMessages(reset: false);
  }

  // ============================================================
  // 🔹 2. SEND MESSAGE
  // ============================================================
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    try {
      isSending(true);
      final token = box.read('token');

      // Optimistically add to local list for snappy UI
      messages.insert(0, {
        'isMe': true,
        'text': text,
        'sender': 'Me',
      });

      messageController.clear(); // Clear input right away
      update(); // Update UI optimistically

      final response = await dio.post(
        ApiConstants.sendMessage,
        data: {
          "message": text.trim(),
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "*/*",
          },
        ),
      );

      print('--- Send Message Response ---');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      final data = response.data;
      if (data['status'] != true) {
        // Handle failure - maybe remove from list or show error
        print('Failed to send message on server');
        Get.snackbar("Error", data['message'] ?? "Failed to send message");
      } else {
        // Optionally fetch messages to sync or append ID
        // fetchMessages(); 
      }
    } on DioException catch (e) {
      print('DioException in sendMessage: ${e.message}');
      Get.snackbar("Error", "Failed to send message");
    } catch (e) {
      print('Exception in sendMessage: $e');
    } finally {
      isSending(false);
      update();
    }
  }


}