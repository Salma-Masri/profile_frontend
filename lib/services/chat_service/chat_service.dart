import '../../models/chat.dart';
import '../../models/message.dart';
import '../api.dart';

// Service for handling all chat-related API calls
class ChatService {

  // ============================================
  // BACKEND REQUIREMENTS - ENDPOINTS NEEDED:
  // ============================================

  // 1. GET /api/chats - Get list of all conversations
  //    Response: [
  //      {
  //        "user_id": "2",
  //        "user_name": "John Doe",
  //        "last_message": {
  //          "id": "123",
  //          "sender_id": "2",
  //          "receiver_id": "1",
  //          "content": "Hello!",
  //          "created_at": "2024-01-01T10:00:00Z",
  //          "updated_at": "2024-01-01T10:00:00Z"
  //        },
  //        "unread_count": 3
  //      }
  //    ]

  // 2. GET /api/messages?user_id={userId} - Get all messages with a specific user
  //    Response: [
  //      {
  //        "id": "1",
  //        "sender_id": "1",
  //        "receiver_id": "2",
  //        "content": "Hi there!",
  //        "created_at": "2024-01-01T09:00:00Z",
  //        "updated_at": "2024-01-01T09:00:00Z"
  //      }
  //    ]

  // 3. POST /api/messages - Send a new message
  //    Body: {
  //      "receiver_id": "2",
  //      "content": "Hello!"
  //    }
  //    Response: {
  //      "id": "124",
  //      "sender_id": "1",  // Backend should set this from auth token
  //      "receiver_id": "2",
  //      "content": "Hello!",
  //      "created_at": "2024-01-01T10:05:00Z",
  //      "updated_at": "2024-01-01T10:05:00Z"
  //    }

  // 4. PUT /api/messages/{messageId}/read - Mark message as read (OPTIONAL)
  //    This is optional but recommended for unread count feature

  // 5. POST /api/chats - Create a new chat/conversation
  //    Body: {
  //      "user_id": "2",
  //      "initial_message": "Hello!" (optional)
  //    }
  //    Response: {
  //      "user_id": "2",
  //      "user_name": "John Doe",
  //      "last_message": null or message object,
  //      "unread_count": 0
  //    }

  // 6. GET /api/users/search?q={query}&limit={limit} - Search users to chat with
  //    Response: [
  //      {
  //        "id": "2",
  //        "name": "John Doe",
  //        "email": "john@example.com",
  //        "profile_image": "url_to_image"
  //      }
  //    ]

  // 7. PUT /api/messages/mark-read - Mark messages as read
  //    Body: {
  //      "user_id": "2"
  //    }

  // 8. DELETE /api/chats/{userId} - Delete a chat/conversation

  // 9. GET /api/chats/{userId}/info - Get chat info (user details)
  //    Response: {
  //      "id": "2",
  //      "name": "John Doe",
  //      "email": "john@example.com",
  //      "profile_image": "url_to_image",
  //      "last_seen": "2024-01-01T10:00:00Z"
  //    }

  // 10. GET /api/auth/me - Get current user info (OPTIONAL but recommended)
  //     Response: {
  //       "id": "1",
  //       "name": "Current User",
  //       "email": "user@example.com"
  //     }

  // ============================================
  // API METHODS
  // ============================================

  // Get all chats (conversations)
  static Future<List<Chat>> getChats() async {
    try {
      final response = await Api.get('/chats');
      final List<dynamic> chatsJson = response.data;

      List<Chat> chats = [];
      for (var json in chatsJson) {
        chats.add(Chat.fromJson(json));
      }
      return chats;
    } catch (e) {
      throw Exception('Failed to load chats: $e');
    }
  }

  // Get all messages with a specific user
  static Future<List<Message>> getMessages(String userId) async {
    try {
      final response = await Api.get('/messages', queryParameters: {'user_id': userId});
      final List<dynamic> messagesJson = response.data;

      List<Message> messages = [];
      for (var json in messagesJson) {
        messages.add(Message.fromJson(json));
      }
      return messages;
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  // Send a new message
  static Future<Message> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    try {
      final response = await Api.post('/messages', data: {
        'receiver_id': receiverId,
        'content': content,
      });
      return Message.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Create a new chat/conversation with a user
  static Future<Chat> addChat({
    required String userId,
    String? initialMessage,
  }) async {
    try {
      final response = await Api.post('/chats', data: {
        'user_id': userId,
        if (initialMessage != null) 'initial_message': initialMessage,
      });
      return Chat.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  // Search for users to start a chat with
  static Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    try {
      final response = await Api.get('/users/search', queryParameters: {
        'q': query,
        'limit': 20,
      });
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  // Mark messages as read
  static Future<void> markMessagesAsRead(String chatUserId) async {
    try {
      await Api.put('/messages/mark-read', data: {
        'user_id': chatUserId,
      });
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  // Delete a chat/conversation
  static Future<void> deleteChat(String chatUserId) async {
    try {
      await Api.delete('/chats/$chatUserId');
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }

  // Get chat info (user details for a specific chat)
  static Future<Map<String, dynamic>> getChatInfo(String userId) async {
    try {
      final response = await Api.get('/chats/$userId/info');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get chat info: $e');
    }
  }
}
