import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final userOrMobileController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  bool isOtpSent = false;

  void sendOtp() {
    if (userOrMobileController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your Email or Mobile Number', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (newPasswordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your New Password', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (newPasswordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please confirm your Password', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Success simulation
    isOtpSent = true;
    update();
    Get.snackbar('Success', 'OTP sent to ${userOrMobileController.text}',
        backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
  }

  void verifyOtp() {
    if (otpController.text.length < 6) {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP',
          backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Success simulation
    Get.snackbar('Success', 'Password reset successfully',
        backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
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
