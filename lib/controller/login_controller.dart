import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../config/api_constants.dart';
import '../view/register/register_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/forgot_password_view.dart';

class LoginController extends GetxController {
  final emailOrMobileController = TextEditingController();
  final passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
        print('\n--- API REQUEST (login) ---');
        print('URL: ${ApiConstants.login}');
        print('Payload: {"login": "$login", "password": "$password"}');
      }

      final response = await dio.post(
        ApiConstants.login,
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
            duration: const Duration(
              seconds: 2,
            ), // Gives user time to see success
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

  // Google Login

  Future<void> googleLogin() async {
    try {
      isLoading = true;
      update();

      // 🔹 Step 1: Google Sign-In
      final user = await _googleSignIn.signIn();

      if (user == null) {
        isLoading = false;
        update();
        return; // user cancelled login
      }

      // 🔹 Step 2: Get Tokens
      final auth = await user.authentication;

      final idToken = auth.idToken;

      if (idToken == null) {
        Get.snackbar("Error", "Failed to get Google token");
        return;
      }
      print("ID TOKEN: $idToken");

      // 🔹 Step 3: Call API
      final response = await dio.post(
        ApiConstants.socialLogin,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          "provider": "google",
          "auth_token": idToken,
          "email": user.email,
        },
      );

      final data = response.data;

      if (response.statusCode == 200 && data["status"] == true) {
        // 🔹 Step 4: Save Token
        box.write("token", data["data"]["token"]);
        print("SAVED TOKEN: ${box.read("token")}");
        box.write("name", data["data"]["name"]);
        box.write("email", data["data"]["email"]);

        Get.snackbar("Success", "Login successful");

        // 🔹 Step 5: Navigate
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar("Error", data["message"]);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Social Login Error (DioException): ${e.message}');
        if (e.response != null) {
          print('Response Error Data: ${e.response?.data}');
        }
      }
      String errorMessage = 'A network error occurred. Please try again.';
      if (e.response != null && e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar("Error", errorMessage);
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      isLoading = true;
      update();

      // 🔹 Step 1: Facebook Login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        if (kDebugMode)
          print("Facebook Access Token: ${accessToken.tokenString}");

        // 🔹 Step 2: Call API
        final response = await dio.post(
          ApiConstants.socialLogin,
          options: Options(contentType: Headers.formUrlEncodedContentType),
          data: {
            "provider": "facebook",
            "access_token": accessToken.tokenString,
          },
        );

        final data = response.data;

        if (response.statusCode == 200 && data["status"] == true) {
          // 🔹 Step 3: Save Token
          box.write("token", data["data"]["token"]);
          box.write("name", data["data"]["name"]);
          box.write("email", data["data"]["email"]);

          Get.snackbar("Success", "Login successful");

          // 🔹 Step 4: Navigate
          Get.offAll(() => const HomeScreen());
        } else {
          Get.snackbar("Error", data["message"] ?? "Login failed");
        }
      } else if (result.status == LoginStatus.cancelled) {
        if (kDebugMode) print("Facebook Login Cancelled");
      } else {
        Get.snackbar("Error", result.message ?? "Facebook login failed");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Facebook Login Error (DioException): ${e.message}');
        if (e.response != null) {
          print('Response Error Data: ${e.response?.data}');
        }
      }
      String errorMessage = 'A network error occurred. Please try again.';
      if (e.response != null && e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar("Error", errorMessage);
    } catch (e) {
      if (kDebugMode) print("Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
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
