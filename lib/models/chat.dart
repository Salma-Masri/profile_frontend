// Model class representing a chat conversation
// This is a UI model - backend doesn't have a "chats" table
// We build this from the messages table by grouping messages by user
class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl; // Profile image URL or path
  final int unreadCount;
  final DateTime lastMessageTime;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  // Create Chat from the last message with a user
  // NOTE TO BACKEND: We need an endpoint that returns:
  // - List of unique users I've chatted with
  // - Their last message
  // - Count of unread messages (messages where receiver_id = my_id and some "read" flag is false)
  // Suggested endpoint: GET /api/chats
  // Response: [{ "user_id": "2", "user_name": "John", "last_message": {...}, "unread_count": 3 }]
  factory Chat.fromJson(Map<String, dynamic> json) {
    final lastMessage = json['last_message'];
    final createdAt = DateTime.parse(lastMessage['created_at']);
    return Chat(
      id: json['user_id'].toString(),
      name: json['user_name'] ?? 'Unknown User',
      lastMessage: lastMessage['content'],
      time: formatTime(createdAt),
      avatarUrl: (json['user_name'] ?? 'U')[0].toUpperCase(),
      lastMessageTime: createdAt,
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  // Format DateTime to display string
  static String formatTime(DateTime time) {
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
}
