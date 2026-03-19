import 'package:flutter/material.dart';

class CustomLogos {
  static Widget buildMastercard() {
    return SizedBox(
      width: 28,
      height: 18,
      child: Stack(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            left: 10,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.85),
                shape: BoxShape.circle,
              ), // ignore: deprecated_member_use
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildApplePay() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.apple, color: Colors.black, size: 20),
        Text(
          'Pay',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  static Widget buildGooglePay(double width) {
    return Image.asset(
      'lib/assets/images/GPay_Acceptance_Mark.png',
      width: width * 0.13,
      height: width * 0.1,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.payment, size: width * 0.1, color: Colors.blue),
    );
  }

  static Widget buildPayPal(double width) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: width * 0.06,
          child: Image.asset(
            'lib/assets/images/PayPal-Monogram.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.payment, size: width * 0.06, color: Colors.blue),
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          'PayPal',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  static Widget buildNolPay(double width) {
    return Column(
      children: [
        Image.asset(
          'lib/assets/images/nolpay.png',
          width: width * 0.1,
          height: width * 0.06,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.credit_card, size: width * 0.06, color: Colors.orange),
        ),
        Text(
          'Pay',
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  static Widget buildCashOnSite(double width) {
    return Image.asset(
      'lib/assets/images/cashonsite.png',
      width: width * 0.1,
      height: width * 0.06,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.money_off, size: width * 0.06, color: Colors.green),
    );
  }
}
