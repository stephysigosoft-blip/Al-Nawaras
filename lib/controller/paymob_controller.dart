import 'package:al_nawaras/controller/base_client.dart';
import 'package:al_nawaras/controller/paymob_service.dart';
import 'package:al_nawaras/controller/profile_controller.dart';
import 'package:al_nawaras/model/app_settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../config/api_constants.dart';

class PaymobController extends GetxController {
  final PaymobService _paymobService = PaymobService();
  
  bool isLoading = false;
  PaymobConfig? paymobConfig;

  Future<void> fetchPaymobSettings() async {
    isLoading = true;
    update();

    try {
      final response = await BaseClient.dio.get(ApiConstants.appSettings);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final settingsModel = AppSettingsModel.fromJson(response.data);
        paymobConfig = settingsModel.paymobConfig;

        // TEMPORARY: Hardcoding for testing
        paymobConfig = PaymobConfig(
          apiKey: 'YOUR_PAYMOB_SECRET_KEY', // Replace with sec_...
          integrationId: 'YOUR_INTEGRATION_ID', 
          iframeId: 'YOUR_IFRAME_ID',
        );
        debugPrint('USING HARDCODED PAYMOB CONFIG FOR TESTING');
      }
    } catch (e) {
      debugPrint('Error fetching Paymob settings: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<String?> getPaymentToken({
    required double amount,
    required String currency,
  }) async {
    if (paymobConfig == null) await fetchPaymobSettings();
    if (paymobConfig == null || paymobConfig!.apiKey == null) {
      Get.snackbar('Error', 'Could not load payment configuration');
      return null;
    }

    isLoading = true;
    update();

    try {
      String? authToken;
      
      // Check if the provided apiKey is actually already a JWT token
      // JWTs commonly start with 'eyJ' which is 'ZXlK' in Base64
      if (paymobConfig!.apiKey!.startsWith('ey') || paymobConfig!.apiKey!.startsWith('ZXl')) {
        debugPrint('Detected apiKey as JWT, skipping authentication step...');
        authToken = paymobConfig!.apiKey;
      } else {
        // 1. Authenticate
        authToken = await _paymobService.authenticate(paymobConfig!.apiKey!);
      }
      
      if (authToken == null) throw Exception('Auth failed');

      // 2. Create Order
      final orderId = await _paymobService.createOrder(
        authToken: authToken,
        amount: amount,
        currency: currency,
      );
      if (orderId == null) throw Exception('Order creation failed');
      debugPrint('Paymob Order Created: $orderId');

      // 3. Get Billing Data
      final profileCtrl = Get.find<ProfileController>();
      final fullName = profileCtrl.profile.value?.name ?? 'Guest User';
      final nameParts = fullName.split(' ');
      final firstName = nameParts.first;
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'NA';

      final billingData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': profileCtrl.profile.value?.email ?? 'na@example.com',
        'phone_number': profileCtrl.profile.value?.mobile ?? '00000000',
      };

      // 4. Get Payment Key
      if (paymobConfig!.integrationId == null || paymobConfig!.integrationId!.isEmpty) {
        debugPrint('WARNING: Integration ID is missing. Handshake will likely fail.');
        // throw Exception('Integration ID is missing in configuration');
      }

      final paymentToken = await _paymobService.getPaymentKey(
        authToken: authToken,
        orderId: orderId,
        amount: amount,
        currency: currency,
        integrationId: paymobConfig!.integrationId!,
        billingData: billingData,
      );
      
      if (paymentToken == null) throw Exception('Failed to get payment key');
      debugPrint('Paymob Payment Key Received: $paymentToken');

      return paymentToken;
    } catch (e) {
      debugPrint('Paymob Handshake Error: $e');
      Get.snackbar('Payment Error', e.toString().replaceFirst('Exception: ', ''));
      return null;
    } finally {
      isLoading = false;
      update();
    }
  }
}
