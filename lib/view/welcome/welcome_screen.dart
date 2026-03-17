import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/welcome_controller.dart';
import '../../generated/l10n.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFEFFFFB),
          body: Stack(
            children: [
              SafeArea(
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
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  right: 20,
                                ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => controller.changeLanguage('en'),
                                        child: Text(
                                          'English',
                                          style: TextStyle(
                                            color: controller.getCurrentLocale() == 'en'
                                                ? const Color(0xFFE30613)
                                                : Colors.black54,
                                            fontSize: 13,
                                            fontWeight: controller.getCurrentLocale() == 'en'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          '|',
                                          style: TextStyle(color: Colors.black26),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller.changeLanguage('ar'),
                                        child: Text(
                                          'العربية',
                                          style: TextStyle(
                                            color: controller.getCurrentLocale() == 'ar'
                                                ? const Color(0xFFE30613)
                                                : Colors.black54,
                                            fontSize: 13,
                                            fontWeight: controller.getCurrentLocale() == 'ar'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ),

                              SizedBox(height: height * 0.08),

                              // ANET Logo Placeholder
                              Container(
                                height: height * 0.15,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'lib/assets/images/Welcome.png',
                                  errorBuilder: (context, error, stackTrace) =>
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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

                              SizedBox(height: height * 0.001),

                              // Title
                              const Text(
                                'Al NAWRAS',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001133), // Dark Navy Blue
                                  letterSpacing: 0.5,
                                ),
                              ),

                              // Subtitle
                              SizedBox(height: height * 0.002),
                              Text(
                                S.of(context).premiumParkingSolutions,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 103, 111, 128),
                                ),
                              ),

                              SizedBox(height: height * 0.1),

                              // Sign In Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: ElevatedButton(
                                  onPressed: controller.goToLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFFE30613,
                                    ), // Red
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
                                  child: Text(
                                    S.of(context).signIn,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: height * 0.015),

                              // Register Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
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
                                  child: Text(
                                    S.of(context).register,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: height * 0.035),

                              // Description Text
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  child: Text(
                                    S.of(context).welcomeDescription,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF001133),
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    ),
                                  ),
                                ),

                              // Bottom Background Image
                              SizedBox(
                                height: height * 0.3,
                                width: double.infinity,
                                child: Image.asset(
                                  'lib/assets/images/Background parking.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: Colors.blue.withValues(
                                          alpha: 0.1,
                                        ),
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
            ],
          ),
        );
      },
    );
  }
}
