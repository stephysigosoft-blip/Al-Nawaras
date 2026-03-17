import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                // Red Curved Background
                Container(
                  height: height * 0.24,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE30613), // Primary red color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),

                        // Header
                        _buildHeader(controller, height, width),

                        SizedBox(height: height * 0.025),

                        // Membership Card
                        _buildMembershipCard(controller, height, width),

                        SizedBox(height: height * 0.025),

                        // Book & Request Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildSquareButton(
                                "Book Parking",
                                Icons.calendar_today_outlined,
                                controller.onBookParkingClick,
                                height,
                                width,
                              ),
                            ),
                            SizedBox(width: width * 0.035),
                            Expanded(
                              child: _buildSquareButton(
                                "Request Service",
                                Icons.build_outlined,
                                controller.onRequestServiceClick,
                                height,
                                width,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: height * 0.025),

                        // Plan Row
                        _buildPlanRow(controller, height, width),

                        SizedBox(height: height * 0.025),

                        // Navigate Banner
                        _buildNavigateBanner(controller, height, width),

                        SizedBox(height: height * 0.02),

                        // Search Bar
                        _buildSearchBar(controller, height, width),

                        SizedBox(height: height * 0.02),

                        // Smart Parking Banner
                        _buildSmartParkingBanner(controller, height, width),

                        SizedBox(height: height * 0.02),

                        // Opportunity Banner
                        _buildOpportunityBanner(controller, height, width),

                        SizedBox(height: height * 0.03),

                        // My Vehicles section
                        _buildSectionHeader(
                          'My Vehicles',
                          'View All',
                          controller.onViewAllVehiclesClick,
                          height,
                        ),

                        SizedBox(height: height * 0.015),
                        _buildVehicleCard(
                          'Airstream Caravel',
                          'License: AD-45678',
                          true,
                          'Currently Parked • Spot A12',
                          'assets/images/caravan.png',
                          height,
                          width,
                        ),

                        SizedBox(height: height * 0.015),
                        _buildVehicleCard(
                          'Yamaha Waverunner',
                          'License: JT-12345',
                          false,
                          'Not Parked',
                          'assets/images/jetski.png',
                          height,
                          width,
                        ),

                        SizedBox(height: height * 0.025),

                        // Register button
                        _buildRegisterButton(controller, height),

                        SizedBox(height: height * 0.03),

                        // Recent Activity section
                        _buildSectionHeader(
                          'Recent Activity',
                          'View All',
                          controller.onViewAllActivityClick,
                          height,
                        ),

                        SizedBox(height: height * 0.015),
                        _buildActivityCard(
                          'Parking Payment',
                          'Today, 10:30 AM • AED 150',
                          Icons.verified_user_outlined,
                          Colors.blueAccent,
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
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNav(controller, height),
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
            color: Colors.black12.withValues(alpha: 0.05),
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
    IconData icon,
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
              color: Colors.black12.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFE30613), size: 35),
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
            color: Colors.black12.withValues(alpha: 0.05),
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
              const Icon(
                Icons.badge_outlined,
                color: Color(0xFFE30613),
                size: 28,
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
              'assets/images/map_illustration.png',
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
            color: Colors.black12.withValues(alpha: 0.05),
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
            color: Colors.black12.withValues(alpha: 0.05),
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
              'assets/images/parking_isometric.png',
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
              'assets/images/rewards_illustration.png',
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
            color: Colors.black12.withValues(alpha: 0.05),
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
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: 0.05),
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
              color: iconColor.withValues(alpha: 0.15),
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

  Widget _buildBottomNav(HomeController controller, double height) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: controller.changeBottomNavIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE30613), // Red
        unselectedItemColor: Colors.black38,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        backgroundColor: Colors.white,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build_outlined),
            activeIcon: Icon(Icons.build),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
