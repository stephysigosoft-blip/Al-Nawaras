import 'package:al_nawaras/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../welcome/welcome_screen.dart';
import '../widgets/profile_header.dart';
import '../widgets/membership_status_card.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/draggable_help_button.dart';
import '../../controller/home_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfileView extends StatelessWidget {
  final Function(int)? onTabChanged;
  const ProfileView({super.key, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.06;

    final profileController = Get.put(ProfileController());

    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      initState: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final homeController = Get.find<HomeController>();
          homeController.currentIndex = 3;
          homeController.update();
        });
      },
      builder: (homeController) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Obx(() {
            if (profileController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFE30613)),
              );
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ProfileHeader(width: width, height: height),
                          Positioned(
                            top: height * 0.25, // Adjust for overlap
                            left: padding,
                            right: padding,
                            child: MembershipStatusCard(
                              width: width,
                              status: profileController.profile.value?.membershipStatus ?? "No Status",
                              vehicles: profileController.profile.value?.vehiclesCount ?? 0,
                              bookings: profileController.profile.value?.bookingsCount ?? 0,
                              services: profileController.profile.value?.servicesCount ?? 0,
                            ),
                          ),
                        ],
                      ),
                      // Floating overlap pushes contents down
                      SizedBox(
                        height: height * 0.2,
                      ), // Buffer for status card bottom
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Column(
                          children: [
                            _buildMenuList(context, width),
                            SizedBox(height: height * 0.03),
                            _buildSignOutButton(width),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const DraggableHelpButton(),
              ],
            );
          }),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: homeController.currentIndex,
            onTap: homeController.changeBottomNavIndex,
          ),
        );
      },
    );
  }
}

Widget _buildMenuList(BuildContext context, double width) {
  return Column(
    children: [
      ProfileMenuItem(
        icon: Icons.person_outline,
        title: 'Personal Information',
        subtitle: 'Update your personal details',
        width: width,
      ),
      ProfileMenuItem(
        icon: Icons.security_outlined,
        title: 'Security',
        subtitle: 'Manage your password and security',
        width: width,
      ),
      ProfileMenuItem(
        icon: Icons.credit_card_outlined,
        title: 'Payment Methods',
        subtitle: 'Manage your payment options',
        width: width,
      ),
      GestureDetector(
        onTap: () {},
        child: ProfileMenuItem(
          icon: Icons.assignment_outlined,
          title: 'Booking History',
          subtitle: 'View your past bookings',
          width: width,
        ),
      ),

      ProfileMenuItem(
        icon: Icons.help_outline,
        title: 'Help & Support',
        subtitle: 'Get Help with your account',
        width: width,
        circleBorderWidth: 2.0,
      ),
      ProfileMenuItem(
        icon: Icons.error_outline,
        title: "About Al-Nawaras",
        subtitle: "Learn more about our services",
        width: width,
        circleBorderWidth: 2.0,
      ),
    ],
  );
}

Widget _buildSignOutButton(double width) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: OutlinedButton(
      onPressed: () {
        final storage = GetStorage();
        storage.remove('token');
        storage.remove('partner_id');
        storage.remove('name');
        storage.remove('email');
        storage.remove('mobile');
        Get.offAll(() => const WelcomeScreen());
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFE30613), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'Sign Out',
        style: TextStyle(
          color: Color(0xFFE30613),
          // fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    ),
  );
}
