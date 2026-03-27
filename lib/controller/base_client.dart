import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../config/api_constants.dart';

class BaseClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  static Dio get dio => _dio;

  /// Centralized handling for Dio errors
  static void handleDioError(DioException e) {
    String errorMessage = 'A network error occurred. Please try again.';
    String title = 'Network Error';
    IconData icon = Icons.wifi_off;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      errorMessage =
          'Connection timeout. Please check your internet connection.';
    } else if (e.type == DioExceptionType.connectionError) {
      errorMessage =
          'Unable to connect to the server. Please verify your network.';
    } else if (e.type == DioExceptionType.badResponse) {
      title = 'Error';
      icon = Icons.error_outline;
      if (e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? 'Server error occurred.';
      } else {
        errorMessage = 'Server returned an invalid response.';
      }
    } else if (e.type == DioExceptionType.cancel) {
      errorMessage = 'Request was cancelled.';
    } else {
      errorMessage = 'An unexpected network error occurred.';
    }

    Get.snackbar(
      title,
      errorMessage,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(icon, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }
}
