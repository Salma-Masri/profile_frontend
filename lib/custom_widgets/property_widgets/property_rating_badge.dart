import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class PropertyRatingBadge extends StatelessWidget {
  final double rating;
  final bool isDark;

  const PropertyRatingBadge({
    super.key,
    required this.rating,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? kApple : kZeiti,
          width: 0.2,
        ),
        color: isDark 
            ? kApple.withValues(alpha: 0.2)
            : kAfathGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 12,
            color: isDark ? kOrange : kZeiti,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: TextStyle(
              color: isDark ? kOrange : kZeiti,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}