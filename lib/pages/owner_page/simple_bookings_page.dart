import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../services/theme_provider.dart';

class SimpleBookingsPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  const SimpleBookingsPage({
    super.key,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? kApple : kZeiti,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bookings',
          style: TextStyle(
            color: isDark ? Colors.white : kZeiti,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bookings Page Works!',
              style: TextStyle(
                color: isDark ? Colors.white : kZeiti,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'The bookings page is working correctly.',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}