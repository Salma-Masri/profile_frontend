import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class PropertyBookingBadge extends StatelessWidget {
  final int bookings;
  final bool isDark;

  const PropertyBookingBadge({
    super.key,
    required this.bookings,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isDark 
            ? kKiwi.withValues(alpha: 0.2)
            : kKiwi.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$bookings bookings',
        style: TextStyle(
          color: isDark ? kKiwi : kZeiti,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}