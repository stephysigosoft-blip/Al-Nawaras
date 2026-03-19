import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../config/api_constants.dart';
import '../view/login/login_screen.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final emiratesIdController = TextEditingController();
  final drivingLicenseController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Dio dio = Dio();

  bool isTermsAccepted = false;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    update();
  }

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    update();
  }

  void createAccount() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Full Name',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Email Address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid Email Address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (mobileController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Mobile Number',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (drivingLicenseController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Driving License',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!isTermsAccepted) {
      Get.snackbar(
        'Error',
        'Please accept the Terms and Conditions',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _callRegisterApi();
  }

  Future<void> _callRegisterApi() async {
    if (isLoading) return;
    isLoading = true;
    update();

    final requestBody = {
      "full_name": fullNameController.text.trim(),
      "email": emailController.text.trim(),
      "mobile": mobileController.text.trim(),
      "emirates_id": emiratesIdController.text.trim(),
      "driving_license": drivingLicenseController.text.trim(),
      "password": passwordController.text.trim(),
    };

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST ---');
        print('URL: ${ApiConstants.register}');
        print('Payload: $requestBody');
      }

      final response = await dio.post(
        ApiConstants.register,
        data: requestBody,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (kDebugMode) {
        print('--- API RESPONSE ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        print('--------------------\n');
      }

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data;
        final message = data['message'] ?? 'Registration successful';

        if (kDebugMode) {
          print('Registration message: $message');
          if (data['data'] != null && data['data']['token'] != null) {
            print('Token: ${data['data']['token']}');
          }
        }

        Get.snackbar(
          'Success',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );

        Future.delayed(const Duration(milliseconds: 300), () {
          Get.off(() => const LoginScreen());
        });
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('API Error (DioException): ${e.message}');
        if (e.response != null) {
          print('Response Error Data: ${e.response?.data}');
        }
      }
      String errorMessage = 'A network error occurred. Please try again.';
      if (e.response != null &&
          e.response?.data != null &&
          e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  void goToSignIn() {
    if (kDebugMode) {
      print("Navigate to Sign In");
    }
    Get.off(() => const LoginScreen());
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    emiratesIdController.dispose();
    drivingLicenseController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
