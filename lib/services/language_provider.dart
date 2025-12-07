import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'English';
  Locale _currentLocale = const Locale('en');

  String get currentLanguage => _currentLanguage;
  Locale get currentLocale => _currentLocale;

  void setLanguage(String language) {
    _currentLanguage = language;
    _currentLocale = language == 'Arabic' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  bool get isArabic => _currentLanguage == 'Arabic';
}