import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class BookingFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final bool isDark;
  final List<Map<String, dynamic>> bookings;

  const BookingFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.isDark,
    required this.bookings,
  });

  int _getFilterCount(String filter) {
    if (filter == 'All') return bookings.length;
    return bookings.where((booking) => 
        booking['status'].toString().toLowerCase() == filter.toLowerCase()).length;
  }

  Color _getFilterColor(String filter) {
    switch (filter.toLowerCase()) {
      case 'upcoming':
        return kKiwi; // Yellow/Green
      case 'current':
        return const Color(0xff4fbe6f); // Green
      case 'pending':
        return kOrange; // Orange
      case 'cancelled':
        return Colors.red; // Red
      default:
        return isDark ? kApple : kZeiti; // Default color for 'All'
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Upcoming', 'Current', 'Pending', 'Cancelled'];
    
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          final count = _getFilterCount(filter);
          final filterColor = _getFilterColor(filter);
          
          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? filterColor
                    : (isDark ? Colors.grey[800] : Colors.grey[100]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected 
                      ? filterColor
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
                      fontSize: 14,
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
                            : filterColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          color: isSelected 
                              ? Colors.white
                              : filterColor,
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