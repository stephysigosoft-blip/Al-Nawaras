import 'dart:async';

import 'package:al_nawaras/view/book_parking/book_parking_screen.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
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
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import '../view/login/login_screen.dart';
import '../view/settings/maintenance.dart';
import '../config/api_constants.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;
  String searchQuery = "";
  bool showAllVehicles = false;
  bool showAllActivities = false;

  String userName = "Loading...";
  String membershipStatus = "Loading...";
  String membershipTier = "Loading...";
  String? membershipValidUntil;
  bool claimReward = false;
  String? profilePicture;

  List<Map<String, dynamic>> allVehicles = [];
  List<Map<String, dynamic>> allActivities = [];

  List<Map<String, dynamic>> filteredVehicles = [];
  List<Map<String, dynamic>> filteredActivities = [];

  bool hasMoreVehicles = true;
  bool hasMoreActivities = true;
  bool isVehicleLoading = false;
  bool isActivityLoading = false;
  bool isLoadingHistory = false;
  List<Map<String, dynamic>> bookingHistory = [];

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
    fetchHomeData();
  }

  Future<void> fetchSettings() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String buildNumber = packageInfo.version;

      final dio = Dio();
      final response = await dio.get(ApiConstants.settings);

      if (kDebugMode) {
        print('\n--- API REQUEST (settings) ---');
        print('URL: ${ApiConstants.settings}');
        print('--- API RESPONSE (settings) ---');
        print('Response Body: ${response.data}');
      }

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data']['settings'];
        if (data != null) {
          bool maintenanceAndroid = data['maintenance_android'] == 1;
          bool maintenanceIos = data['maintenance_ios'] == 1;
          String? reason =
              data['maintenance_reason_ios']?.toString() ??
              data['maintenance_reason_android']?.toString();

          if (Platform.isAndroid && maintenanceAndroid) {
            Get.offAll(() => Maintenance(serverDownReason: reason));
          } else if (Platform.isIOS && maintenanceIos) {
            Get.offAll(() => Maintenance(serverDownReason: reason));
          } else {
            // Check for updates
            String playStoreVersion = data['play_store_version'] ?? "1.0.0";
            String appStoreVersion = data['app_store_version'] ?? "1.0.0";
            bool forceUpdateAndroid = data['play_store_update'] == 1;
            bool forceUpdateIos = data['app_store_update'] == 1;

            if (Platform.isAndroid &&
                forceUpdateAndroid &&
                _versionToCode(playStoreVersion) >
                    _versionToCode(buildNumber)) {
              // Get.offAll(() => const NeedAnUpdate()); // If you have this screen
            } else if (Platform.isIOS &&
                forceUpdateIos &&
                _versionToCode(appStoreVersion) > _versionToCode(buildNumber)) {
              // Get.offAll(() => const NeedAnUpdate()); // If you have this screen
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch settings: $e');
      }
    }
  }

  int _versionToCode(String version) {
    try {
      List<String> codes = version.split('.');
      int code = 0;
      for (int i = 0; i < codes.length; i++) {
        code += int.parse(codes[i]) * (1000 ^ (2 - i));
      }
      return code;
    } catch (e) {
      return 0;
    }
  }

  Future<void> logOut() async {
    final storage = GetStorage();
    await storage.erase();
    Get.offAll(() => const LoginScreen());
  }

  Future<void> fetchHomeData() async {
    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      if (kDebugMode) {
        print('\n--- API REQUEST (home) ---');
        print('URL: ${ApiConstants.home}');
        print('Headers: $headers');
      }

      final response = await dio.get(
        ApiConstants.home,
        options: Options(headers: headers),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (home) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('--------------------------\n');
      }

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final data = response.data['data'];

          userName = data['user_name'] ?? 'Guest';
          profilePicture = data['profile_picture'];

          final membership = data['membership_details'];
          if (membership != null) {
            membershipStatus = membership['status'] ?? 'No Active Plan';
            membershipTier = membership['tier'] ?? 'Standard';
            membershipValidUntil = membership['valid_until']?.toString();
          }

          claimReward = data['claim_reward'] == true;

          final vehicles = data['my_vehicles'] as List?;
          if (vehicles != null) {
            allVehicles = vehicles.map((v) {
              String? imageVal = v['vehicle_image']?.toString();
              return {
                'title': v['vehicle_type_name'] ?? 'Vehicle',
                'license': v['license_number'] ?? '',
                'isParked': false,
                'spot': '',
                // If it's null, false or empty, use default asset
                'image':
                    (imageVal != null &&
                        imageVal.isNotEmpty &&
                        imageVal != "false")
                    ? imageVal
                    : 'lib/assets/images/Airstream.png',
              };
            }).toList();
          }

          final activities = data['recent_activities'] as List?;
          if (activities != null) {
            // Mapping for activities if they eventually have data
            allActivities = [];
          }

          filteredVehicles = List.from(allVehicles);
          filteredActivities = List.from(allActivities);
          update();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch home data: $e');
      }
    }
  }

  Future<void> fetchParkingHistory() async {
    isLoadingHistory = true;
    update();

    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (parking_history) ---');
      debugPrint('URL: ${ApiConstants.parkingHistory}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.parkingHistory,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (parking_history) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final historyData = response.data['data']['history'] as List? ?? [];
          bookingHistory = historyData.map((item) {
            return {
              'id': item['id'],
              'title': item['membership_plan'] ?? 'Parking',
              'subtitle':
                  '${item['vehicle_name'] ?? 'Vehicle'} • Spot ${item['slot_number'] ?? 'N/A'}',
              'status': item['status'] ?? 'Active',
              'startDate': item['start_date'] ?? '',
              'endDate': item['end_date'] ?? '',
              'amount': 'AED ${item['price'] ?? '0'}',
              'isActive':
                  (item['status']?.toString().toLowerCase() == 'active'),
              'monthYear': item['month_year'] ?? 'Recent',
            };
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching parking history: $e');
    } finally {
      isLoadingHistory = false;
      update();
    }
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
    changeBottomNavIndex(3);
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
    Get.to(() => const SelectParkingView(isDirectionMode: true));
  }

  void onBookNowClick() {
    Get.to(() => const SelectParkingView(isDirectionMode: false));
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
