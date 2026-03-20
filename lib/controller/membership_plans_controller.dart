import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../view/payment/payment_view.dart';
import '../config/api_constants.dart';

class MembershipPlansController extends GetxController {
  List<Map<String, dynamic>> plans = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchMembershipPlans();
  }

  Future<void> fetchMembershipPlans() async {
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

      debugPrint('\n--- API REQUEST (memberships) ---');
      debugPrint('URL: ${ApiConstants.memberships}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.memberships,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (memberships) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List<dynamic> memberships = response.data['data']['memberships'];
          plans = memberships.map((m) {
            String featuresStr = m['list_of_features']?.toString() ?? "";
            List<String> features = featuresStr.isNotEmpty
                ? featuresStr.split(',').map((f) => f.trim()).toList()
                : ["Basic Membership Benefits"];

            return {
              'id': m['id'],
              'title': m['plan_type'] ?? 'Standard Plan',
              'price': 'AED ${m['plan_price']}',
              'unit': m['duration'] ?? 'month',
              'period': m['duration']?.toString().toLowerCase() ?? 'month',
              'features': features,
              'description': m['short_description'] ?? "",
            };
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching memberships: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void onSelectPlan(int index) {
    final plan = plans[index];
    Get.to(() => PaymentView(
          title: plan['title'],
          subtitle: 'Membership Subscription',
          amount: plan['price'],
          subtotal: plan['price'],
          vat: 'AED 0.00', // Assuming tax is inclusive or not required for simple memberships here for now
          details: [
            {'label': 'Plan Type', 'value': plan['title']},
            {'label': 'Validity', 'value': plan['unit'].replaceAll('per ', '')},
          ],
        ));
  }
}
