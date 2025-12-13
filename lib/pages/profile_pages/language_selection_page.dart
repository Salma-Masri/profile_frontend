import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:testprofile/constants/colors.dart';
import 'package:testprofile/services/language_provider.dart';
import 'package:testprofile/services/theme_provider.dart';

class LanguageSelectionPage extends StatelessWidget {
  final LanguageProvider languageProvider;
  final ThemeProvider themeProvider;

  const LanguageSelectionPage({
    super.key,
    required this.languageProvider,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language',
          style: TextStyle(
            color: isDark ? Colors.white : kZeiti,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : kZeiti),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildLanguageOption(
              context,
              'English',
              'English',
              languageProvider.currentLanguage == 'English',
              isDark,
            ),
            const SizedBox(height: 12),
            buildLanguageOption(
              context,
              'العربية',
              'Arabic',
              languageProvider.currentLanguage == 'Arabic',
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageOption(
    BuildContext context,
    String displayName,
    String languageCode,
    bool isSelected,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: kZeiti, width: 2)
            : Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            languageProvider.setLanguage(languageCode);
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  LucideIcons.languages,
                  color: isSelected
                      ? kZeiti
                      : (isDark ? Colors.grey[400] : Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    displayName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? kZeiti
                          : (isDark ? Colors.white : kZeiti),
                    ),
                  ),
                ),
                if (isSelected) const Icon(Icons.check_circle, color: kZeiti),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
