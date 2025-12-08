// Helper functions for formatting and utilities

// Format DateTime to display string
String formatTimeChatPage(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inHours < 24) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays < 7) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[time.weekday - 1];
  } else {
    return '${time.day}/${time.month}/${time.year}';
  }
}


String formatDateChatDetailPage(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  final justDate = DateTime(date.year, date.month, date.day);

  if (justDate == today) return "Today";
  if (justDate == yesterday) return "Yesterday";

  return "${date.day} ${_monthName(date.month)}";
}

String _monthName(int month) {
  const months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];
  return months[month - 1];
}

