import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white : kAfani,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}