import 'package:dio/dio.dart';
import '../utils/constants.dart';

class ApiConfig {
  late final Dio _dio;

  ApiConfig() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveTimeout: const Duration(seconds: 150),
      connectTimeout: const Duration(seconds: 150),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }

  Dio get dio => _dio;
}
