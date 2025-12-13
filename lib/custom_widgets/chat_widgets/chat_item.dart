import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/chat.dart';
import '../common/universal_avatar.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: chat.unreadCount > 0
                  ? (isDark
                        ? Colors.teal[900]!.withValues(alpha: 0.3)
                        : kFistqi)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                UniversalAvatar(
                  imageUrl: chat.avatarUrl,
                  radius: 28,
                  fallbackText: chat.name[0].toUpperCase(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chat.name,
                            style: TextStyle(
                              color: isDark ? Colors.white : kZeiti,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            chat.time,
                            style: TextStyle(
                              fontSize: (chat.unreadCount > 0) ? 12 : 11,
                              color: isDark ? kKiwi : kZeiti,
                              fontWeight: (chat.unreadCount > 0)
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.lastMessage,
                              style: TextStyle(
                                fontSize: (chat.unreadCount > 0) ? 16 : 14,
                                fontWeight: (chat.unreadCount > 0)
                                    ? FontWeight.bold
                                    : null,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chat.unreadCount > 0)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isDark ? kKiwi : kZeiti,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${chat.unreadCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: isDark ? Colors.grey[800] : Colors.grey[300],
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
