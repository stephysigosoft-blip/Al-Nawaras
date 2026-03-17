import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  String selectedVehicleType = 'Caravan';

  void setVehicleType(String type) {
    selectedVehicleType = type;
    update();
  }

  void onSkipClick() {
    Get.back();
  }

  void onRegisterClick() {
    // Implement registration logic
    Get.back();
  }

  void onRegisterLaterClick() {
    Get.back();
  }

  void onUploadPhotoClick() {
    // Implement photo upload
  }

  void onUploadDocClick() {
    // Implement document upload
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
