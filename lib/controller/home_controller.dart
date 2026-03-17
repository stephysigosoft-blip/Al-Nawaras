import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/register_vehicle/register_vehicle_screen.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;

  void changeBottomNavIndex(int index) {
    currentIndex = index;
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
    if (kDebugMode) print("Book Parking Clicked");
  }

  void onRequestServiceClick() {
    if (kDebugMode) print("Request Service Clicked");
  }

  void onBuyMembershipClick() {
    if (kDebugMode) print("Buy Membership Clicked");
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
