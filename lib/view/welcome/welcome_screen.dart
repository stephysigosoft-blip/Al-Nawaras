import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(
            0xFFEFFFFB,
          ), // Light cyan/mint background
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          // Top Row: Language switcher
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'English',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '|',
                                    style: TextStyle(color: Colors.black26),
                                  ),
                                ),
                                Text(
                                  'العربية',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: height * 0.035),

                          // ANET Logo Placeholder
                          // Using an Icon as placeholder if image is missing
                          Container(
                            height: height * 0.055,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/anet_logo.png',
                              errorBuilder: (context, error, stackTrace) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.flight_takeoff,
                                    size: 40,
                                    color: Color(0xFF0D1B2A),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "ANET",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE30613),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: height * 0.015),

                          // Title
                          const Text(
                            'Al NAWRAS',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF001133), // Dark Navy Blue
                              letterSpacing: 0.5,
                            ),
                          ),

                          // Subtitle
                          SizedBox(height: height * 0.005),
                          const Text(
                            'Premium Parking Solutions',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF001133),
                            ),
                          ),

                          SizedBox(height: height * 0.045),

                          // Approved by RTA
                          const Text(
                            'Approved by RTA',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF001133),
                            ),
                          ),
                          SizedBox(height: height * 0.005),

                          // RTA Logo Placeholder
                          Container(
                            height: height * 0.045,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/rta_logo.png',
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: height * 0.04,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE30613), // Red color
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "RTA",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                            ),
                          ),

                          SizedBox(height: height * 0.055),

                          // Sign In Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: ElevatedButton(
                              onPressed: controller.goToLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE30613), // Red
                                foregroundColor: Colors.white,
                                minimumSize: Size(
                                  double.infinity,
                                  height * 0.055,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
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
                          ),

                          SizedBox(height: height * 0.015),

                          // Register Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: OutlinedButton(
                              onPressed: controller.goToRegister,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(
                                  0xFFE30613,
                                ), // Red text
                                side: const BorderSide(
                                  color: Color(0xFFE30613),
                                  width: 1.5,
                                ), // Red border
                                minimumSize: Size(
                                  double.infinity,
                                  height * 0.055,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: height * 0.035),

                          // Description Text
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              'Secure parking for caravans, jet \nskis, food trucks, boats and more',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF001133),
                                height: 1.5,
                              ),
                            ),
                          ),

                          SizedBox(height: height * 0.02),

                          // Spacer to push the image to the bottom
                          const Spacer(),

                          // Bottom Background Image
                          SizedBox(
                            height: height * 0.25,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/parking_bg.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.blue.withValues(alpha: 0.1),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.rv_hookup,
                                          size: 60,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Caravans & Boats Image Placeholder",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
