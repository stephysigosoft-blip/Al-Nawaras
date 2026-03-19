import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:get/get.dart';

class AdditionalServicesController extends GetxController {
  final List<Map<String, String>> services = [
    {
      'title': 'Battery Replacement',
      'image': 'lib/assets/images/battery.png',
      'description':
          'Includes battery health check, diagnostics, and complete battery replacement if needed. High-quality batteries only.',
      'price': 'AED 150',
    },
    {
      'title': 'Oil Change',
      'image': 'lib/assets/images/oil charge.png',
      'description':
          'Scheduled service with engine oil and oil filter change. Includes visual inspection of fluid levels and filters.',
      'price': 'AED 300',
    },
    {
      'title': 'Tire Change & Balancing',
      'image': 'lib/assets/images/tire change.png',
      'description':
          'Flat tire repair, tire replacement, and computerized wheel balancing. Can be done on-site.',
      'price': 'AED 80 per tire',
    },
    {
      'title': 'Cleaning Services',
      'image': 'lib/assets/images/cleaning.png',
      'description':
          'Options include basic pressure wash, vacuuming, dashboard cleaning and detailed upholstery care. Choose from exterior, interior or both.',
      'price': 'AED 50',
    },
    {
      'title': 'Towing',
      'image': 'lib/assets/images/Trolly.png',
      'description':
          'Professional towing service for caravans, boats, and trucks. Safe delivery from your location to Al Nawras Parking or vice versa within Dubai/Ajman area.',
      'price': 'AED 100',
    },
    {
      'title': 'Vehicle Pickup & Drop-off',
      'image': 'lib/assets/images/vehicle pickup.png',
      'description':
          'Have our team pick up or drop off your vehicle directly at your home or location. Concierge-level service.',
      'price': 'AED 120',
    },
    {
      'title': 'Customer Pickup & Drop-off',
      'image': 'lib/assets/images/customer pickup.png',
      'description':
          'Naswara provides seamless pickup and drop off from your home or location, delivering a truly concierge experience.',
      'price': 'AED 120',
    },
  ];

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
