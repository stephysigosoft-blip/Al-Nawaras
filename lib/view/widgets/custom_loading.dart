import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;
  
  const CustomLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? const Color(0xFFE30613), // Default red color
        ),
      ),
    );
  }
}
