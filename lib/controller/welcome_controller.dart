import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../view/register/register_screen.dart';
import '../view/login/login_screen.dart';

class WelcomeController extends GetxController {
  void goToLogin() {
    // Navigate to Login Screen
    if (kDebugMode) {
      print("Navigate to Login");
    }
    Get.to(() => const LoginScreen());
  }
  
  void goToRegister() {
    // Navigate to Register Screen
    if (kDebugMode) {
      print("Navigate to Register");
    }
    Get.to(() => const RegisterScreen());
  }
}
