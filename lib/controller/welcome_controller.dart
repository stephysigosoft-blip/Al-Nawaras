import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../view/register/register_screen.dart';
import '../view/login/login_screen.dart';

class WelcomeController extends GetxController {
  final _storage = GetStorage();

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

  void changeLanguage(String langCode) {
    Locale locale = Locale(langCode);
    Get.updateLocale(locale);
    _storage.write('lang', langCode);
    update();
  }

  String getCurrentLocale() {
    return _storage.read('lang') ?? 'en';
  }
}
