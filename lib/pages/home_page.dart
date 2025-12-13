import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../constants/colors.dart';
import '../services/theme_provider.dart';
import '../models/user.dart';
import '../custom_widgets/home_page_widgets/welcome_card.dart';
import '../custom_widgets/home_page_widgets/quick_actions_grid.dart';
import 'owner_page/bookings_page.dart';

class HomePage extends StatelessWidget {
  final ThemeProvider themeProvider;
  final User user;

  const HomePage({
    super.key,
    required this.themeProvider,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: TextStyle(
            color: isDark ? Colors.white : kZeiti,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              LucideIcons.calendar,
              color: isDark ? Colors.white : kZeiti,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingsPage(
                    themeProvider: themeProvider,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: isDark ? Colors.white : kZeiti,
              size: 20,
            ),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeCard(user: user, isDark: isDark),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: TextStyle(
                color: isDark ? Colors.white : kZeiti,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            QuickActionsGrid(
              isDark: isDark,
              onBookingsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingsPage(
                      themeProvider: themeProvider,
                    ),
                  ),
                );
              },
              onPropertiesTap: () {
                // Navigate to properties page
              },
              onAnalyticsTap: () {
                // Navigate to analytics page
              },
              onMessagesTap: () {
                // Navigate to messages
              },
            ),
          ],
        ),
      ),
    );
  }


}