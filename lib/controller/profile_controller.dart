import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../config/api_constants.dart';
import '../model/profile_model.dart';
import 'home_controller.dart';
import 'rewards_controller.dart';

class ProfileController extends GetxController {
  final Dio dio = Dio();
  final box = GetStorage();

  var isLoading = false.obs;
  var profile = Rxn<ProfileModel>();
  var profileImageBytes = Rxn<Uint8List>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  String base64Image = "";
  var isImageRemoved = false.obs;

  // 🔹 GET TOKEN
  String? get token => box.read('token');

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ============================================================
  // 🔹 1. FETCH PROFILE
  // ============================================================
  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      if (token == null || token!.isEmpty) {
        Get.snackbar("Error", "Token not found");
        return;
      }

      if (kDebugMode) {
        print('\n--- API REQUEST (profile) ---');
        print('URL: ${ApiConstants.profile}');
        print('Headers: {"Authorization": "Bearer $token"}');
      }

      final response = await dio.get(
        ApiConstants.profile, // /api/profile
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (profile) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('--------------------------\n');
      }

      final data = response.data;

      if (data['status'] == true) {
        profile.value = ProfileModel.fromJson(data['data']);
        
        // Optimistically decode base64 image once to prevent UI jank
        final img = profile.value?.profileImage;
        if (img != null && img.isNotEmpty && !img.startsWith('http')) {
          try {
            profileImageBytes.value = base64Decode(img);
          } catch (e) {
            debugPrint('Error decoding profile image: $e');
            profileImageBytes.value = null;
          }
        } else {
          profileImageBytes.value = null;
        }

        // Prefill fields
        nameController.text = profile.value?.name ?? "";
        emailController.text = profile.value?.email ?? "";
        phoneController.text = profile.value?.mobile ?? "";
      } else {
        Get.snackbar("Error", data['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", e.response?.data['message'] ?? "Fetch failed");
    } finally {
      isLoading(false);
    }
  }

  // ============================================================
  // 🔹 RESET CONTROLLERS
  // ============================================================
  void resetControllers() {
    nameController.text = profile.value?.name ?? "";
    emailController.text = profile.value?.email ?? "";
    phoneController.text = profile.value?.mobile ?? "";
    selectedImage.value = null;
    base64Image = "";
    isImageRemoved.value = false;
  }

  // ============================================================
  // 🔹 2. PICK IMAGE
  // ============================================================
  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 40, // Compress to avoid massive base64 payloads
      maxWidth: 800,
    );

    if (picked != null) {
      selectedImage.value = File(picked.path);

      List<int> bytes = await selectedImage.value!.readAsBytes();
      base64Image = base64Encode(bytes);
      isImageRemoved.value = false;
    }
  }

  void removeImage() {
    selectedImage.value = null;
    isImageRemoved.value = true;
    base64Image = "";
    update();
  }

  // ============================================================
  // 🔹 3. UPDATE PROFILE
  // ============================================================
  Future<void> updateProfile() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
      return;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Email cannot be empty",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        "Error",
        "Invalid email format",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Phone number cannot be empty",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!GetUtils.isNumericOnly(phoneController.text.trim())) {
      Get.snackbar(
        "Error",
        "Phone number must contain only digits",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading(true);

      final response = await dio.post(
        ApiConstants.updateprofile, // /api/profile/update
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "phone_number": phoneController.text,
          if (base64Image.isNotEmpty) "profile_picture": base64Image,
          if (base64Image.isNotEmpty) "profile_image": base64Image,
          if (isImageRemoved.value) "profile_picture": "",
          if (isImageRemoved.value) "profile_image": "",
          if (isImageRemoved.value) "remove_profile_picture": true,
          if (isImageRemoved.value) "remove_profile_image": true,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      print('--- Update Profile Response ---');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      final data = response.data;

      if (data['status'] == true) {
        Get.snackbar(
          "Success",
          data['message'] ?? "Update successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );

        await fetchProfile(); // refresh data

        // Refresh other controllers if they exist
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().fetchHomeData();
        }
        if (Get.isRegistered<RewardsController>()) {
          Get.find<RewardsController>().fetchRewardsData();
          Get.find<RewardsController>().fetchProfileData();
        }

        Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Update failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
      }
    } on DioException catch (e) {
      String errMsg = "Update failed";
      if (e.response != null && e.response!.data is Map) {
        errMsg = e.response!.data['message'] ?? "Update failed";
      } else {
        errMsg = e.message ?? "Update failed";
      }
      Get.snackbar(
        "Error",
        errMsg,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
