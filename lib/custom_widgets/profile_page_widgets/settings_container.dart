import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  final List<Widget> children;

  const SettingsContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: buildChildrenWithDividers(isDark),
      ),
    );
  }

  List<Widget> buildChildrenWithDividers(bool isDark) {
    final List<Widget> widgets = [];
    
    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      
      // Add divider between items (but not after the last item)
      if (i < children.length - 1) {
        widgets.add(
          Divider(
            height: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
        );
      }
    }
    
    return widgets;
  }
}