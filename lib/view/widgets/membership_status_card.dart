import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class MembershipStatusCard extends StatelessWidget {
  final double width;
  final String status;
  final List? vehicles;
  final List? bookings;
  final List? services;

  const MembershipStatusCard({
    super.key,
    required this.width,
    required this.status,
    required this.vehicles,
    required this.bookings,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).membershipStatusLabel,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  S.of(context).activeStatus,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBox(S.of(context).myVehicles, (vehicles?.length ?? 0).toString(), width),
              _buildStatBox(S.of(context).bookings, (bookings?.length ?? 0).toString(), width),
              _buildStatBox(S.of(context).services, (services?.length ?? 0).toString(), width),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, double width) {
    return Container(
      width: width * 0.26, // Dynamic sizing
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
