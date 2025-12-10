import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../custom_widgets/chat_widgets/chat_item.dart';
import '../../custom_widgets/chat_widgets/search_bar_widget.dart';
import '../../models/chat.dart';
import '../../services/chat_service/chat_service.dart';
import '../../util/helpers.dart';
import '../../util/mock/app_config.dart';
import '../../util/mock/mock_chat_service.dart';
import 'chat_detail_page.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => ChatsPageState();
}

class ChatsPageState extends State<ChatsPage> {
  List<Chat> allChats = [];
  List<Chat> searchedChats = [];
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  dynamic get chatService => AppConfig.useMockData ? MockChatService() : ChatService();

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  Future<void> loadChats() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final chats = await chatService.getChats();
      setState(() {
        allChats = chats;
        sortChats();
        searchedChats = allChats;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load chats: $e'),
            backgroundColor: kApple,
            action: SnackBarAction(
              label: 'Retry',
              textColor: kZeiti,
              onPressed: loadChats,
            ),
          ),
        );
      }
    }
  }

  void sortChats() {
    allChats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  }

  void searchChats(String query) {
    setState(() {
      if (query.isEmpty) {
        searchedChats = allChats;
      } else {
        searchedChats = [];
        for (var chat in allChats) {
          if (chat.name.toLowerCase().contains(query.toLowerCase())) {
            searchedChats.add(chat);
          }
        }
      }
    });
  }

  void clearSearch() {
    _searchController.clear();
    searchChats('');
  }

  void markChatAsRead(String chatId) {
    setState(() {
      for (int i = 0; i < allChats.length; i++) {
        if (allChats[i].id == chatId) {
          allChats[i] = Chat(
            id: allChats[i].id,
            name: allChats[i].name,
            lastMessage: allChats[i].lastMessage,
            time: allChats[i].time,
            avatarUrl: allChats[i].avatarUrl,
            unreadCount: 0,
            lastMessageTime: allChats[i].lastMessageTime,
          );
          break;
        }
      }
      searchChats(_searchController.text);
    });
  }

  void updateChatWithNewMessage(String chatId, String newMessage) {
    setState(() {
      for (int i = 0; i < allChats.length; i++) {
        if (allChats[i].id == chatId) {
          final now = DateTime.now();
          allChats[i] = Chat(
            id: allChats[i].id,
            name: allChats[i].name,
            lastMessage: newMessage,
            time: formatTimeChatPage(now),
            avatarUrl: allChats[i].avatarUrl,
            unreadCount: 0,
            lastMessageTime: now,
          );
          break;
        }
      }
      sortChats();
      searchChats(_searchController.text);
    });
  }

  void openChat(Chat chat) {
    markChatAsRead(chat.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChatDetailPage(
            chat: chat,
            onMessageSent: (String message) {
              updateChatWithNewMessage(chat.id, message);
            },
          );
        },
      ),
    );
  }

  int getTotalUnreadCount() {
    int total = 0;
    for (var chat in allChats) {
      total += chat.unreadCount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
      appBar: buildAppBar(),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: searchChats,
            onClear: clearSearch,
          ),
          Expanded(
            child: buildBody(),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: kZeiti),
      );
    }

    if (errorMessage != null) {
      return buildErrorState();
    }

    if (searchedChats.isEmpty) {
      return buildEmptyState();
    }

    return buildChatList();
  }

  Widget buildErrorState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: kApple),
          const SizedBox(height: 16),
          Text(
            'Failed to load chats',
            style: TextStyle(fontSize: 18, color: isDark ? Colors.white : kZeiti),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              errorMessage ?? 'Unknown error',
              style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : kZeiti),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: loadChats,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.grey[700] : kZeiti,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: isDark ? Colors.grey[600] : Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No chats found',
            style: TextStyle(fontSize: 18, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget buildChatList() {
    return ListView.builder(
      itemCount: searchedChats.length,
      itemBuilder: (context, index) {
        final chat = searchedChats[index];
        return ChatItem(
          chat: chat,
          onTap: () {
            openChat(chat);
          },
        );
      },
    );
  }



  AppBar buildAppBar() {
    int totalUnread = getTotalUnreadCount();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
      title: Row(
        children: [
          Text(
            'Messages',
            style: TextStyle(
              color: isDark ? Colors.white : kZeiti,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (totalUnread > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isDark ? kKiwi: kZeiti,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$totalUnread',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh, color: isDark ? Colors.white : kZeiti),
          onPressed: isLoading ? null : loadChats,
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: isDark ? Colors.white : kZeiti),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
