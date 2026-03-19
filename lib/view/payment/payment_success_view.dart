import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final padding = width * 0.06;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment Successful',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Text(
              'Thank you!',
              style: TextStyle(
                color: const Color(0xFFE30613),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your payment has been processed\nsuccessfully.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 24),
            _buildSummaryCard(width),
            const SizedBox(height: 24),
            Text(
              'A confirmation email and invoice have been\nsent to your registered email address.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Need assistance? Call us at 800-NAWRAS.',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Get.find<HomeController>().changeBottomNavIndex(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE30613),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSummaryCard(double width) {
    return Container(
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ), // ignore: deprecated_member_use
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monthly Membership',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text('Shaded Parking', style: TextStyle(fontSize: 12)),
              Spacer(),
              Text(
                'AED 1,500',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1),
          ),
          _buildDetailRow('Vehicle', 'Airstream Caravel'),
          const SizedBox(height: 8),
          _buildDetailRow('Duration', '30 Days'),
          const SizedBox(height: 8),
          _buildDetailRow('Start Date', '15 May 2023'),
          const SizedBox(height: 8),
          _buildDetailRow('End Date', '15 Jun 2023'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1),
          ),
          _buildTotalRow('Subtotal', 'AED 1,500.00'),
          const SizedBox(height: 8),
          _buildTotalRow('VAT (5%)', 'AED 75.00'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'AED 1,575.00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12)),
        Text(value, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  //   Widget _buildBottomNav() {
  //     return Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(
  //               0.05,
  //             ), // ignore: deprecated_member_use
  //             blurRadius: 10,
  //             offset: const Offset(0, -4),
  //           ),
  //         ],
  //       ),
  //       child: BottomNavigationBar(
  //         currentIndex: 0,
  //         type: BottomNavigationBarType.fixed,
  //         selectedItemColor: Colors.grey,
  //         unselectedItemColor: Colors.grey,
  //         showUnselectedLabels: true,
  //         selectedLabelStyle: const TextStyle(fontSize: 11),
  //         unselectedLabelStyle: const TextStyle(fontSize: 11),
  //         items: const [
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.home_outlined),
  //             label: 'Home',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.calendar_today_outlined),
  //             label: 'Bookings',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.build_outlined),
  //             label: 'Services',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.person_outline),
  //             label: 'Profile',
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}
