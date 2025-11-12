import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import '../../config/app_config.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class ApiServiceFactory {
  static ApiService? _instance;

  static ApiService get instance {
    _instance ??= _createApiService();
    return _instance!;
  }

  static ApiService _createApiService() {
    final dio = Dio();
    dio.options.baseUrl = AppConfig.baseUrl;

    // Bypass SSL certificate verification for development
    if (AppConfig.isDebug) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // Add auth interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final headers = await AuthService.getAuthHeaders();
        options.headers.addAll(headers);
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, logout user
          await AuthService.logout();
        }
        handler.next(error);
      },
    ));

    return ApiService(dio);
  }
}
