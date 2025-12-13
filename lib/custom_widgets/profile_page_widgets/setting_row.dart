import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SettingRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final bool isDark;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isRotated;

  const SettingRow({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.isDark,
    this.trailing,
    this.onTap,
    this.isRotated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Transform.rotate(
                  angle: isRotated ? -0.5 : 0,
                  child: Icon(icon, color: color, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : kZeiti,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}