import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/chat.dart';
import 'chat_avatar.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatItem({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // color: (chat.unreadCount > 0)? kKiwi : kOffWhite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ChatAvatar(
              imageUrl: chat.avatarUrl,
              fallbackLetter: chat.name[0].toUpperCase(),
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
                          color: kZeiti,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        chat.time,
                        style: TextStyle(
                          fontSize: (chat.unreadCount > 0)? 14 :12,
                          color: kZeiti,
                          fontWeight: (chat.unreadCount > 0)? FontWeight.bold : null,
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
                            fontWeight: (chat.unreadCount > 0) ? FontWeight.bold : null,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: kZeiti,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${chat.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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
    );
  }
}
