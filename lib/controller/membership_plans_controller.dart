import 'package:get/get.dart';

class MembershipPlansController extends GetxController {
  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Hourly Plan',
      'price': 'AED 15',
      'unit': 'per hour',
      'features': [
        'Flexible parking duration',
        'Access to basic facilities',
        'Pay as you go',
      ],
    },
    {
      'title': 'Weekly Plan',
      'price': 'AED 500',
      'unit': 'per week',
      'features': [
        '7-day continuous parking',
        'Premium shaded parking spots',
        '10% discount on additional services',
        '1 free basic cleaning service',
      ],
    },
    {
      'title': 'Monthly Plan',
      'price': 'AED 1,500',
      'unit': 'per month',
      'features': [
        '28-day continuous parking',
        'Premium shaded parking spots',
        '20% discount on additional services',
        '2 free cleaning services',
        '1 free towing service',
      ],
    },
    {
      'title': '3 Months Plan',
      'price': 'AED 4,000',
      'unit': 'for 3 months',
      'features': [
        '90-day continuous parking',
        'Premium shaded parking spots',
        '25% discount on additional services',
        '5 free cleaning services',
        '1 free towing service',
      ],
    },
    {
      'title': '6 Months Plan',
      'price': 'AED 7,500',
      'unit': 'for 6 months',
      'features': [
        '180-day continuous parking',
        'Premium shaded parking spots',
        '25% discount on additional services',
        '8 free cleaning services',
        '2 free towing services',
      ],
    },
    {
      'title': '1 Year Plan',
      'price': 'AED 14,000',
      'unit': 'for a Year',
      'features': [
        '365-day continuous parking',
        'Premium shaded parking spots',
        '25% discount on additional services',
        '12 free cleaning services',
        '6 free towing services',
      ],
    },
  ];

  void onSelectPlan(int index) {
    // Handle plan selection
    Get.snackbar('Plan Selected', 'You selected the ${plans[index]['title']}');
  }
}
