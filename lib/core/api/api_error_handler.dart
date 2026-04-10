import 'package:dio/dio.dart';
import '../error/failures.dart';

class ApiErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout || 
          error.type == DioExceptionType.receiveTimeout || 
          error.type == DioExceptionType.sendTimeout) {
        return const ConnectionFailure('Connection timed out. Please check your internet and try again.');
      }
      if (error.type == DioExceptionType.connectionError) {
        return const ConnectionFailure('No internet connection.');
      }

      // Check for structured backend errors
      if (error.response != null && error.response!.data != null) {
        final data = error.response!.data;
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          final errorsList = data['errors'] as List;
          if (errorsList.isNotEmpty) {
            final firstError = errorsList.first;
            return ServerFailure(_mapErrorMessage(firstError));
          }
        }
      }
      if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            return const ServerFailure('Invalid request. Please check your inputs.');
          case 401:
            return const ServerFailure('Unauthorized request.');
          case 403:
            return const ServerFailure('You do not have permission to perform this action.');
          case 404:
            return const ServerFailure('Requested resource not found.');
          case 500:
          case 502:
          case 503:
            return const ServerFailure('Internal server error. Please try again later.');
        }
      }

      return ServerFailure('Unexpected error occurred: ${error.message}');
    }
    return ServerFailure('An unknown error occurred.');
  }

  static String _mapErrorMessage(Map<String, dynamic> backendError) {
    if (backendError.containsKey('extensions')) {
      final extensions = backendError['extensions'];
      final code = extensions['code'];
      final field = extensions['field'] ?? 'field';

      switch (code) {
        case 'FAILED_VALIDATION':
          return 'Validation failed for $field. Please ensure it is correctly formatted.';
        case 'RECORD_NOT_UNIQUE':
          return 'This $field is already taken or booked. Please choose another one.';
        case 'Value can\'t be null':
          return '$field cannot be empty.';
        case 'INVALID_PAYLOAD':
          return 'The data provided is invalid.';
        case 'FORBIDDEN':
          return 'You do not have permission to access or modify this resource.';
        default:
          return backendError['message'] ?? 'An error occurred with $field.';
      }
    }
    return backendError['message'] ?? 'Something went wrong on the server.';
  }
}

