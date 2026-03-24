import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../widgets/draggable_help_button.dart';
import 'package:get/get.dart';
import '../booking/booking_history.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    // Media query for screen proportions
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 28),
            onPressed: () {
              Get.offAll(() => const BookingHistoryView());
            },
          ),
          SizedBox(width: padding),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  // Success Animation / Icon Placeholder
                  Container(
                    height: height * 0.12,
                    width: height * 0.12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: height * 0.08,
                        width: height * 0.08,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    S.of(context).paymentSuccessful,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    S.of(context).thankYou,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    S.of(context).paymentProcessedSuccessfully,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  // Summary Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryItem(S.of(context).monthlyMembership, S.of(context).shadedParkingDetail, isHeader: true),
                        const Divider(height: 30, thickness: 1),
                        _buildSummaryItem(S.of(context).vehicle, 'Airstream Caravel'),
                        _buildSummaryItem(S.of(context).duration, S.of(context).thirtyDays),
                        _buildSummaryItem(S.of(context).startDateLabel, '15 May 2023'),
                        _buildSummaryItem(S.of(context).endDateLabel, '15 Jun 2023'),
                        const Divider(height: 30, thickness: 1),
                        _buildSummaryItem(S.of(context).subtotalLabel, 'AED 1,500.00'),
                        _buildSummaryItem(S.of(context).vatLabel, 'AED 75.00'),
                        const Divider(height: 30, thickness: 1),
                        _buildSummaryItem(S.of(context).totalLabel, 'AED 1,575.00', isBold: true),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    S.of(context).confirmationEmailSent,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: height * 0.06),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const BookingHistoryView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE30613),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        S.of(context).close,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    S.of(context).needAssistanceCall,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ),
          const DraggableHelpButton(),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value,
      {bool isHeader = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isHeader ? 16 : 14,
              fontWeight: isHeader || isBold ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.black : Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHeader ? 16 : 14,
              fontWeight: isHeader || isBold ? FontWeight.bold : FontWeight.w600,
              color: isHeader ? const Color(0xFFE30613) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
