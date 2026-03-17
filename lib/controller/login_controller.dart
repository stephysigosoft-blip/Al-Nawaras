import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/register/register_screen.dart';
import '../view/home/home_screen.dart';

class LoginController extends GetxController {
  final emailOrMobileController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRememberMe = false;

  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
    update();
  }

  void signIn() {
    Get.offAll(() => const HomeScreen());
  }

  void forgotPassword() {
    if (kDebugMode) {
      print("Forgot Password Clicked");
    }
  }

  void signInWithGoogle() {
    if (kDebugMode) {
      print("Google Sign In");
    }
  }

  void signInWithFacebook() {
    if (kDebugMode) {
      print("Facebook Sign In");
    }
  }

  void signInWithX() {
    if (kDebugMode) {
      print("X Sign In");
    }
  }

  void goToRegister() {
    // Navigate to Register or replace current screen depending on flow
    Get.off(() => const RegisterScreen());
  }

  @override
  void onClose() {
    emailOrMobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
