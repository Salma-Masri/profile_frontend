import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'quick_action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  final bool isDark;
  final VoidCallback onBookingsTap;
  final VoidCallback onPropertiesTap;
  final VoidCallback onAnalyticsTap;
  final VoidCallback onMessagesTap;

  const QuickActionsGrid({
    super.key,
    required this.isDark,
    required this.onBookingsTap,
    required this.onPropertiesTap,
    required this.onAnalyticsTap,
    required this.onMessagesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: 'Bookings',
                icon: LucideIcons.calendar,
                subtitle: 'Manage your bookings',
                onTap: onBookingsTap,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: 'Properties',
                icon: Icons.home_outlined,
                subtitle: 'View your properties',
                onTap: onPropertiesTap,
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: 'Analytics',
                icon: Icons.analytics_outlined,
                subtitle: 'View performance',
                onTap: onAnalyticsTap,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: 'Messages',
                icon: Icons.chat_outlined,
                subtitle: 'Check messages',
                onTap: onMessagesTap,
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}