import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class PropertyFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final bool isDark;
  final List<Map<String, dynamic>> properties;

  const PropertyFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.isDark,
    required this.properties,
  });

  int getFilterCount(String filter) {
    if (filter == 'All') return properties.length;
    return properties.where((property) => 
        property['status'].toString().toLowerCase() == filter.toLowerCase()).length;
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Active', 'Inactive', 'Blocked', 'Pending'];
    
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          final count = getFilterCount(filter);
          
          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? (isDark ? kApple : kZeiti)
                    : (isDark ? Colors.grey[800] : Colors.grey[100]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected 
                      ? (isDark ? kApple : kZeiti)
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
                      fontSize: 12,
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
                            : (isDark ? kApple.withValues(alpha: 0.3) : kZeiti.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(10000),
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDark ? kApple : kZeiti),
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