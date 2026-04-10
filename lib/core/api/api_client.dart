import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  Dio get dio => _dio;
}
