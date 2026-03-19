import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';
import '../view/register/register_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/forgot_password_view.dart';

class LoginController extends GetxController {
  final emailOrMobileController = TextEditingController();
  final passwordController = TextEditingController();

  final box = GetStorage();
  final Dio dio = Dio();

  bool isRememberMe = false;
  bool isLoading = false;
  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _loadRememberedCredentials();
  }

  void _loadRememberedCredentials() {
    final savedLogin = box.read('login_email');
    final savedPassword = box.read('login_password');
    final savedRememberMe = box.read('remember_me');

    if (savedRememberMe == true) {
      isRememberMe = true;
      if (savedLogin != null) emailOrMobileController.text = savedLogin;
      if (savedPassword != null) passwordController.text = savedPassword;
    }
  }

  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
    update();
  }

  Future<void> signIn() async {
    final login = emailOrMobileController.text.trim();
    final password = passwordController.text.trim();

    // Validation
    if (login.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Username or Mobile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isLoading) return;
    isLoading = true;
    update();

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST ---');
        print('URL: ${ApiConstants.baseUrl}login');
        print('Payload: {"login": "$login", "password": "$password"}');
      }

      final response = await dio.post(
        '${ApiConstants.baseUrl}login',
        data: {"login": login, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data;
        if (data['status'] == true) {
          if (kDebugMode) {
            print('--- API RESPONSE ---');
            print('Response Data: $data');
            print('Token Extracted & Saved: ${data['data']['token']}');
            print('Login successful: ${data['message']}');
            print('--------------------\n');
          }
          final loginData = data['data'];

          // Save login details for further use
          box.write('token', loginData['token']);
          box.write('partner_id', loginData['partner_id']);
          box.write('name', loginData['name']);
          box.write('email', loginData['email']);
          box.write('mobile', loginData['mobile']);

          // Remember Me
          if (isRememberMe) {
            box.write('remember_me', true);
            box.write('login_email', login);
            box.write('login_password', password);
          } else {
            box.remove('remember_me');
            box.remove('login_email');
            box.remove('login_password');
          }

          Get.snackbar(
            'Success',
            'Login successful',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2), // Gives user time to see success
          );

          // Delay slightly so the snackbar gets registered before replacing the route
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.offAll(() => const HomeScreen());
          });
        } else {
          final message =
              data['message'] ?? 'Login failed. Please check your credentials.';
          if (kDebugMode) {
            print('Login failure from API: $message');
          }
          Get.snackbar(
            'Error',
            message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
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

  void forgotPassword() {
    Get.to(() => const ForgotPasswordView());
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
