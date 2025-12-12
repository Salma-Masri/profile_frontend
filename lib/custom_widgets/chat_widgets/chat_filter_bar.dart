import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/chat.dart';

class ChatFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final bool isDark;
  final List<Chat> chats;

  const ChatFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.isDark,
    required this.chats,
  });

  int _getFilterCount(String filter) {
    if (filter == 'All') return chats.length;
    if (filter == 'Unread') {
      return chats.where((chat) => chat.unreadCount > 0).length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Unread'];
    
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          final count = _getFilterCount(filter);
          
          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? (isDark ? kKiwi : kZeiti)
                    : (isDark ? Colors.grey[800] : Colors.grey[300] ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected 
                      ? (isDark ? Colors.grey[700]! : kZeiti)
                      : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filter,
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white
                          : (isDark ? Colors.white : kZeiti),
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  if (count > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Colors.white.withValues(alpha: 0.3)
                            : (isDark ? Colors.white.withValues(alpha: 0.3) : kZeiti.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          color: isSelected 
                              ? Colors.white
                              : (isDark ? Colors.white.withValues(alpha: 0.3) : kZeiti),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}