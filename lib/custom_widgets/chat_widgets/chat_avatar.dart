import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ChatAvatar extends StatelessWidget {
  final String imageUrl;
  final String fallbackLetter;
  final double radius;

  const ChatAvatar({
    super.key,
    required this.imageUrl,
    required this.fallbackLetter,
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    // Check if imageUrl is a valid URL or asset path
    bool hasImage = imageUrl.isNotEmpty && 
                    (imageUrl.startsWith('http') || 
                     imageUrl.startsWith('assets/'));

    if (hasImage) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
        backgroundImage: imageUrl.startsWith('http')
            ? NetworkImage(imageUrl) as ImageProvider
            : AssetImage(imageUrl),
        onBackgroundImageError: (exception, stackTrace) {
          // If image fails to load, show fallback letter
        },
        child: null,
      );
    }

    // Fallback to letter avatar
    return CircleAvatar(
      radius: radius,
      backgroundColor: kZeiti.withOpacity(0.2),
      child: Text(
        fallbackLetter,
        style: TextStyle(
          fontSize: radius * 0.7,
          fontWeight: FontWeight.bold,
          color: kZeiti,
        ),
      ),
    );
  }
}
