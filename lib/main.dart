import 'package:flutter/material.dart';
import 'package:testprofile/constants/colors.dart';
import 'package:testprofile/pages/profile_pages/profile_page.dart';
import 'package:testprofile/services/theme_provider.dart';
import 'package:testprofile/services/language_provider.dart';
import 'package:testprofile/models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();
  final LanguageProvider _languageProvider = LanguageProvider();

  // Sample user - replace this with actual data from backend
  User _currentUser = User(
    id: 1,
    firstName: 'Judy',
    lastName: 'Aaa',
    role: 'Renter',
    email: 'judy@gmail.com',
    phoneNumber: '+1234567890',
    city: '',
    country: '',
    profileImage: 'https://i.pravatar.cc/150?img=5',//https://i.pravatar.cc/150?img=5
  );

  void _updateUser(User updatedUser) {
    setState(() {
      _currentUser = updatedUser;
    });
  }

  void _handleLogout() {
    // Handle logout - navigate to login screen or reset app state
    // For now, we'll just reset to a default user
    setState(() {
      _currentUser = User(
        firstName: 'Guest',
        lastName: 'User',
        role: 'Guest',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_themeProvider, _languageProvider]),
      builder: (context, child) {
        return MaterialApp(
          title: 'Profile App',
          debugShowCheckedModeBanner: false,
          theme: _themeProvider.lightTheme,
          darkTheme: _themeProvider.darkTheme,
          themeMode: _themeProvider.themeMode,
          home: ProfilePage(
            themeProvider: _themeProvider,
            languageProvider: _languageProvider,
            user: _currentUser,
            onUserUpdated: _updateUser,
            onLogout: _handleLogout,
          ),
        );
      },
    );
  }
}


//
// import 'package:chat/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'pages/chats_page.dart';
//
// // Entry point of the app
// void main() {
//   runApp(const MyApp()); // Start the app
// }
//
// // Root widget of the application
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App', // App title
//       debugShowCheckedModeBanner: false, // Remove debug banner
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: kOffWhite), // Purple theme
//         useMaterial3: true, // Use Material 3 design
//       ),
//       home: const ChatsPage(), // Start with chats page
//     );
//   }
// }
