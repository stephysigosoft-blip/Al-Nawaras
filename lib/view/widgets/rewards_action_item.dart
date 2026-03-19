import 'package:flutter/material.dart';

class RewardsActionItem extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String points;

  const RewardsActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.035,
        horizontal: width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
      ),
      child: Row(
        children: [
          icon is IconData
              ? Icon(icon, color: const Color(0xFFE30613), size: 32)
              : Image(
                  image: icon as ImageProvider,
                  width: 32,
                  height: 32,
                  color: const Color(0xFFE30613),
                ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            points,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
