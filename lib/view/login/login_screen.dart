import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFEFFFFB), // Same light cyan/mint background as welcome
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      20, // To account for the vertical padding
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF001133), size: 24),
                        onPressed: () => Get.back(),
                      ),

                      SizedBox(height: height * 0.05),

                      // ANET Logo Placeholder
                      Center(
                        child: SizedBox(
                          height: height * 0.08,
                          child: Image.asset(
                            'assets/images/anet_logo.png',
                            errorBuilder: (context, error, stackTrace) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.flight_takeoff, size: 50, color: Color(0xFF0D1B2A)),
                                SizedBox(width: 8),
                                Text(
                                  "ANET",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE30613),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.04),

                      // Title
                      const Center(
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001133),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.01),

                      // Subtitle
                      const Center(
                        child: Text(
                          'Sign in to your\nAL Nawras account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF001133),
                            height: 1.3,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.05),

                      // Email or Mobile Number Label
                      const Text(
                        'Email or Mobile Number',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      SizedBox(height: height * 0.01),
                      
                      // Email/Mobile Input
                      SizedBox(
                        height: height * 0.06,
                        child: TextField(
                          controller: controller.emailOrMobileController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Enter your email or mobile',
                            hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                      ),

                      SizedBox(height: height * 0.02),

                      // Password Label and Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          GestureDetector(
                            onTap: controller.forgotPassword,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 11, color: Color(0xFFE30613)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),

                      // Password Input
                      SizedBox(
                        height: height * 0.06,
                        child: TextField(
                          controller: controller.passwordController,
                          obscureText: true,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                      ),

                      SizedBox(height: height * 0.015),

                      // Remember me checkbox
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              value: controller.isRememberMe,
                              onChanged: (value) => controller.toggleRememberMe(),
                              side: const BorderSide(color: Colors.black38, width: 1),
                              activeColor: const Color(0xFFE30613),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Remember me',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.04),

                      // Sign In Button
                      ElevatedButton(
                        onPressed: controller.signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE30613), // Red
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, height * 0.055),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.04),

                      // Or sign in with divider
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Colors.black26, thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Or sign in with',
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xFF001133).withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Colors.black26, thickness: 1)),
                        ],
                      ),

                      SizedBox(height: height * 0.03),

                      // Social Login Buttons
                      Row(
                        children: [
                          _buildSocialButton(
                            child: Image.asset(
                              'assets/images/google_logo.png', // Fallback to icons
                              height: 24,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.g_mobiledata, size: 35, color: Colors.red),
                            ),
                            onTap: controller.signInWithGoogle,
                            height: height,
                          ),
                          _buildSocialButton(
                            child: Image.asset(
                              'assets/images/facebook_logo.png',
                              height: 24,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.facebook, size: 28, color: Colors.blue),
                            ),
                            onTap: controller.signInWithFacebook,
                            height: height,
                          ),
                          _buildSocialButton(
                            child: Image.asset(
                              'assets/images/x_logo.png',
                              height: 20,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.close, size: 26, color: Colors.black),
                            ),
                            onTap: controller.signInWithX,
                            height: height,
                          ),
                        ],
                      ),

                      const Spacer(),
                      SizedBox(height: height * 0.02),

                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.goToRegister,
                            child: const Text(
                              'Register',
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton({
    required Widget child,
    required VoidCallback onTap,
    required double height,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.055,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
