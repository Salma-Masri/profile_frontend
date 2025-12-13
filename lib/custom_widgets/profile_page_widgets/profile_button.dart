import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDark;

  const ProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? Colors.grey[800] : kFistqi,
        foregroundColor: isDark ? Colors.white : kZeiti,
        minimumSize: const Size(0, 26),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark ? Colors.grey[600]! : kZeiti,
            width: 0.5,
          ),
        ),
      ),
      child: Text(text),
    );
  }
}