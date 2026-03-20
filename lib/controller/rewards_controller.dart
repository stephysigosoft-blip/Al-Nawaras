import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';

class RewardsController extends GetxController {
  bool isLoading = false;
  Map<String, dynamic>? rewardsData;

  @override
  void onInit() {
    super.onInit();
    fetchRewardsData();
  }

  Future<void> fetchRewardsData() async {
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

      debugPrint('\n--- API REQUEST (rewards) ---');
      debugPrint('URL: ${ApiConstants.rewards}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.rewards,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (rewards) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          rewardsData = response.data['data'];
        }
      }
    } catch (e) {
      debugPrint('Error fetching rewards: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  String getMemberImage(String? type) {
    if (type == null) return 'lib/assets/images/Silver member.png';
    String lower = type.toLowerCase();
    if (lower.contains('silver')) return 'lib/assets/images/Silver member.png';
    if (lower.contains('gold')) return 'lib/assets/images/Silver member.png'; // Placeholder if gold not available
    return 'lib/assets/images/Silver member.png';
  }
}
