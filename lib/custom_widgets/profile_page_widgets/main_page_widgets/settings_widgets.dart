import 'package:flutter/material.dart';

import '../../../constants/colors.dart';


Widget SettingContainer(
    BuildContext context, {
      required IconData icon,
      required Color color,
      required String title,
      required Widget? trailing,
      required VoidCallback? onTap,
      bool isDestructive = false,
      bool? isDarkMode,
    }) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10), // ✅ round corners
                ),
                child: Icon(icon, color: isDestructive ? Colors.red : color),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDestructive
                      ? Colors.red
                      : (isDarkMode == true ? Colors.white : kZeiti),
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    ),
  );
}