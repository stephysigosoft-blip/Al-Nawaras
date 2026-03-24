import 'package:al_nawaras/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../widgets/profile_header.dart';
import '../widgets/membership_status_card.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/draggable_help_button.dart';
import '../../controller/home_controller.dart';
import '../../controller/logout_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'Profile_update_view.dart';

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
                          PositionedDirectional(
                            top: height * 0.25, // Adjust for overlap
                            start: padding,
                            end: padding,
                            child: MembershipStatusCard(
                              width: width,
                              status:
                                  profileController
                                      .profile
                                      .value
                                      ?.membershipStatus ??
                                  S.of(context).noStatus,
                              vehicles:
                                  profileController
                                      .profile
                                      .value
                                      ?.vehiclesCount ??
                                  0,
                              bookings:
                                  profileController
                                      .profile
                                      .value
                                      ?.bookingsCount ??
                                  0,
                              services:
                                  profileController
                                      .profile
                                      .value
                                      ?.servicesCount ??
                                  0,
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
                            _buildSignOutButton(context, width),
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

  Widget _buildMenuList(BuildContext context, double width) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.find<ProfileController>().resetControllers();
            Get.to(() => const ProfileUpdateView());
          },
          child: ProfileMenuItem(
            icon: Icons.person_outline,
            title: S.of(context).personalInformation,
            subtitle: S.of(context).updatePersonalDetails,
            width: width,
          ),
        ),
        ProfileMenuItem(
          icon: Icons.security_outlined,
          title: S.of(context).security,
          subtitle: S.of(context).manageSecurity,
          width: width,
        ),
        ProfileMenuItem(
          icon: Icons.credit_card_outlined,
          title: S.of(context).paymentMethods,
          subtitle: S.of(context).managePaymentOptions,
          width: width,
        ),
        GestureDetector(
          onTap: () {},
          child: ProfileMenuItem(
            icon: Icons.assignment_outlined,
            title: S.of(context).bookings,
            subtitle: S.of(context).viewPastBookings,
            width: width,
          ),
        ),
        ProfileMenuItem(
          icon: Icons.help_outline,
          title: S.of(context).helpSupport,
          subtitle: S.of(context).getHelpAccount,
          width: width,
          circleBorderWidth: 2.0,
        ),
        ProfileMenuItem(
          icon: Icons.error_outline,
          title: S.of(context).aboutAlNawaras,
          subtitle: S.of(context).learnMoreServices,
          width: width,
          circleBorderWidth: 2.0,
        ),
      ],
    );
  }

  Widget _buildSignOutButton(BuildContext context, double width) {
    final logoutController = Get.put(LogoutController());
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text("Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    logoutController.logOut();
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Color(0xFFE30613)),
                  ),
                ),
              ],
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE30613), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
        ),
        child: Text(
          S.of(context).signOut,
          style: const TextStyle(
            color: Color(0xFFE30613),
            // fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
