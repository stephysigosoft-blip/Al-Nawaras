import 'package:flutter/material.dart';

class RewardsCard extends StatelessWidget {
  final double width;

  const RewardsCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.04,
            ), // ignore: deprecated_member_use
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'lib/assets/images/Silver member.png',
                width: width * 0.22,
                height: width * 0.22,
              ),
              SizedBox(width: width * 0.05),
              _buildPointsInfo(),
            ],
          ),
          SizedBox(height: width * 0.045),
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildPointsInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Silver Member',
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 2),
          Text(
            '1,250 Points',
            style: TextStyle(
              // fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Member Since Jan 2023',
            style: TextStyle(color: Colors.grey, fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: [
        const Text(
          'To Gold Member',
          style: TextStyle(
            color: Colors.black54,
            // fontWeight: FontWeight.bold,
            fontSize: 12.5,
          ),
        ),
        SizedBox(width: width * 0.03),
        Expanded(
          child: Container(
            height: width * 0.05,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.40, // fill progress factor
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade400,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
