import 'package:flutter/material.dart';
import 'package:testprofile/constants/colors.dart';
import 'package:testprofile/pages/chat_pages/chat_page.dart';
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

  User _currentUser = User(
    id: 1,
    firstName: 'Judy',
    lastName: 'Aaa',
    role: 'Renter',
    email: 'judy@gmail.com',
    phoneNumber: '+1234567890',
    city: '',
    country: '',
    profileImage: 'https://i.pravatar.cc/150?img=5',
  );

  void _updateUser(User updatedUser) {
    setState(() {
      _currentUser = updatedUser;
    });
  }

  void _handleLogout() {
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
          home: MainShell(
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

// ------------------------------------------------------------
// MAIN SHELL WITH BOTTOM NAVIGATION
// ------------------------------------------------------------

class MainShell extends StatefulWidget {
  final ThemeProvider themeProvider;
  final LanguageProvider languageProvider;
  final User user;
  final Function(User) onUserUpdated;
  final VoidCallback onLogout;

  const MainShell({
    super.key,
    required this.themeProvider,
    required this.languageProvider,
    required this.user,
    required this.onUserUpdated,
    required this.onLogout,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Center(child: Text("Home Page")),
      const ChatsPage(),   // ✅ USE YOUR REAL CHATS PAGE
      ProfilePage(         // ✅ USE YOUR REAL PROFILE PAGE
        themeProvider: widget.themeProvider,
        languageProvider: widget.languageProvider,
        user: widget.user,
        onUserUpdated: widget.onUserUpdated,
        onLogout: widget.onLogout,
      ),
      const Center(child: Text("Settings Page")),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kZeiti,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() => _currentIndex = index);
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

/*
no bro, I mean that was my main:
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







 */

