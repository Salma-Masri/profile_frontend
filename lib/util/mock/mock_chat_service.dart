

// Mock service for testing without backend
import '../../models/chat.dart';
import '../../models/message.dart';
import '../helpers.dart';

class MockChatService {
  // Simulated current user ID
  static const String currentUserId = '1';

  // Simulated delay to mimic network request
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Mock data storage (simulates database)
  final List<Message> _allMessages = [
    Message(
      id: '1',
      senderId: '2',
      receiverId: '1',
      content: 'Hi there!',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Message(
      id: '2',
      senderId: '1',
      receiverId: '2',
      content: 'Hello! how can I help?',
      createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
    ),
    Message(
      id: '3',
      senderId: '2',
      receiverId: '1',
      content: 'it is the a perfect apartment',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Message(
      id: '4',
      senderId: '3',
      receiverId: '1',
      content: 'yes!',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Message(
      id: '5',
      senderId: '1',
      receiverId: '3',
      content: 'ok, no problem',
      createdAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 58)),
    ),
    Message(
      id: '6',
      senderId: '3',
      receiverId: '1',
      content: 'this is the end',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Message(
      id: '7',
      senderId: '4',
      receiverId: '1',
      content: 'Thanks for your help 😊',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Mock user data
  final Map<String, String> _userNames = {
    '1': 'Me',
    '2': 'Sarah',
    '3': 'Judy',
    '4': 'Fadi',
    '5': 'Layla',
  };

  // Mock user profile images (empty string = use letter fallback)
  final Map<String, String> _userImages = {
    '1': '',
    '2': 'https://i.pravatar.cc/150?img=9',
    '3': 'assets/photo_2025-12-02_09-51-31.jpg',
    '4': 'assets/snoopy.jpg',
    '5': 'https://i.pravatar.cc/150?img=4',
  };

  // Get all chats (conversations grouped by user)
  Future<List<Chat>> getChats() async {
    await _simulateNetworkDelay();

    Map<String, List<Message>> messagesByUser = {};

    for (var message in _allMessages) {
      String otherUserId;
      if (message.senderId == currentUserId) {
        otherUserId = message.receiverId;
      } else {
        otherUserId = message.senderId;
      }

      if (!messagesByUser.containsKey(otherUserId)) {
        messagesByUser[otherUserId] = [];
      }
      messagesByUser[otherUserId]!.add(message);
    }

    List<Chat> chats = [];

    messagesByUser.forEach((userId, messages) {
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final lastMessage = messages.first;

      int unreadCount = 0;
      for (var m in messages) {
        if (m.receiverId == currentUserId) {
          unreadCount++;
        }
      }

      chats.add(Chat(
        id: userId,
        name: _userNames[userId] ?? 'User $userId',
        lastMessage: lastMessage.content,
        time: formatTimeChatPage(lastMessage.createdAt),
        avatarUrl: _userImages[userId] ?? '',
        lastMessageTime: lastMessage.createdAt,
        unreadCount: unreadCount,
      ));
    });

    chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

    return chats;
  }

  // Get all messages with a specific user
  Future<List<Message>> getMessages(String userId) async {
    await _simulateNetworkDelay();

    List<Message> messages = [];
    for (var message in _allMessages) {
      bool isMyMessage = message.senderId == currentUserId && message.receiverId == userId;
      bool isTheirMessage = message.senderId == userId && message.receiverId == currentUserId;

      if (isMyMessage || isTheirMessage) {
        messages.add(message);
      }
    }

    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return messages;
  }

  // Send a new message
  Future<Message> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    await _simulateNetworkDelay();

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUserId,
      receiverId: receiverId,
      content: content,
      createdAt: DateTime.now(),
    );

    _allMessages.add(newMessage);

    return newMessage;
  }

  // Simulate receiving a message (for testing)
  Future<Message> simulateReceiveMessage(String fromUserId) async {
    await _simulateNetworkDelay();

    final responses = [
      'Got it!',
      'hold your breath',
      'Sure',
      'I agree',
      'so close no matter how far',
      'Perfect!',
      'forever trusting who we are and nothing else matters',
    ];

    final randomResponse = responses[DateTime.now().millisecond % responses.length];

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: fromUserId,
      receiverId: currentUserId,
      content: randomResponse,
      createdAt: DateTime.now(),
    );

    _allMessages.add(newMessage);

    return newMessage;
  }
}
