import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class PropertyStatusBadge extends StatelessWidget {
  final String status;
  final bool isDark;

  const PropertyStatusBadge({
    super.key,
    required this.status,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'active':
        borderColor = const Color(0xff4fbe6f);
        backgroundColor = isDark 
            ? const Color(0xff4fbe6f).withValues(alpha: 0.2)
            : const Color(0xffe7fced);
        textColor = const Color(0xff4fbe6f);
        break;
      case 'inactive':
        borderColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
        backgroundColor = isDark 
            ? Colors.grey[800]!.withValues(alpha: 0.5)
            : Colors.grey.withValues(alpha: 0.3);
        textColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
        break;
      case 'blocked':
        borderColor = Colors.red;
        backgroundColor = isDark 
            ? Colors.red.withValues(alpha: 0.2)
            : Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        break;
      case 'pending':
        borderColor = kOrange;
        backgroundColor = isDark 
            ? kOrange.withValues(alpha: 0.2)
            : kOrange.withValues(alpha: 0.1);
        textColor = kOrange;
        break;
      default:
        borderColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
        backgroundColor = isDark 
            ? Colors.grey[800]!.withValues(alpha: 0.5)
            : Colors.grey.withValues(alpha: 0.3);
        textColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 0.2,
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}