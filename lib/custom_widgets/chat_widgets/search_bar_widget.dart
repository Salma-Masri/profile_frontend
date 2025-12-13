import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          width: 0.5,
        ),
        color: isDark ? Colors.grey[800] : kTiffahiFateh,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'Search chats...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.clear,
                color: isDark ? Colors.grey[400] : Colors.grey,
                size: 20,
              ),
              onPressed: onClear,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
