import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class DateDivider extends StatelessWidget {
  final String text;

  const DateDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = Colors.grey[400];
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 0.5,
              color: lineColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? lineColor : kZeiti,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 0.5,
              color: lineColor,
            ),
          ),
        ],
      ),
    );
  }
}
