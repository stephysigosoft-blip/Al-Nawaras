import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final int index;
  final String title;
  final Widget trailing;
  final double width;
  final bool isSelected;
  final bool isExpanded;
  final Widget? expandedContent;
  final VoidCallback? onTap;

  const PaymentMethodItem({
    super.key,
    required this.index,
    required this.title,
    required this.trailing,
    required this.width,
    this.isSelected = false,
    this.isExpanded = false,
    this.expandedContent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: isSelected ? 2 : 0,
        ),
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              Row(
                children: [
                  Radio<int>(
                    value: index,
                    groupValue: isSelected ? index : -1,
                    onChanged: (value) => onTap?.call(),
                    activeColor: Colors.blue,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.35),
                    child: trailing,
                  ),
                ],
              ),
              if (isExpanded && expandedContent != null) ...[expandedContent!],
            ],
          ),
        ),
      ),
    );
  }
}
