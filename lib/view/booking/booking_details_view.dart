import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class BookingDetailsView extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        elevation: 0,
        title: Text(
          S.of(context).bookingDetails,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE30613),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).referenceLabel.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking['reference'] ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        context,
                        Icons.category_outlined,
                        S.of(context).parkingType,
                        booking['title'] ?? 'N/A',
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.directions_car_outlined,
                        S.of(context).vehicle,
                        booking['subtitle']?.toString().split(' • ').first ??
                            'N/A',
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.info_outline,
                        'Vehicle Type',
                        booking['vehicle_type'] ?? 'N/A',
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.location_on_outlined,
                        S.of(context).locationLabel,
                        booking['location'] ?? 'N/A',
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.check_circle_outline,
                        'Status',
                        booking['status'] ?? 'N/A',
                        valueColor: booking['isActive'] == true
                            ? Colors.green.shade700
                            : Colors.orange.shade700,
                      ),
                      const Divider(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailRow(
                              context,
                              Icons.login,
                              S.of(context).startDateLabel,
                              booking['startDate'] ?? 'N/A',
                            ),
                          ),
                          Expanded(
                            child: _buildDetailRow(
                              context,
                              Icons.logout,
                              S.of(context).endDateLabel,
                              booking['endDate'] ?? 'N/A',
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.account_balance_wallet_outlined,
                        S.of(context).amountLabel,
                        booking['amount'] ?? 'N/A',
                      ),
                      if (booking['extra_amount'] != null &&
                          (booking['extra_amount'] as num) > 0) ...[
                        const Divider(height: 32),
                        _buildDetailRow(
                          context,
                          Icons.add_circle_outline,
                          'Extra Amount',
                          'AED ${booking['extra_amount']}',
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE30613).withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFE30613), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
