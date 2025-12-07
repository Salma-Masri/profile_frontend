import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:testprofile/models/user.dart';

class Api {
  // TODO: Replace with your backend URL
  static const String baseUrl = 'http://localhost:3000/api';
  static final Dio _dio = Dio();
  static String? authToken;

  static void setAuthToken(String token) {
    authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void clearAuthToken() {
    authToken = null;
    _dio.options.headers.remove('Authorization');
  }

  // User Profile Methods
  static Future<User> getUserProfile() async {
    try {
      final response = await _dio.get('$baseUrl/user/profile');
      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  static Future<User> updateUserProfile(User user) async {
    try {
      final response = await _dio.put(
        '$baseUrl/user/profile',
        data: user.toJson(),
      );
      return User.fromJson(response.data['user']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to update profile: ${e.response?.data['message'] ?? e.message}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Image Upload Methods
  static Future<String> uploadProfileImage(File imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'profile_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      final response = await _dio.post(
        '$baseUrl/user/upload-profile-image',
        data: formData,
      );

      return response.data['image_url'];
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to upload image: ${e.response?.data['message'] ?? e.message}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  static Future<String> uploadIdImage(File imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'identification_card': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'id_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      final response = await _dio.post(
        '$baseUrl/user/upload-id-image',
        data: formData,
      );

      return response.data['image_url'];
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to upload ID: ${e.response?.data['message'] ?? e.message}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to upload ID image: $e');
    }
  }

  // Authentication Methods
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = response.data['token'];
      setAuthToken(token);

      return {
        'user': User.fromJson(response.data['user']),
        'token': token,
      };
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static Future<void> logout() async {
    try {
      await _dio.post('$baseUrl/auth/logout');
      clearAuthToken();
    } on DioException catch (e) {
      clearAuthToken(); // Clear token even if request fails
      if (e.response != null) {
        throw Exception('Logout failed: ${e.response?.data['message'] ?? e.message}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      clearAuthToken();
      throw Exception('Failed to logout: $e');
    }
  }

  // Legacy methods for backward compatibility
  Future<dynamic> get({required String url}) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<dynamic> post({
    required String url,
    required dynamic body,
  }) async {
    try {
      final response = await _dio.post(url, data: body);
      return response.data;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
