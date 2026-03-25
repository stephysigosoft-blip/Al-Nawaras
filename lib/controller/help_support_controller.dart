import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';

class HelpSupportController extends GetxController {
  final Dio dio = Dio();
  final box = GetStorage();

  var isLoading = false.obs;
  var supportEmail = "".obs;
  var supportPhone = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchSupportDetails();
  }

  Future<void> fetchSupportDetails() async {
    try {
      isLoading(true);
      final token = box.read('token');

      if (kDebugMode) {
        print('\n--- API REQUEST (support) ---');
        print('URL: ${ApiConstants.support}');
      }

      final response = await dio.get(
        ApiConstants.support,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "*/*",
          },
        ),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (support) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }

      final data = response.data;
      if (data != null && data['status'] == true) {
        final supportData = data['data'];
        supportEmail.value = supportData['support_email'] ?? "";
        supportPhone.value = supportData['support_phone'] ?? "";
      } else {
        Get.snackbar("Error", data['message'] ?? "Failed to fetch support details");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in fetchSupportDetails: ${e.message}');
      }
      Get.snackbar("Error", "Failed to connect to server");
    } catch (e) {
      if (kDebugMode) {
        print('Exception in fetchSupportDetails: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
