import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';

class PrivacyPolicyController extends GetxController {
  final Dio dio = Dio();
  final box = GetStorage();

  var isLoading = false.obs;
  var privacyPolicyContent = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading(true);
      final token = box.read('token');

      if (kDebugMode) {
        print('\n--- API REQUEST (privacy_policy) ---');
        print('URL: ${ApiConstants.privacyPolicy}');
      }

      final response = await dio.get(
        ApiConstants.privacyPolicy,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "*/*",
          },
        ),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (privacy_policy) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }

      final data = response.data;
      if (data != null && data['status'] == true) {
        final policyData = data['data'];
        privacyPolicyContent.value = policyData['privacy_policy'] ?? "";
      } else {
        Get.snackbar("Error", data['message'] ?? "Failed to fetch Privacy Policy");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in fetchPrivacyPolicy: ${e.message}');
      }
      Get.snackbar("Error", "Failed to connect to server");
    } catch (e) {
      if (kDebugMode) {
        print('Exception in fetchPrivacyPolicy: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
