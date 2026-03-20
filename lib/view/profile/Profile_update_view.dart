import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../controller/profile_controller.dart';

class ProfileUpdateView extends StatelessWidget {
  const ProfileUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.06;

    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Red Curved Header overlap
                Container(
                  height: height * 0.12,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE30613),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                
                // Form Container
                Transform.translate(
                  offset: Offset(0, -height * 0.05),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      children: [
                        _buildProfileImagePicker(width),
                        SizedBox(height: height * 0.04),
                        _buildFormFields(width),
                        SizedBox(height: height * 0.05),
                        _buildSaveButton(width),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Loading Overlay
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE30613)),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker(double width) {
    final controller = Get.find<ProfileController>();
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
            child: Obx(() {
              final user = controller.profile.value;
              final selected = controller.selectedImage.value;
              final img = user?.profileImage;

              return CircleAvatar(
                radius: width * 0.14,
                backgroundColor: Colors.grey[200],
                backgroundImage: selected != null
                    ? FileImage(selected) as ImageProvider
                    : (img != null && img.isNotEmpty
                        ? (img.startsWith('http')
                            ? NetworkImage(img)
                            : MemoryImage(base64Decode(img)) as ImageProvider)
                        : null),
                child: selected == null && (img == null || img.isEmpty)
                    ? Icon(
                        Icons.person,
                        color: Colors.blueGrey[800],
                        size: width * 0.15,
                      )
                    : null,
              );
            }),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => controller.pickImage(),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFE30613),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(double width) {
    final controller = Get.find<ProfileController>();
    return Column(
      children: [
        _buildInputField(
          label: 'Full Name',
          hintText: 'Enter your full name',
          icon: Icons.person_outline,
          controller: controller.nameController,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: 'Email Address',
          hintText: 'Enter your email',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailController,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: 'Mobile Number',
          hintText: 'Enter your mobile number',
          icon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
          controller: controller.phoneController,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.grey[400], size: 22),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(double width) {
    final controller = Get.find<ProfileController>();
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => controller.updateProfile(),
        
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE30613),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
