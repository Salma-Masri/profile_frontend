import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../constants/colors.dart';
import '../../custom_widgets/chat_widgets/chat_avatar.dart';
import '../../custom_widgets/chat_widgets/date_divider.dart';
import '../../custom_widgets/chat_widgets/message_bubble.dart';
import '../../models/chat.dart';
import '../../models/message.dart';
import '../../services/chat_service/chat_service.dart';
import '../../util/helpers.dart';
import '../../util/mock/app_config.dart';
import '../../util/mock/mock_chat_service.dart';

class ChatDetailPage extends StatefulWidget {
  final Chat chat;
  final Function(String)? onMessageSent;

  const ChatDetailPage({super.key, required this.chat, this.onMessageSent});

  @override
  State<ChatDetailPage> createState() => ChatDetailPageState();
}

class ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> messages = [];
  bool isLoading = false;
  bool isSending = false;
  String? errorMessage;

  dynamic get chatService =>
      AppConfig.useMockData ? MockChatService() : ChatService();

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final messages = await chatService.getMessages(widget.chat.id);

      setState(() {
        this.messages = messages;
        isLoading = false;
      });

      scrollToBottom();
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load messages: $e'),
            backgroundColor: kApple,
            action: SnackBarAction(
              label: 'Retry',
              textColor: kZeiti,
              onPressed: loadMessages,
            ),
          ),
        );
      }
    }
  }

  Future<void> sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || isSending) return;

    setState(() {
      isSending = true;
    });

    try {
      final newMessage = await chatService.sendMessage(
        receiverId: widget.chat.id,
        content: text,
      );

      setState(() {
        messages.add(newMessage);
        isSending = false;
      });

      widget.onMessageSent?.call(text);

      _messageController.clear();
      scrollToBottom();
    } catch (e) {
      setState(() {
        isSending = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: kApple,
          ),
        );
      }
    }
  }

  // Future<void> _simulateReceiveMessage() async {
  //   if (!AppConfig.useMockData) return;
  //
  //   try {
  //     final mockService = chatService as MockChatService;
  //     final newMessage = await mockService.simulateReceiveMessage(widget.chat.id);
  //
  //     setState(() {
  //       messages.add(newMessage);
  //     });
  //
  //     _scrollToBottom();
  //
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Simulated incoming message'),
  //           duration: Duration(seconds: 1),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to simulate message: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kZeiti,
          selectionColor: kZeiti.withValues(alpha: 0.3),
          selectionHandleColor: kZeiti,
        ),
      ),
      child: Scaffold(
        backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
        appBar: buildAppBar(),
        body: Column(
          children: [
            Expanded(child: buildBody()),
            buildMessageInput(isDark),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      elevation: 0,
      backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: isDark ? Colors.grey[800] : Colors.black12,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: isDark ? kApple : kZeiti),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          ChatAvatar(
            imageUrl: widget.chat.avatarUrl,
            fallbackLetter: widget.chat.name[0].toUpperCase(),
            radius: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.chat.name,
              style: TextStyle(
                color: isDark ? Colors.white : kZeiti,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: isDark ? Colors.white : kZeiti),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: kZeiti));
    }

    if (errorMessage != null) {
      return buildErrorState();
    }

    if (messages.isEmpty) {
      return buildEmptyState();
    }

    return buildMessageList();
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
            'Failed to load messages',
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
            onPressed: loadMessages,
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
          Icon(Icons.chat_bubble_outline, size: 64, color: isDark ? Colors.grey[600] : kKiwi),
          const SizedBox(height: 16),
          Text(
            'No messages yet', 
            style: TextStyle(fontSize: 18, color: isDark ? Colors.grey[400] : kKiwi),
          ),
          const SizedBox(height: 8),
          Text(
            'Start the conversation!',
            style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[500] : kKiwi),
          ),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMine = message.isMine(AppConfig.currentUserId);

        // ---------- DATE SEPARATOR LOGIC ----------
        bool showDate = false;
        String formattedDate = "";

        final messageDate = DateTime(
          message.createdAt.year,
          message.createdAt.month,
          message.createdAt.day,
        );

        if (index == 0) {
          // show date for the first message
          showDate = true;
        } else {
          final previous = messages[index - 1];
          final prevDate = DateTime(
            previous.createdAt.year,
            previous.createdAt.month,
            previous.createdAt.day,
          );

          if (messageDate.difference(prevDate).inDays != 0) {
            showDate = true;
          }
        }

        if (showDate) {
          formattedDate = formatDateChatDetailPage(messageDate);
        }
        // ---------------------------------------------

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDate) DateDivider(text: formattedDate),
            MessageBubble(message: message, isMine: isMine),
          ],
        );
      },
    );
  }

  // Widget buildMessageList() {
  //   return ListView.builder(
  //     controller: _scrollController,
  //     padding: const EdgeInsets.all(16),
  //     itemCount: messages.length,
  //     itemBuilder: (context, index) {
  //       final message = messages[index];
  //       final isMine = message.isMine(AppConfig.currentUserId);
  //       return MessageBubble(
  //         message: message,
  //         isMine: isMine,
  //       );
  //     },
  //   );
  // }

  Widget buildMessageInput(bool isDark) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Transform.rotate(
            angle: 30 * pi / 180, // -20 degrees
            child: Icon(Icons.attach_file, color: isDark ? Colors.grey[400] : kZeiti),
          ),
          const SizedBox(width: 8),
          Icon(Icons.photo, color: isDark ? Colors.grey[400] : kZeiti),
          const SizedBox(width: 8),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : kTiffahiFateh,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey,width: 0.3 ),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                cursorColor: kZeiti,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey),
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(200), // ✅ max 200 letters
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : kTiffahiFateh,
              shape: BoxShape.circle,
              border: Border.all(width: 0.3, color: Colors.grey),
            ),
            child: isSending
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            )
                : IconButton(
              icon: Icon(
                Icons.send_outlined,
                color: isDark?  Colors.grey : kZeiti,
              ),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
