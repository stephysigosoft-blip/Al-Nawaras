import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/forgot_password_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../../generated/l10n.dart';

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
          appBar: CustomAppBar(
            title: S.of(context).forgotPassword,
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
                  Text(
                    S.of(context).resetYourPassword,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001133),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    S.of(context).enterDetailsToReceiveOtp,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: height * 0.05),

                  // Fields
                  if (!controller.isOtpSent) ...[
                    _buildLabel(S.of(context).usernameOrMobile),
                    _buildTextField(
                      controller.userOrMobileController,
                      S.of(context).enterUsernameOrMobile,
                      Icons.person_outline,
                    ),
                    SizedBox(height: height * 0.025),
                    _buildLabel(S.of(context).newPassword),
                    _buildTextField(
                      controller.newPasswordController,
                      S.of(context).enterNewPassword,
                      Icons.lock_outline,
                      obscureText: controller.obscureNewPassword,
                      onSuffixIconPressed: controller.toggleNewPasswordVisibility,
                      showSuffixIcon: true,
                    ),
                    SizedBox(height: height * 0.025),
                    _buildLabel(S.of(context).confirmPassword),
                    _buildTextField(
                      controller.confirmPasswordController,
                      S.of(context).confirmNewPassword,
                      Icons.lock_outline,
                      obscureText: controller.obscureConfirmPassword,
                      onSuffixIconPressed: controller.toggleConfirmPasswordVisibility,
                      showSuffixIcon: true,
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : controller.sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE30613),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              S.of(context).sendOtp,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],

                  // OTP Section
                  if (controller.isOtpSent) ...[
                    _buildLabel(S.of(context).enter6DigitOtp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: width * 0.12,
                          height: height * 0.065,
                          child: TextField(
                            controller: controller.otpDigitControllers[index],
                            focusNode: controller.otpFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF001133),
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE30613),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                // Move to next field
                                FocusScope.of(context).requestFocus(
                                  controller.otpFocusNodes[index + 1],
                                );
                              } else if (value.isEmpty && index > 0) {
                                // Move to previous field on delete
                                FocusScope.of(context).requestFocus(
                                  controller.otpFocusNodes[index - 1],
                                );
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : controller.verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE30613),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              S.of(context).verifyOtp,
                              style: const TextStyle(
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
                        child: Text(
                          S.of(context).editDetails,
                          style: const TextStyle(color: Color(0xFFE30613)),
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
    bool showSuffixIcon = false,
    VoidCallback? onSuffixIconPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
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
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20, color: Colors.black45),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.black45,
                  ),
                  onPressed: onSuffixIconPressed,
                )
              : null,
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
