// ========================================
// VALIDATION UTILITY
// ========================================
// This file contains all validation logic for form fields

class Validation {
  // Validate first name or last name
  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (value.trim().length > 20) {
      return '$fieldName must not exceed 20 characters';
    }
    return null;
  }

  // Validate email with @gmail.com suffix
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    // Check if email ends with @gmail.com
    if (!value.trim().toLowerCase().endsWith('@gmail.com')) {
      return 'Email must end with @gmail.com';
    }
    
    // Basic email format validation
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  // Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove spaces and check if it contains only digits and + sign
    final cleanedPhone = value.replaceAll(' ', '');
    if (cleanedPhone.isEmpty) {
      return 'Phone number is required';
    }
    
    return null;
  }

  // Validate city
  static String? validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required';
    }
    if (value.trim().length < 2) {
      return 'City must be at least 2 characters';
    }
    if (value.trim().length > 20) {
      return 'City must not exceed 20 characters';
    }
    return null;
  }

  // Validate country
  static String? validateCountry(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Country is required';
    }
    if (value.trim().length < 2) {
      return 'Country must be at least 2 characters';
    }
    if (value.trim().length > 20) {
      return 'Country must not exceed 20 characters';
    }
    return null;
  }

  // Validate password
  static String? validatePassword(String? value, {bool isRequired = false}) {
    if (!isRequired && (value == null || value.isEmpty)) {
      return null; // Password is optional if not required
    }
    
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  // Validate old password when changing password
  static String? validateOldPassword(String? oldPassword, String? newPassword) {
    if (newPassword != null && newPassword.isNotEmpty) {
      if (oldPassword == null || oldPassword.isEmpty) {
        return 'Old password is required to change password';
      }
    }
    return null;
  }
}
