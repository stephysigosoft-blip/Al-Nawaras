import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PaymobService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://accept.paymob.com/api/',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  /// Step 1: Authentication
  Future<String?> authenticate(String apiKey) async {
    try {
      final response = await _dio.post(
        'auth/tokens',
        data: {'api_key': apiKey},
      );
      return response.data['token'];
    } on DioException catch (e) {
      debugPrint('Paymob Auth Error: $e');
      if (e.response != null) {
        debugPrint('Paymob Auth Error Response: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Paymob Auth Error: $e');
      return null;
    }
  }

  /// Step 2: Order Creation
  Future<int?> createOrder({
    required String authToken,
    required double amount,
    required String currency,
  }) async {
    try {
      // Amount in cents
      final amountCents = (amount * 100).toInt();

      final response = await _dio.post(
        'ecommerce/orders',
        data: {
          'auth_token': authToken,
          'delivery_needed': 'false',
          'amount_cents': amountCents.toString(),
          'currency': currency,
          'items': [],
        },
      );
      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Paymob Order Creation Error: $e');
      if (e.response != null) {
        debugPrint('Paymob Order Creation Error Response: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Paymob Order Creation Error: $e');
      return null;
    }
  }

  /// Step 3: Payment Key Request
  Future<String?> getPaymentKey({
    required String authToken,
    required int orderId,
    required double amount,
    required String currency,
    required String integrationId,
    required Map<String, String> billingData,
  }) async {
    try {
      final amountCents = (amount * 100).toInt();

      final response = await _dio.post(
        'acceptance/payment_keys',
        data: {
          'auth_token': authToken,
          'amount_cents': amountCents.toString(),
          'expiration': 3600,
          'order_id': orderId.toString(),
          'billing_data': {
            'apartment': 'NA',
            'email': billingData['email'] ?? 'NA',
            'floor': 'NA',
            'first_name': billingData['first_name'] ?? 'NA',
            'street': 'NA',
            'building': 'NA',
            'phone_number': billingData['phone_number'] ?? 'NA',
            'shipping_method': 'NA',
            'postal_code': 'NA',
            'city': 'NA',
            'country': 'NA',
            'last_name': billingData['last_name'] ?? 'NA',
            'state': 'NA',
          },
          'currency': currency,
          'integration_id': integrationId,
        },
      );
      return response.data['token'];
    } on DioException catch (e) {
      debugPrint('Paymob Payment Key Error: $e');
      if (e.response != null) {
        debugPrint('Paymob Payment Key Error Response: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Paymob Payment Key Error: $e');
      return null;
    }
  }
}
