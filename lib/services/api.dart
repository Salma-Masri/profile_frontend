import 'dart:io';
import 'package:dio/dio.dart';

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

  // Generic HTTP Methods
  static Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        '$baseUrl$endpoint',
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to perform GET request: $e');
    }
  }

  static Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to perform POST request: $e');
    }
  }

  static Future<Response> put(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to perform PUT request: $e');
    }
  }

  static Future<Response> patch(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to perform PATCH request: $e');
    }
  }

  static Future<Response> delete(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(
        '$baseUrl$endpoint',
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to perform DELETE request: $e');
    }
  }

  // File Upload Method
  static Future<Response> uploadFile(String endpoint, File file, {String fieldName = 'file', Map<String, dynamic>? additionalData}) async {
    try {
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(
          file.path,
          filename: '${fieldName}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        ...?additionalData,
      });

      final response = await _dio.post(
        '$baseUrl$endpoint',
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  // Error handling helper
  static Exception _handleDioException(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['message'] ?? e.message;
      return Exception('HTTP $statusCode: $message');
    } else {
      return Exception('Network error: ${e.message}');
    }
  }

  // Legacy methods for backward compatibility (deprecated)
  @Deprecated('Use Api.get() static method instead')
  Future<dynamic> getLegacy({required String url}) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @Deprecated('Use Api.post() static method instead')
  Future<dynamic> postLegacy({
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