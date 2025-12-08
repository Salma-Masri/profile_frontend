import '../models/chat.dart';
import '../models/message.dart';
import 'api.dart';

// Service for handling all chat-related API calls
class ChatService {
  final Api _api = Api();

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

  // 5. GET /api/auth/me - Get current user info (OPTIONAL but recommended)
  //    Response: {
  //      "id": "1",
  //      "name": "Current User",
  //      "email": "user@example.com"
  //    }

  // ============================================
  // API METHODS
  // ============================================

  // Get all chats (conversations)
  Future<List<Chat>> getChats() async {
    try {
      final response = await _api.get(url: '${Api.baseUrl}/chats');
      final List<dynamic> chatsJson = response;

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
  Future<List<Message>> getMessages(String userId) async {
    try {
      final response = await _api.get(url: '${Api.baseUrl}/messages?user_id=$userId');
      final List<dynamic> messagesJson = response;

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
  Future<Message> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    try {
      final response = await _api.post(
        url: '${Api.baseUrl}/messages',
        body: {
          'receiver_id': receiverId,
          'content': content,
        },
      );
      return Message.fromJson(response);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
