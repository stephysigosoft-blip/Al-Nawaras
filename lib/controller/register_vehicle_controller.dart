import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../config/api_constants.dart';
import '../view/home/home_screen.dart';

class RegisterVehicleController extends GetxController {
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController chassisController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? vehiclePhoto;
  XFile? registrationDoc;

  String selectedVehicleType = 'Caravan';
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    _loadDraft();
  }

  void _loadDraft() {
    final storage = GetStorage();
    final draft = storage.read('vehicle_draft');
    if (draft != null) {
      licenseController.text = draft['license_number'] ?? '';
      makeController.text = draft['make'] ?? '';
      modelController.text = draft['model'] ?? '';
      chassisController.text = draft['chassis_no'] ?? '';
      yearController.text = draft['year'] ?? '';
      lengthController.text = draft['length'] ?? '';
      widthController.text = draft['width'] ?? '';
      heightController.text = draft['height'] ?? '';
      commentsController.text = draft['comments'] ?? '';
      selectedVehicleType = draft['vehicle_type'] ?? 'Caravan';
      update();
    }
  }

  void setVehicleType(String type) {
    selectedVehicleType = type;
    update();
  }

  void onSkipClick() {
    Get.back();
  }

  Future<void> onRegisterClick() async {
    if (isLoading) return;

    final license = licenseController.text.trim();
    final typeId = _getVehicleTypeId(selectedVehicleType);
    final chassis = chassisController.text.trim();
    final model = modelController.text.trim();
    final year = yearController.text.trim();
    final make = makeController.text.trim();

    if (license.isEmpty || chassis.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill required fields (License & Chassis)',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading = true;
    update();

    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');

      final Map<String, dynamic> requestData = {
        "license_number": license,
        "vehicle_type_id": typeId,
        "chassis_no": chassis,
        "model": model,
        "year": year,
        "color": "Blue", // Default as per request or can be expanded
        // Additional fields if needed by backend (not in user example but in UI)
        "make": make,
        "length": lengthController.text,
        "width": widthController.text,
        "height": heightController.text,
        "comments": commentsController.text,
      };

      debugPrint('\n--- API REQUEST (register_vehicle) ---');
      debugPrint('URL: ${ApiConstants.vehicles}');
      debugPrint('Method: POST');
      debugPrint('Headers: {"Authorization": "Bearer $token"}');
      debugPrint('Body: $requestData');

      final response = await dio.post(
        ApiConstants.vehicles,
        data: requestData,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      debugPrint('--- API RESPONSE (register_vehicle) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        // We consider both 200 and 201 as potential success based on API behavior
        // Even if status field is false (as in user example), if message is success and we got data
        storage.remove('vehicle_draft'); // Clear draft on success
        Get.snackbar(
          'Success',
          response.data['message'] ?? 'Vehicle registered successfully',
          backgroundColor: const Color(0xFF2ECC71), // Green
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
          borderRadius: 10,
        );
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Registration failed',
          backgroundColor: const Color(0xFFE30613), // Red
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint('Error registering vehicle: $e');
      Get.snackbar(
        'Error',
        'An error occurred during registration',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  void onRegisterLaterClick() {
    final storage = GetStorage();
    final draft = {
      'license_number': licenseController.text,
      'make': makeController.text,
      'model': modelController.text,
      'chassis_no': chassisController.text,
      'year': yearController.text,
      'length': lengthController.text,
      'width': widthController.text,
      'height': heightController.text,
      'comments': commentsController.text,
      'vehicle_type': selectedVehicleType,
    };
    storage.write('vehicle_draft', draft);

    Get.snackbar(
      'Draft Saved',
      'Vehicle details saved as draft',
      backgroundColor: const Color(0xFF2ECC71),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    Future.delayed(const Duration(seconds: 1), () => Get.back());
  }

  int _getVehicleTypeId(String type) {
    switch (type) {
      case 'JETSKI':
      case 'Jet Ski':
        return 9;
      case 'Food Truck':
        return 10;
      case 'Boat':
        return 12;
      case 'Caravan':
        return 14;
      case 'Trolly':
        return 16; // Assuming next ID or similar
      default:
        return 10;
    }
  }

  Future<void> onUploadPhotoClick() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        vehiclePhoto = image;
        update();
      }
    } catch (e) {
      debugPrint('Error picking vehicle photo: $e');
    }
  }

  Future<void> onUploadDocClick() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        registrationDoc = image;
        update();
      }
    } catch (e) {
      debugPrint('Error picking registration doc: $e');
    }
  }

  @override
  void onClose() {
    licenseController.dispose();
    makeController.dispose();
    modelController.dispose();
    chassisController.dispose();
    yearController.dispose();
    lengthController.dispose();
    widthController.dispose();
    heightController.dispose();
    commentsController.dispose();
    super.onClose();
  }
}
