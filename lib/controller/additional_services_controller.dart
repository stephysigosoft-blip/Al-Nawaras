import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';

class AdditionalServicesController extends GetxController {
  List<Map<String, dynamic>> services = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    isLoading = true;
    update();

    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (services) ---');
      debugPrint('URL: ${ApiConstants.services}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.services,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (services) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List<dynamic> servicesData =
              response.data['data']['services'] ?? [];

          services = servicesData.map((s) {
            String title = s['service_name'] ?? 'Service';
            return {
              'id': s['id']?.toString() ?? '',
              'title': title,
              'image': _getServiceImage(title),
              'description': s['description'] ?? 'No description available.',
              'price': 'AED ${s['price'] ?? '0'}',
            };
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching services: $e');
    } finally {
      isLoading =
          true; // Temporary keep true if data is empty as per user response? No, false.
      isLoading = false;
      update();
    }
  }

  String _getServiceImage(String title) {
    String lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('battery')) return 'lib/assets/images/battery.png';
    if (lowerTitle.contains('oil')) return 'lib/assets/images/oil charge.png';
    if (lowerTitle.contains('tire')) return 'lib/assets/images/tire change.png';
    if (lowerTitle.contains('cleaning'))
      return 'lib/assets/images/cleaning.png';
    if (lowerTitle.contains('towing')) return 'lib/assets/images/Trolly.png';
    if (lowerTitle.contains('vehicle pickup'))
      return 'lib/assets/images/vehicle pickup.png';
    if (lowerTitle.contains('customer pickup'))
      return 'lib/assets/images/customer pickup.png';
    return 'lib/assets/images/battery.png'; // Default
  }

  void onBuyNowClick(int index) {
    final service = services[index];
    Get.to(
      () => PaymentView(
        title: service['title'],
        subtitle: 'Additional Service',
        amount: service['price'],
        subtotal: service['price']!,
        vat: 'AED 0.00',
        details: [
          {'label': 'Service', 'value': service['title']!},
        ],
      ),
    );
  }
}
