import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/draggable_help_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<HomeController>().currentIndex = 0;
          Get.find<HomeController>().update();
        });
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    // Red Curved Background
                    Container(
                      height: height * 0.32,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE30613), // Primary red color
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),

                    // Main Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.08),
                          _buildHeader(controller, height, width),
                          SizedBox(height: height * 0.025),
                          _buildMembershipCard(controller, height, width),
                          SizedBox(height: height * 0.015),

                          Row(
                            children: [
                              Expanded(
                                child: _buildSquareButton(
                                  'Book Parking',
                                  const AssetImage(
                                    "lib/assets/images/book parking.png",
                                  ),
                                  controller.onBookParkingClick,
                                  height,
                                  width,
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Expanded(
                                child: _buildSquareButton(
                                  'Request Service',
                                  const AssetImage(
                                    "lib/assets/images/request service.png",
                                  ),
                                  controller.onRequestServiceClick,
                                  height,
                                  width,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),

                          _buildPlanRow(controller, height, width),

                          SizedBox(height: height * 0.02),
                          _buildNavigateBanner(controller, height, width),

                          SizedBox(height: height * 0.02),
                          _buildSearchBar(controller, height, width),

                          SizedBox(height: height * 0.02),
                          _buildSmartParkingBanner(controller, height, width),

                          SizedBox(height: height * 0.02),
                          _buildOpportunityBanner(controller, height, width),

                          SizedBox(height: height * 0.02),
                          _buildSectionHeader(
                            'My Vehicles',
                            'View All',
                            controller.onViewAllVehiclesClick,
                            height,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildVehicleCard(
                            'Airstream Caravel',
                            'License: AD-45678',
                            true,
                            'Parked at Spot B-24',
                            'lib/assets/images/Airstream.png',
                            height,
                            width,
                          ),
                          SizedBox(height: height * 0.015),
                          _buildVehicleCard(
                            'Airstream Basecamp',
                            'License: DX-98123',
                            false,
                            'Away from Parking',
                            'lib/assets/images/Airstream.png',
                            height,
                            width,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildRegisterButton(controller, height),

                          SizedBox(height: height * 0.035),
                          _buildSectionHeader(
                            'Recent Activity',
                            'View All',
                            controller.onViewAllActivityClick,
                            height,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildActivityCard(
                            'Parking Renewed',
                            'Today, 10:30 AM • Monthly Premium',
                            Icons.history,
                            const Color(0xFF00B2FF),
                            height,
                            width,
                          ),
                          SizedBox(height: height * 0.01),
                          _buildActivityCard(
                            'Vehicle Check-in',
                            'Yesterday, 2:15 PM • Spot A12',
                            Icons.check_circle_outline,
                            Colors.greenAccent.shade400,
                            height,
                            width,
                          ),

                          SizedBox(height: height * 0.05), // Bottom padding
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeBottomNavIndex,
          ),
        );
      },
    );
  }

  Widget _buildHeader(HomeController controller, double height, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Faizan Arshad',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: controller.onNotificationClick,
              child: const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
            ),
            SizedBox(width: width * 0.03),
            GestureDetector(
              onTap: controller.onProfileClick,
              child: Container(
                height: height * 0.045,
                width: height * 0.045,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFC107), // Yellow background
                ),
                child: const Icon(Icons.person, color: Colors.black54),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMembershipCard(
    HomeController controller,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Membership',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
              SizedBox(height: height * 0.005),
              const Text(
                'Monthly Premium',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001133),
                ),
              ),
              SizedBox(height: height * 0.005),
              const Text(
                'Valid until: 15 Jun 2023',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: controller.onRenewClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCDD2), // Light red/pink
              foregroundColor: const Color(0xFFE30613), // Red text
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: 0,
              ),
              minimumSize: Size(0, height * 0.04),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Renew',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton(
    String title,
    AssetImage image,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: image,
              color: const Color(0xFFE30613),
              height: 35,
              width: 35,
            ),
            SizedBox(height: height * 0.01),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001133),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanRow(HomeController controller, double height, double width) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "lib/assets/images/membership pleans.png",
                height: 28,
                width: 28,
                color: const Color(0xFFE30613),
              ),
              SizedBox(width: width * 0.02),
              const Text(
                'Membership Plans',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001133),
                ),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: controller.onBuyMembershipClick,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE30613),
              side: const BorderSide(color: Color(0xFFE30613), width: 1.2),
              minimumSize: Size(width * 0.18, height * 0.04),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Buy',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigateBanner(
    HomeController controller,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      height: height * 0.20,
      decoration: BoxDecoration(
        color: const Color(0xFFBFE5E5), // Light teal background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: width * 0.45,
            child: Image.asset(
              'lib/assets/images/map.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.map_outlined,
                size: 80,
                color: Colors.black12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Navigate to\nYour Parking\nSpot',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003D3D),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: height * 0.01),
                ElevatedButton(
                  onPressed: controller.onGetDirectionsClick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBFE5E5), // Matches bg
                    foregroundColor: const Color(0xFF003D3D), // Dark text
                    side: const BorderSide(color: Color(0xFF003D3D), width: 1),
                    elevation: 0,
                    minimumSize: Size(width * 0.4, height * 0.038),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Get Directions',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    HomeController controller,
    double height,
    double width,
  ) {
    return Container(
      height: height * 0.055,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.onSearchChanged,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.black38),
          prefixIcon: const Icon(Icons.search, color: Colors.black38, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: height * 0.015),
        ),
      ),
    );
  }

  Widget _buildSmartParkingBanner(
    HomeController controller,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      height: height * 0.20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: width * 0.5,
            child: Image.asset(
              'lib/assets/images/parking slot.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.local_parking,
                size: 80,
                color: Colors.black12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Smart Parking',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE30613), // Red
                  ),
                ),
                const Text(
                  'for All Vehicle Types',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001133), // Dark
                  ),
                ),
                SizedBox(height: height * 0.005),
                const Text(
                  '300+ secured slots for caravans,\nboats, jet skis & more.',
                  style: TextStyle(fontSize: 9, color: Colors.black87),
                ),
                SizedBox(height: height * 0.01),
                OutlinedButton(
                  onPressed: controller.onBookNowClick,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE30613),
                    side: const BorderSide(color: Color(0xFFE30613), width: 1),
                    minimumSize: Size(width * 0.3, height * 0.038),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Book Now!',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityBanner(
    HomeController controller,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      height: height * 0.15,
      decoration: BoxDecoration(
        color: const Color(0xFFBFE5E5), // Light teal background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: width * 0.45,
            child: Image.asset(
              'lib/assets/images/opportunity.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.card_giftcard,
                size: 60,
                color: Colors.black12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Opportunity!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003D3D),
                  ),
                ),
                SizedBox(height: height * 0.01),
                OutlinedButton(
                  onPressed: controller.onCheckRewardsClick,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF003D3D), // Dark text
                    side: const BorderSide(color: Color(0xFF003D3D), width: 1),
                    minimumSize: Size(width * 0.3, height * 0.038),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Check Rewards',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String actionText,
    VoidCallback onAction,
    double height,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF001133),
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE30613), // Red
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleCard(
    String title,
    String subtitle,
    bool isParked,
    String statusText,
    String imagePath,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.07,
            width: width * 0.2,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.directions_car, color: Colors.black26),
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001133),
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isParked ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(HomeController controller, double height) {
    return OutlinedButton(
      onPressed: controller.onRegisterVehicleClick,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFE30613), // Red text
        side: const BorderSide(
          color: Color(0xFFE30613),
          width: 1.5,
        ), // Red border
        minimumSize: Size(double.infinity, height * 0.055),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Register New Vehicle',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String subtitle,
    IconData iconData,
    Color iconColor,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.045,
            width: height * 0.045,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          SizedBox(width: width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001133),
                ),
              ),
              SizedBox(height: height * 0.005),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
