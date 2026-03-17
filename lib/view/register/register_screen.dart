import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/register_controller.dart';
import '../widgets/custom_app_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(
            0xFFF7F7F7,
          ), // Extremely light grey to match the image matching inputs
          appBar: const CustomAppBar(title: 'Create Account'),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please provide your details to create an account',
                    style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                  SizedBox(height: height * 0.03),

                  _buildTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: controller.fullNameController,
                    height: height,
                  ),

                  _buildTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    height: height,
                  ),

                  _buildTextField(
                    label: 'Mobile Number',
                    hint: '+971 XX XXX XXXX',
                    controller: controller.mobileController,
                    keyboardType: TextInputType.phone,
                    height: height,
                  ),

                  _buildTextField(
                    label: 'Emirates ID',
                    hint: 'Enter your Emirates ID',
                    controller: controller.emiratesIdController,
                    height: height,
                  ),

                  _buildTextField(
                    label: 'Driving License Number (Optional)',
                    hint: 'Enter your Driving License Number',
                    controller: controller.drivingLicenseController,
                    height: height,
                  ),

                  _buildTextField(
                    label: 'Password',
                    hint: 'Create a password',
                    controller: controller.passwordController,
                    obscureText: true,
                    height: height,
                  ),

                  _buildTextField(
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                    height: height,
                  ),

                  SizedBox(height: height * 0.005),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: controller.isTermsAccepted,
                          onChanged: (value) => controller.toggleTerms(),
                          side: const BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                          activeColor: const Color(0xFFE30613),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: TextStyle(fontSize: 11, color: Colors.black87),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.035),

                  ElevatedButton(
                    onPressed: () => controller.createAccount(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFFE30613,
                      ), // Requested custom red color
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, height * 0.055),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: controller.goToSignIn,
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFFE30613),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required double height,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          SizedBox(height: height * 0.008),
          SizedBox(
            height: height * 0.06,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE30613)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
