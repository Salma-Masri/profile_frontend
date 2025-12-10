import 'package:testprofile/models/user.dart';
import '../../api.dart';

class AuthService {
  // Login user
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await Api.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final token = response.data['token'];
      Api.setAuthToken(token);

      return {
        'user': User.fromJson(response.data['user']),
        'token': token,
      };
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Register user
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await Api.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
      });

      final token = response.data['token'];
      Api.setAuthToken(token);

      return {
        'user': User.fromJson(response.data['user']),
        'token': token,
      };
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      await Api.post('/auth/logout');
      Api.clearAuthToken();
    } catch (e) {
      Api.clearAuthToken(); // Clear token even if request fails
      throw Exception('Failed to logout: $e');
    }
  }

  // Refresh token
  static Future<String> refreshToken() async {
    try {
      final response = await Api.post('/auth/refresh');
      final newToken = response.data['token'];
      Api.setAuthToken(newToken);
      return newToken;
    } catch (e) {
      throw Exception('Failed to refresh token: $e');
    }
  }

  // Forgot password
  static Future<void> forgotPassword(String email) async {
    try {
      await Api.post('/auth/forgot-password', data: {
        'email': email,
      });
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }

  // Reset password
  static Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await Api.post('/auth/reset-password', data: {
        'token': token,
        'new_password': newPassword,
      });
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  // Verify email
  static Future<void> verifyEmail(String token) async {
    try {
      await Api.post('/auth/verify-email', data: {
        'token': token,
      });
    } catch (e) {
      throw Exception('Failed to verify email: $e');
    }
  }

  // Resend verification email
  static Future<void> resendVerificationEmail() async {
    try {
      await Api.post('/auth/resend-verification');
    } catch (e) {
      throw Exception('Failed to resend verification email: $e');
    }
  }
}