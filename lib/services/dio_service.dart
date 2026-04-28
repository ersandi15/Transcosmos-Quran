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
    return await _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(endpoint, data: data, queryParameters: queryParameters);
  }
  
  // Fungsi statis untuk mendapatkan pesan error yang rapi dari DioException
  static String getErrorMessage(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return 'Koneksi terputus. Silakan periksa jaringan Anda.';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Waktu permintaan habis. Silakan coba lagi.';
    } else if (error.type == DioExceptionType.badResponse) {
      return 'Terdapat masalah pada server (${error.response?.statusCode}).';
    } else if (error.type == DioExceptionType.connectionError) {
      return 'Tidak ada koneksi internet. Silakan periksa jaringan Anda.';
    } else {
      return 'Terjadi kesalahan jaringan yang tidak diketahui.';
    }
  }
}
