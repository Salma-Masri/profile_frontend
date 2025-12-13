import 'dart:io';
import 'package:testprofile/models/user.dart';
import '../../api.dart';

class EditProfileService {
  // Get user profile
  static Future<User> getUserProfile() async {
    try {
      final response = await Api.get('/user/profile');
      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  // Update user profile
  static Future<User> updateUserProfile(User user) async {
    try {
      final response = await Api.put('/user/profile', data: user.toJson());
      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Upload profile image
  static Future<String> uploadProfileImage(File imageFile) async {
    try {
      final response = await Api.uploadFile(
        '/user/upload-profile-image',
        imageFile,
        fieldName: 'profile_image',
      );
      return response.data['image_url'];
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  // Upload ID image
  static Future<String> uploadIdImage(File imageFile) async {
    try {
      final response = await Api.uploadFile(
        '/user/upload-id-image',
        imageFile,
        fieldName: 'identification_card',
      );
      return response.data['image_url'];
    } catch (e) {
      throw Exception('Failed to upload ID image: $e');
    }
  }

  // Change password
  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await Api.put('/user/change-password', data: {
        'old_password': oldPassword,
        'new_password': newPassword,
      });
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  // Delete profile image
  static Future<void> deleteProfileImage() async {
    try {
      await Api.delete('/user/profile-image');
    } catch (e) {
      throw Exception('Failed to delete profile image: $e');
    }
  }

  // Update specific profile field
  static Future<User> updateProfileField(String field, dynamic value) async {
    try {
      final response = await Api.patch('/user/profile', data: {
        field: value,
      });
      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Failed to update $field: $e');
    }
  }
}