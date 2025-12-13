import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/user.dart';

class UniversalAvatar extends StatelessWidget {
  // Image sources (in priority order)
  final File? imageFile; // Local file (highest priority)
  final String? imageUrl; // Network URL
  final String? assetPath; // Asset path

  // Fallback options
  final String? fallbackText; // Text to show when no image (e.g., initials)
  final IconData? fallbackIcon; // Icon to show when no image
  final Color? backgroundColor; // Background color for fallback

  // Styling options
  final double radius;

  // final bool showBorder;
  // final Color borderColor;
  // final double borderWidth;

  // User model (convenience constructor)
  final User? user;

  const UniversalAvatar({
    super.key,
    this.imageFile,
    this.imageUrl,
    this.assetPath,
    this.fallbackText,
    this.fallbackIcon,
    this.backgroundColor,
    required this.radius, //= 25,
    // this.showBorder = false,
    // this.borderColor = Colors.white,
    // this.borderWidth = 2,
    this.user,
  });

  // Convenience constructor for User objects
  // const UniversalAvatar.user({
  //   super.key,
  //   required User user,
  //   File? imageFile,
  //   double radius = 25,
  //   bool showBorder = false,
  //   Color borderColor = Colors.white,
  //   double borderWidth = 2,
  // }) : user = user,
  //      imageFile = imageFile,
  //      imageUrl = null,
  //      assetPath = null,
  //      fallbackText = null,
  //      fallbackIcon = Icons.person,
  //      backgroundColor = kFistqi,
  //      radius = radius,
  // showBorder = showBorder,
  // borderColor = borderColor,
  // borderWidth = borderWidth;

  // Convenience constructor for chat avatars
  // const UniversalAvatar.chat({
  //   super.key,
  //   required String imageUrl,
  //   required String fallbackText,
  //   double radius = 28,
  //   bool showBorder = true,
  //   Color borderColor = Colors.white,
  //   double borderWidth = 2,
  // }) : imageFile = null,
  //      imageUrl = imageUrl,
  //      assetPath = null,
  //      fallbackText = fallbackText,
  //      fallbackIcon = null,
  //      backgroundColor = null,
  //      user = null,
  //      radius = radius,
  //      showBorder = showBorder,
  //      borderColor = borderColor,
  //      borderWidth = borderWidth;
  //
  // // Convenience constructor for profile avatars
  // const UniversalAvatar.profile({
  //   super.key,
  //   String? imageUrl,
  //   File? imageFile,
  //   double radius = 40,
  //   bool showBorder = true,
  //   Color borderColor = Colors.white,
  //   double borderWidth = 3,
  // }) : imageFile = imageFile,
  //      imageUrl = imageUrl,
  //      assetPath = null,
  //      fallbackText = null,
  //      fallbackIcon = Icons.person,
  //      backgroundColor = kFistqi,
  //      user = null,
  //      radius = radius,
  //      showBorder = showBorder,
  //      borderColor = borderColor,
  //      borderWidth = borderWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: //showBorder
          /*? */ BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // borderColor,
              width: 2, //borderWidth,
            ),
          ),
      // : null,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: getBackgroundColor(isDark),
        backgroundImage: getBackgroundImage(),
        child: getChild(isDark),
      ),
    );
  }

  ImageProvider? getBackgroundImage() {
    // Priority: File > Network > Asset
    if (imageFile != null) {
      return FileImage(imageFile!);
    }

    // Check imageUrl first
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      if (imageUrl!.startsWith('http')) {
        return NetworkImage(imageUrl!);
      }
    }

    // Check user.profileImage if user is provided
    if (user != null &&
        user!.profileImage != null &&
        user!.profileImage!.isNotEmpty) {
      if (user!.profileImage!.startsWith('http')) {
        return NetworkImage(user!.profileImage!);
      }
    }

    if (assetPath != null && assetPath!.isNotEmpty) {
      return AssetImage(assetPath!);
    }

    return null;
  }

  Widget? getChild(bool isDark) {
    // If we have an image, don't show child
    if (getBackgroundImage() != null) {
      return null;
    }

    // Show fallback text if provided
    if (fallbackText != null && fallbackText!.isNotEmpty) {
      return Text(
        fallbackText!,
        style: TextStyle(
          fontSize: radius * 0.7,
          fontWeight: FontWeight.bold,
          color: getFallbackTextColor(isDark),
        ),
      );
    }

    // Show fallback icon
    if (fallbackIcon != null) {
      return Icon(fallbackIcon!, size: radius * 1.25, color: Colors.white);
    }

    // Default fallback
    return Icon(Icons.person, size: radius * 1.25, color: Colors.white);
  }

  Color getBackgroundColor(bool isDark) {
    if (backgroundColor != null) {
      return backgroundColor!;
    }

    // Default background colors based on context
    if (fallbackText != null) {
      return isDark
          ? kApple.withValues(alpha: 0.3)
          : kZeiti.withValues(alpha: 0.2);
    }

    return kFistqi;
  }

  Color getFallbackTextColor(bool isDark) {
    if (backgroundColor != null) {
      // Use contrasting color based on background
      return backgroundColor!.computeLuminance() > 0.5
          ? Colors.black87
          : Colors.white;
    }
    return isDark ? kApple : kZeiti;
  }
}
