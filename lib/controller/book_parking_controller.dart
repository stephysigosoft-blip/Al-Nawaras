import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';

class BookParkingController extends GetxController {
  bool isLoadingVehicles = false;
  List<Map<String, dynamic>> vehiclesList = [];
  Map<String, dynamic>? selectedVehicleData;

  String selectedParkingType = 'Shaded';
  String selectedMembership = 'Hourly';

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    isLoadingVehicles = true;
    update();

    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (vehicles) ---');
      debugPrint('URL: ${ApiConstants.vehicles}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.vehicles,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (vehicles) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List vData = response.data['data']['vehicles'] ?? [];
          vehiclesList = vData.map((e) => e as Map<String, dynamic>).toList();

          if (vehiclesList.isNotEmpty) {
            selectedVehicleData = vehiclesList[0];
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching vehicles: $e');
    } finally {
      isLoadingVehicles = false;
      update();
    }
  }

  void setSelectedVehicle(Map<String, dynamic> vehicle) {
    selectedVehicleData = vehicle;
    update();
  }

  String getVehicleImage(String? typeName) {
    // Mapping based on common names or defaults
    return 'lib/assets/images/Airstream.png';
  }

  final List<String> parkingTypes = ['Unshaded', 'Shaded', 'Air Conditioned'];
  final List<Map<String, String>> membershipPackages = [
    {'title': 'Hourly', 'price': 'AED 15/hour'},
    {'title': 'Daily', 'price': 'AED 100/day'},
    {'title': 'Weekly', 'price': 'AED 500/week'},
    {'title': 'Monthly', 'price': 'AED 1,500/month'},
    {'title': '3 Months', 'price': 'AED 4,000/year'},
    {'title': '6 Months', 'price': 'AED 7,500/6 months'},
  ];

  final List<Map<String, dynamic>> addonServices = [
    {
      'title': 'Battery Replacement',
      'price': 'AED 150',
      'subtitle': 'Engine service with diagnostics',
      'icon': 'lib/assets/images/battery.png',
      'isSelected': true,
    },
    {
      'title': 'Oil Change',
      'price': 'AED 300',
      'subtitle': 'Scheduled maintenance service',
      'icon': 'lib/assets/images/oil charge.png',
      'isSelected': true,
    },
    {
      'title': 'Tire Change',
      'price': 'AED 100',
      'subtitle': 'Front back and parking lot tire tests',
      'icon': 'lib/assets/images/tire change.png',
      'isSelected': false,
    },
    {
      'title': 'Car Wash',
      'price': 'AED 150',
      'subtitle': 'Front back and parking lot tire tests',
      'icon': 'lib/assets/images/cleaning.png',
      'isSelected': false,
    },
    {
      'title': 'Towing',
      'price': 'AED 150',
      'subtitle': 'From location to parking in 1 hour limit',
      'icon': 'lib/assets/images/Trolly.png',
      'isSelected': false,
    },
    {
      'title': 'Vehicle Pickup/Drop-off',
      'price': 'AED 100',
      'subtitle': 'From location to parking in 1 hour limit',
      'icon': 'lib/assets/images/vehicle pickup.png',
      'isSelected': false,
    },
    {
      'title': 'Customer Pickup/Drop-off',
      'price': 'AED 50',
      'subtitle': 'From location to parking in 1 hour limit',
      'icon': 'lib/assets/images/customer pickup.png',
      'isSelected': false,
    },
  ];

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void setParkingType(String type) {
    selectedParkingType = type;
    update();
  }

  void setMembership(String membership) {
    selectedMembership = membership;
    update();
  }

  void toggleAddon(int index) {
    addonServices[index]['isSelected'] = !addonServices[index]['isSelected'];
    update();
  }

  void onNextClick() {
    Get.to(
      () => PaymentView(
        title: 'Booking Payment',
        subtitle: '$selectedParkingType Parking',
        amount: 'AED 700.00',
        subtotal: 'AED 700.00',
        vat: 'AED 35.00',
        details: [
          {
            'label': 'Vehicle',
            'value': selectedVehicleData?['vehicle_type_name'] ?? 'N/A',
          },
          {'label': 'Membership', 'value': selectedMembership},
          {'label': 'Type', 'value': selectedParkingType},
        ],
      ),
    );
  }

  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
