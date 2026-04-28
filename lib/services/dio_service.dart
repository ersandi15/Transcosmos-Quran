import 'package:dio/dio.dart';

class DioService {
  // Singleton pattern
  static final DioService _instance = DioService._internal();

  factory DioService() {
    return _instance;
  }

  late final Dio _dio;

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        // Sesuai dengan komentar di pubspec.yaml untuk alquran.cloud
        baseUrl: 'https://api.alquran.cloud/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptor untuk mempermudah proses debugging (logging request/response di terminal)
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  // Getter untuk instance dio jika ingin dipanggil secara custom
  Dio get dio => _dio;

  // --- Helper Methods untuk HTTP Requests ---

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.post(endpoint, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }
  
  // Fungsi terpusat untuk print/handle error dari Dio
  void _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      print('[Dio Error] Connection Timeout Exception');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      print('[Dio Error] Receive Timeout Exception');
    } else if (error.type == DioExceptionType.badResponse) {
      print('[Dio Error] Bad Response: ${error.response?.statusCode}');
    } else {
      print('[Dio Error] Something went wrong: ${error.message}');
    }
  }
}
