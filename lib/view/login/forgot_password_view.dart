import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/forgot_password_controller.dart';
import '../widgets/custom_app_bar.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            title: 'Forgot Password',
            centerTitle: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reset your password',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001133),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  const Text(
                    'Please enter your details to receive an OTP',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: height * 0.05),

                  // Fields
                  if (!controller.isOtpSent) ...[
                    _buildLabel('Username or Mobile Number'),
                    _buildTextField(
                      controller.userOrMobileController,
                      'Enter Username or Mobile',
                      Icons.person_outline,
                    ),
                    SizedBox(height: height * 0.025),
                    _buildLabel('New Password'),
                    _buildTextField(
                      controller.newPasswordController,
                      'Enter New Password',
                      Icons.lock_outline,
                      obscureText: true,
                    ),
                    SizedBox(height: height * 0.025),
                    _buildLabel('Confirm Password'),
                    _buildTextField(
                      controller.confirmPasswordController,
                      'Confirm New Password',
                      Icons.lock_outline,
                      obscureText: true,
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: controller.sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE30613),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  // OTP Section
                  if (controller.isOtpSent) ...[
                    _buildLabel('Enter 6-Digit OTP'),
                    _buildTextField(
                      controller.otpController,
                      'X X X X X X',
                      Icons.security_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: controller.verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE30613),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          controller.isOtpSent = false;
                          controller.update();
                        },
                        child: const Text(
                          'Edit Details',
                          style: TextStyle(color: Color(0xFFE30613)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ), // ignore: deprecated_member_use
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20, color: Colors.black45),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE30613)),
          ),
        ),
      ),
    );
  }
}
