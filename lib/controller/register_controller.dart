import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final emiratesIdController = TextEditingController();
  final drivingLicenseController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isTermsAccepted = false;

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    update();
  }

  void createAccount() {
    if (kDebugMode) {
      print("Create Account Clicked");
    }
  }

  void goToSignIn() {
    if (kDebugMode) {
      print("Navigate to Sign In");
    }
    // Navigate back to Sign In
    Get.back();
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
