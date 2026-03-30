import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';
import 'base_client.dart';

class ChatController extends GetxController {
  final Dio dio = BaseClient.dio;
  final box = GetStorage();
  final TextEditingController messageController = TextEditingController();

  var isLoading = false.obs;
  var isSending = false.obs;
  var messages = <Map<String, dynamic>>[].obs;

  var hasMoreMessages = true.obs;
  var isFetchingMore = false.obs;
  var offset = 0.obs;
  final int limit = 20;

  Timer? _pollTimer;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
    startPolling();
  }

  @override
  void onClose() {
    stopPolling();
    super.onClose();
  }

  void startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isLoading.value && !isFetchingMore.value) {
        pollMessages();
      }
    });
  }

  void stopPolling() {
    _pollTimer?.cancel();
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
        queryParameters: {"limit": limit, "offset": offset.value},
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

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
          // Filter out any messages that might already be in the list to prevent duplicates
          final existingIds = messages
              .where((m) => m['id'] != null)
              .map((m) => m['id'])
              .toSet();

          final uniqueNewMessages = mapped
              .where((m) => !existingIds.contains(m['id']))
              .toList();

          messages.addAll(uniqueNewMessages);
        }

        offset.value += mapped.length;
        hasMoreMessages.value = mapped.length >= limit;
      } else {
        hasMoreMessages.value = false;
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
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
  // 🔹 2. POLL NEW MESSAGES (Real-time)
  // ============================================================
  Future<void> pollMessages() async {
    final token = box.read('token');
    if (token == null) return;

    try {
      final response = await dio.get(
        ApiConstants.getMessages,
        queryParameters: {"limit": limit, "offset": 0},
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      final data = response.data;
      if (data != null && data['status'] == true) {
        final rawData = data['data'];
        final List fetchedMessages =
            (rawData != null && rawData['messages'] is List)
            ? rawData['messages']
            : [];

        final mapped = fetchedMessages.map((m) {
          final isMe = m['is_from_customer'] == true;
          return {
            'isMe': isMe,
            'text': m['message'] ?? '',
            'sender': isMe ? "Me" : "Support",
            'id': m['id'],
          };
        }).toList();

        // Identify truly new messages (not in our current list by ID)
        final List<Map<String, dynamic>> newItems = [];
        for (var newItem in mapped) {
          final newItemId = newItem['id'];
          if (messages.any((m) => m['id'] == newItemId)) {
            break; // Hit existing messages
          }
          newItems.add(newItem);
        }

        if (newItems.isNotEmpty) {
          // Process updates in reverse to maintain order while inserting at 0
          for (var newItem in newItems.reversed) {
            // Remove optimistic placeholder for sent messages if found
            if (newItem['isMe'] == true) {
              final optIdx = messages.indexWhere(
                (m) =>
                    m['id'] == null &&
                    m['isMe'] == true &&
                    m['text'] == newItem['text'],
              );
              if (optIdx != -1) {
                messages.removeAt(optIdx);
              }
            }
            messages.insert(0, newItem);
            offset.value++;
          }
          update();
        }
      }
    } catch (e) {
      print('Polling error: $e');
    }
  }

  // ============================================================
  // 🔹 3. SEND MESSAGE
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
        'id': null, // Marks it as optimistic
      });

      messageController.clear(); // Clear input right away
      update(); // Update UI optimistically

      final response = await dio.post(
        ApiConstants.sendMessage,
        data: {"message": text.trim()},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      final data = response.data;
      if (data['status'] != true) {
        // If failed, remove optimistic message
        messages.removeWhere((m) => m['id'] == null && m['text'] == text);
        Get.snackbar(
          "Error",
          data['message'] ?? "Failed to send message",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Force poll to get the real message with ID immediately
        pollMessages();
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      messages.removeWhere((m) => m['id'] == null && m['text'] == text);
    } catch (e) {
      print('Exception in sendMessage: $e');
      messages.removeWhere((m) => m['id'] == null && m['text'] == text);
    } finally {
      isSending(false);
      update();
    }
  }
}
