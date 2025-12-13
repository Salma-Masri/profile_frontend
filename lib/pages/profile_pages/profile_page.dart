import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:testprofile/constants/colors.dart';
import 'package:testprofile/services/theme_provider.dart';
import 'package:testprofile/services/language_provider.dart';
import 'package:testprofile/services/api.dart';
import 'package:testprofile/models/user.dart';
import 'package:testprofile/pages/profile_pages/edit_profile_page.dart';
import 'package:testprofile/pages/profile_pages/language_selection_page.dart';
import 'package:testprofile/pages/chat_pages/chat_page.dart';
import 'package:testprofile/pages/owner_page/landlord_dashboard.dart';
import 'package:testprofile/custom_widgets/common/universal_avatar.dart';
import 'package:testprofile/custom_widgets/profile_page_widgets/setting_row.dart';

import '../../custom_widgets/profile_page_widgets/profile_button.dart';
import '../../custom_widgets/profile_page_widgets/settings_container.dart';

class ProfilePage extends StatelessWidget {
  final ThemeProvider themeProvider;
  final LanguageProvider languageProvider;
  final User user;
  final Function(User) onUserUpdated;
  final VoidCallback? onLogout;

  const ProfilePage({
    super.key,
    required this.themeProvider,
    required this.languageProvider,
    required this.user,
    required this.onUserUpdated,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      appBar: showAppBar(isDark),
      body: showBody(context, isDark),
    );
  }

  void showLogoutDialog(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Log Out',
          style: TextStyle(color: isDark ? Colors.white : kZeiti),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: isDark ? Colors.grey[300] : Colors.grey[700]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: isDark ? Colors.grey[300] : kKiwi),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await performLogout(context);
            },
            child: const Text('Log Out', style: TextStyle(color: kOrange)),
          ),
        ],
      ),
    );
  }

  Future<void> performLogout(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            const Center(child: CircularProgressIndicator(color: kZeiti)),
      );

      // Call logout API
      await Api.logout();

      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Call the logout callback if provided
      if (onLogout != null) {
        onLogout!();
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out successfully'),
            backgroundColor: kKiwi,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to logout: $e'),
            backgroundColor: kOrange,
          ),
        );
      }
    }
  }

  AppBar showAppBar(bool isDark) {
    return AppBar(
      centerTitle: true,
      title: Row(
        children: [
          Text(
            'Profile',
            style: TextStyle(
              color: isDark ? Colors.white : kZeiti,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            LucideIcons.settings,
            color: isDark ? Colors.white : kZeiti,
          ),
          onPressed: () {
            // Navigate to settings
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: isDark ? Colors.grey[800] : Colors.grey[300],
        ),
      ),
    );
  }

  Widget showBody(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, isDark),
            const SizedBox(height: 20),
            Text(
              'PREFERENCES',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : kAfani,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            buildPreferencesSettings(context, isDark),
            const SizedBox(height: 32),
            Text(
              'ACCOUNT',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : kAfani,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            buildAccountSettings(context, isDark),
            const SizedBox(height: 32),
            // Logout Container (Standalone with pink color)
            buildLogOutContainer(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UniversalAvatar(user: user, radius: 40),
        // UniversalAvatar.user(user: user, showBorder: true),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : kZeiti,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
            if (user.role != null)
              Text(
                'Tenant Account',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.grey[400] : kAfani,
                ),
              ),
            const SizedBox(height: 1),
            Row(
              children: [
                ProfileButton(
                  text: 'Edit Profile',
                  isDark: isDark,
                  onPressed: () => navigateToEditProfile(context),
                ),
                const SizedBox(width: 8),
                ProfileButton(
                  text: 'Switch to Landlord',
                  isDark: isDark,
                  onPressed: () => navigateToLandlordDashboard(context),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPreferencesSettings(BuildContext context, bool isDark) {
    return SettingsContainer(
      children: [
        SettingRow(
          icon: LucideIcons.languages,
          color: Colors.blueAccent,
          title: 'Language',
          isDark: isDark,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languageProvider.currentLanguage,
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : kZeiti,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[400] : kZeiti,
              ),
            ],
          ),
          onTap: () => navigateToLanguageSelection(context),
        ),
        SettingRow(
          icon: isDark ? LucideIcons.sun : LucideIcons.moonStar,
          color: isDark ? Colors.yellow : Colors.purple,
          title: isDark ? 'Light Mode' : 'Dark Mode',
          isDark: isDark,
          isRotated: !isDark,
          trailing: Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isDark,
              activeColor: isDark ? Colors.grey[600]! : kZeiti,
              trackColor: isDark ? Colors.grey[800]! : kFistqi,
              thumbColor: Colors.white,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAccountSettings(BuildContext context, bool isDark) {
    return SettingsContainer(
      children: [
        SettingRow(
          icon: Icons.notifications,
          color: kOrange,
          title: 'Notifications',
          isDark: isDark,
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[400] : kZeiti,
          ),
          onTap: () {
            // Navigate to notifications
          },
        ),
        SettingRow(
          icon: Icons.payment,
          color: Colors.green,
          title: 'Payments',
          isDark: isDark,
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[400] : kZeiti,
          ),
          onTap: () {
            // Navigate to payments
          },
        ),
        SettingRow(
          icon: Icons.message_sharp,
          color: Colors.cyan,
          title: 'Messages',
          isDark: isDark,
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[400] : kZeiti,
          ),
          onTap: () => navigateToMessages(context),
        ),
        SettingRow(
          icon: Icons.security,
          color: Colors.indigo,
          title: 'Security',
          isDark: isDark,
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[400] : kZeiti,
          ),
          onTap: () {
            // Navigate to security settings
          },
        ),
      ],
    );
  }

  Widget buildLogOutContainer(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.red[900]!.withValues(alpha: 0.3) : kTiffahiFateh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => showLogoutDialog(context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: isDark ? Colors.red[300] : kOrange,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.red[300] : kOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigation methods
  void navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          user: user,
          themeProvider: themeProvider,
          onUserUpdated: onUserUpdated,
        ),
      ),
    );
  }

  void navigateToLandlordDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LandlordDashboard(user: user, themeProvider: themeProvider),
      ),
    );
  }

  void navigateToLanguageSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LanguageSelectionPage(
          languageProvider: languageProvider,
          themeProvider: themeProvider,
        ),
      ),
    );
  }

  void navigateToMessages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatsPage()),
    );
  }
}
