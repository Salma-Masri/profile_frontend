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
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: kZeiti,
          ),
        ),
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
  Widget showCircleAvatar() {
    // ========================================
    // DEFAULT PROFILE IMAGE IMPLEMENTATION
    // ========================================
    // This shows a white silhouette on colored background when no profile image exists
    // Similar to Facebook's default profile picture
    // To revert: Replace the entire child with: Icon(Icons.person, size: 40, color: Colors.white)
    
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: kFistqi,
        backgroundImage: (user.profileImage != null && user.profileImage!.isNotEmpty)
            ? NetworkImage(user.profileImage!)
            : null,
        child: (user.profileImage == null || user.profileImage!.isEmpty)
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kFistqi
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     kFistqi,
                  //     // kKiwi.withValues(alpha: 0.8),
                  //   ],
                  // ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }

  Widget buildSettingRow(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required bool isDark,
    required Widget? trailing,
    required VoidCallback? onTap,
    bool isRotated = false,
  }) {
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
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompactButton({
    required String text,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
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

  AppBar showAppBar(bool isDark){
    return AppBar(
      centerTitle: true,
      title: Row(
        children: [
          Text(
            'Profile',
            style: TextStyle(
              color: isDark ? Colors.white : kZeiti,
              fontWeight: FontWeight.bold,
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

  Widget showBody(BuildContext context, bool isDark){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showNameAndProfile(context, isDark),
            const SizedBox(height: 20),
            // Preferences Section
            Text(
              'PREFERENCES',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : kZeiti,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Preferences Container (Combined)
           showPreferencesSettings(context, isDark),
            const SizedBox(height: 32),
            // Account Section
            Text(
              'ACCOUNT',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : kZeiti,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Account Container (Combined)
            showAccountSettings(context, isDark),
            const SizedBox(height: 32),
            // Logout Container (Standalone with pink color)
            showLogOutContainer(context),
          ],
        ),
      ),
    );
  }

  Widget showNameAndProfile(BuildContext context, bool isDark){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showCircleAvatar(),
        const SizedBox(width: 15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ aligns left with "Judy"
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
                // user.role!,
                'Tenant Account',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.grey[400] : kKiwi,
                ),
              ),

            const SizedBox(height: 1),

            // ✅ Buttons below "Renter"
            Row(
              children: [
                buildCompactButton(
                  text: 'Edit Profile',
                  isDark: isDark,
                  onPressed: () {
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
                  },
                ),
                const SizedBox(width: 8),
                buildCompactButton(
                  text: 'Switch to Landlord',
                  isDark: isDark,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget showPreferencesSettings(BuildContext context, bool isDark){
    return  Container(
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
      child: Column(
        children: [
          // Language Container
          buildSettingRow(
            context,
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguageSelectionPage(
                    languageProvider: languageProvider,
                    themeProvider: themeProvider,
                  ),
                ),
              );
            },
          ),
          Divider(
            height: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          // Dark/Light Mode Container
          buildSettingRow(
            context,
            icon: isDark ? LucideIcons.sun : LucideIcons.moon,
            color: isDark ? Colors.yellow : Colors.purple,
            title: isDark ? 'Light Mode' : 'Dark Mode',
            isDark: isDark,
            isRotated: !isDark,
            trailing: Transform.scale(
              scale: 0.85,
              child: CupertinoSwitch(
                value: isDark,
                activeColor: isDark ? Colors.grey[600]! : kZeiti,
                trackColor: isDark ? Colors.grey[800]! : kFistqi,
                thumbColor: Colors.white,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget showAccountSettings(BuildContext context, bool isDark){
    return  Container(
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
      child: Column(
        children: [
          // My Properties Container
          buildSettingRow(
            context,
            color: kOrange,
            icon: Icons.notifications,
            title: 'Notifications',
            isDark: isDark,
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey[400] : kZeiti,
            ),
            onTap: () {
              // Navigate to my properties
            },
          ),
          Divider(
            height: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          buildSettingRow(
            context,
            color: Colors.green,
            icon: Icons.payment,
            title: 'Payments',
            isDark: isDark,
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey[400] : kZeiti,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LandlordDashboard(
                    user: user,
                    themeProvider: themeProvider,
                  ),
                ),
              );
            },
          ),
          Divider(
            height: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          buildSettingRow(
            context,
            color: Colors.cyan,
            icon: Icons.message_sharp,
            title: 'Messages',
            isDark: isDark,
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey[400] : kZeiti,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatsPage(),
                ),
              );
            },
          ),
          Divider(
            height: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          // Security Container
          buildSettingRow(
            context,
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
      ),
    );
  }

  Widget showLogOutContainer(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showLogoutDialog(context);
          },
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
                  color: Colors.pink[700],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
