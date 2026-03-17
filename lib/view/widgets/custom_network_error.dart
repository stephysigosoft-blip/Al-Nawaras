import 'package:flutter/material.dart';

class CustomNetworkError extends StatelessWidget {
  final VoidCallback? onRetry;

  const CustomNetworkError({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: height * 0.1, color: Colors.grey),
          SizedBox(height: height * 0.02),
          const Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.01),
          const Text(
            'Please check your network and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: height * 0.04),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
              ),
              label: const Text('Try Again', style: TextStyle(color: Colors.white)),
            ),
          ]
        ],
      ),
    );
  }
}
