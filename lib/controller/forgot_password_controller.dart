import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final userOrMobileController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  bool isOtpSent = false;

  void sendOtp() {
    // Basic validation
    if (userOrMobileController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Success simulation
    isOtpSent = true;
    update();
    Get.snackbar('Success', 'OTP sent to ${userOrMobileController.text}',
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  void verifyOtp() {
    if (otpController.text.length < 6) {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Success simulation
    Get.snackbar('Success', 'Password reset successfully',
        backgroundColor: Colors.green, colorText: Colors.white);
    Get.back(); // Go back to login
  }

  @override
  void onClose() {
    userOrMobileController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
