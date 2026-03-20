import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class CustomNoData extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const CustomNoData({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/no data.png', height: height * 0.12),
          SizedBox(height: height * 0.02),
          Text(
            message ?? S.of(context).noDataAvailable,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: height * 0.03),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
              ),
              child: Text(
                S.of(context).retry,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
