import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/register_vehicle/register_vehicle_screen.dart';
import '../view/membership_plans/membership_plans_screen.dart';
import '../view/additional_services/additional_services_screen.dart';
import '../view/profile/profile_view.dart';
import '../view/booking/booking_history.dart';
import '../view/parking/select_parking_view.dart';
import '../view/home/home_screen.dart';
import '../view/rewards/rewards_view.dart';
import '../view/home/my_vehicles_view.dart';
import '../view/home/recent_activity_view.dart';
import 'dart:async';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;
  String searchQuery = "";
  bool showAllVehicles = false;
  bool showAllActivities = false;

  final List<Map<String, dynamic>> allVehicles = [
    {
      'title': 'Airstream Caravel',
      'license': 'AD-45678',
      'isParked': true,
      'spot': 'B-24',
      'image': 'lib/assets/images/Airstream.png',
    },
    {
      'title': 'Airstream Basecamp',
      'license': 'DX-98123',
      'isParked': false,
      'spot': '',
      'image': 'lib/assets/images/Airstream.png',
    },
    {
      'title': 'Ford F-150',
      'license': 'NY-12345',
      'isParked': true,
      'spot': 'C-12',
      'image': 'lib/assets/images/Airstream.png',
    },
    {
      'title': 'Tesla Model 3',
      'license': 'CA-67890',
      'isParked': false,
      'spot': '',
      'image': 'lib/assets/images/Airstream.png',
    },
  ];

  final List<Map<String, dynamic>> allActivities = [
    {
      'titleKey': 'parkingRenewed',
      'subtitle': 'Today, 10:30 AM • monthlyPremium',
      'icon': Icons.history,
      'color': const Color(0xFF00B2FF),
    },
    {
      'titleKey': 'vehicleCheckIn',
      'subtitle': 'Yesterday, 2:15 PM • parkedAtSpotA12',
      'icon': Icons.check_circle_outline,
      'color': const Color(0xFF4EEB4E),
    },
    {
      'titleKey': 'parkingRenewed',
      'subtitle': '2 days ago, 09:00 AM • monthlyPremium',
      'icon': Icons.history,
      'color': const Color(0xFF00B2FF),
    },
    {
      'titleKey': 'vehicleCheckIn',
      'subtitle': '3 days ago, 11:45 AM • parkedAtSpotB05',
      'icon': Icons.check_circle_outline,
      'color': const Color(0xFF4EEB4E),
    },
  ];

  List<Map<String, dynamic>> filteredVehicles = [];
  List<Map<String, dynamic>> filteredActivities = [];

  bool hasMoreVehicles = true;
  bool hasMoreActivities = true;
  bool isVehicleLoading = false;
  bool isActivityLoading = false;

  @override
  void onInit() {
    super.onInit();
    filteredVehicles = List.from(allVehicles);
    filteredActivities = List.from(allActivities);
  }

  void loadMoreVehicles() {
    if (isVehicleLoading || !hasMoreVehicles) return;
    isVehicleLoading = true;
    update();

    // Simulate API delay
    Timer(const Duration(seconds: 1), () {
      final more = [
        {
          'title': 'GMC Sierra ${filteredVehicles.length + 1}',
          'license': 'SH-24680',
          'isParked': true,
          'spot': 'D-05',
          'image': 'lib/assets/images/Airstream.png',
        },
        {
          'title': 'Range Rover ${filteredVehicles.length + 2}',
          'license': 'DX-13579',
          'isParked': false,
          'spot': '',
          'image': 'lib/assets/images/Airstream.png',
        },
      ];
      filteredVehicles.addAll(more);
      if (filteredVehicles.length >= 10) hasMoreVehicles = false;
      isVehicleLoading = false;
      update();
    });
  }

  void loadMoreActivities() {
    if (isActivityLoading || !hasMoreActivities) return;
    isActivityLoading = true;
    update();

    // Simulate API delay
    Timer(const Duration(seconds: 1), () {
      final more = [
        {
          'titleKey': 'parkingRenewed',
          'subtitle': 'Last week • monthlyPremium',
          'icon': Icons.history,
          'color': const Color(0xFF00B2FF),
        },
        {
          'titleKey': 'vehicleCheckIn',
          'subtitle': 'Last week • parkedAtSpotC01',
          'icon': Icons.check_circle_outline,
          'color': const Color(0xFF4EEB4E),
        },
      ];
      filteredActivities.addAll(more);
      if (filteredActivities.length >= 10) hasMoreActivities = false;
      isActivityLoading = false;
      update();
    });
  }

  void changeBottomNavIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    if (index == 0) {
      Get.offAll(() => const HomeScreen());
    } else if (index == 1) {
      Get.offAll(() => const BookingHistoryView());
    } else if (index == 2) {
      Get.offAll(() => const AdditionalServicesScreen());
    } else if (index == 3) {
      Get.offAll(() => const ProfileView());
    }
    update();
  }

  void onSearchChanged(String value) {
    searchQuery = value.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredVehicles = List.from(allVehicles);
      filteredActivities = List.from(allActivities);
    } else {
      filteredVehicles = allVehicles.where((v) {
        return v['title'].toString().toLowerCase().contains(searchQuery) ||
            v['license'].toString().toLowerCase().contains(searchQuery);
      }).toList();

      filteredActivities = allActivities.where((a) {
        // Here I'm checking against the keys/subtitles roughly
        return a['titleKey'].toString().toLowerCase().contains(searchQuery) ||
            a['subtitle'].toString().toLowerCase().contains(searchQuery);
      }).toList();
    }
    update();
  }

  void onNotificationClick() {
    if (kDebugMode) print("Notification Clicked");
  }

  void onProfileClick() {
    if (kDebugMode) print("Profile Clicked");
  }

  void onRenewClick() {
    if (kDebugMode) print("Renew Clicked");
  }

  void onBookParkingClick() {
    Get.to(() => const SelectParkingView());
  }

  void onRequestServiceClick() {
    Get.to(() => const AdditionalServicesScreen());
  }

  void onBuyMembershipClick() {
    Get.to(() => const MembershipPlansScreen());
  }

  void onGetDirectionsClick() {
    if (kDebugMode) print("Get Directions Clicked");
  }

  void onBookNowClick() {
    Get.to(() => const SelectParkingView());
  }

  void onCheckRewardsClick() {
    Get.to(() => const RewardsView());
  }

  void onViewAllVehiclesClick() {
    Get.to(() => const MyVehiclesView());
  }

  void onRegisterVehicleClick() {
    Get.to(() => const RegisterVehicleScreen());
  }

  void onViewAllActivityClick() {
    Get.to(() => const RecentActivityView());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
