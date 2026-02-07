import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants.dart' as AppConstants;
import 'dio_interceptor.dart';

@lazySingleton
class ApiManager {
  late final Dio _dio;

  ApiManager() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.BASEURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Uncomment if needed:
          // 'x-api-key': AppConstants.APIKEY,
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
      MyInterceptor(),
    ]);
  }

  // GET request with proper error handling
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  // POST request with proper error handling
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  // Centralized error handling
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        return _handleHttpError(error.response?.statusCode);

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');

      case DioExceptionType.badCertificate:
        return Exception('Security certificate error');

      case DioExceptionType.unknown:
      default:
        if (error.message?.contains('SocketException') ?? false) {
          return Exception('No internet connection');
        }
        return Exception('Unexpected error occurred: ${error.message}');
    }
  }

  Exception _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return Exception('Bad request');
      case 401:
        return Exception('Unauthorized. Please login again.');
      case 403:
        return Exception('Forbidden. You don\'t have permission.');
      case 404:
        return Exception('Resource not found');
      case 500:
      case 502:
      case 503:
        return Exception('Server error. Please try again later.');
      default:
        return Exception('Something went wrong. Error code: $statusCode');
    }
  }
}
