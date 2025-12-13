import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class UniversalFilterBar extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final bool isDark;
  final Map<String, int> filterCounts;
  final Map<String, Color>?
  filterColors; // Optional custom colors for each filter

  const UniversalFilterBar({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.isDark,
    required this.filterCounts,
    this.filterColors,
  });

  Color getFilterColor(String filter) {
    // If custom colors are provided, use them
    if (filterColors != null && filterColors!.containsKey(filter)) {
      return filterColors![filter]!;
    }

    // Default color mapping based on common filter types
    switch (filter.toLowerCase()) {
      case 'all':
        return isDark ? kApple : kZeiti;
      case 'active':
        return const Color(0xff4fbe6f); // Green
      case 'inactive':
        return Colors.grey[600]!; // Grey
      case 'blocked':
        return Colors.red; // Red
      case 'pending':
        return kOrange; // Orange
      case 'upcoming':
        return kKiwi; // Yellow/Green
      case 'current':
        return const Color(0xff4fbe6f); // Green
      case 'cancelled':
        return Colors.red; // Red
      // case 'unread':
      //   return kKiwi; // Yellow/Green for unread messages
      default:
        return isDark ? kApple : kZeiti; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          final count = filterCounts[filter] ?? 0;
          final filterColor = getFilterColor(filter);

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
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                  if (count > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.3)
                            : (filter == 'All' || filter == 'Unread')
                            ? Colors.grey[300]
                            : filterColor.withValues(alpha: 0.2),
                        //(filter == 'All' || filter == 'Unread')? Colors.grey : filterColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : filterColor,
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
