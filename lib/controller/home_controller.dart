import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/register_vehicle/register_vehicle_screen.dart';
import '../view/membership_plans/membership_plans_screen.dart';
import '../view/book_parking/book_parking_screen.dart';
import '../view/additional_services/additional_services_screen.dart';
import '../view/home/home_screen.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;

  void changeBottomNavIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    if (index == 0) {
      Get.offAll(() => const HomeScreen());
    } else if (index == 1) {
      // Get.to(() => const BookParkingScreen());
    } else if (index == 2) {
      Get.to(() => const AdditionalServicesScreen());
    }
    update();
  }

  void onSearchChanged(String value) {
    if (kDebugMode) print("Search: $value");
    // Implement search logic here
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
    Get.to(() => const BookParkingScreen());
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
    if (kDebugMode) print("Book Now Clicked");
  }

  void onCheckRewardsClick() {
    if (kDebugMode) print("Check Rewards Clicked");
  }

  void onViewAllVehiclesClick() {
    if (kDebugMode) print("View All Vehicles Clicked");
  }

  void onRegisterVehicleClick() {
    Get.to(() => const RegisterVehicleScreen());
  }

  void onViewAllActivityClick() {
    if (kDebugMode) print("View All Activity Clicked");
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
