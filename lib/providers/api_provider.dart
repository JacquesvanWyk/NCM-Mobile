import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import '../config/app_config.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';

// Dio instance provider
final dioProvider = Provider<Dio>((ref) {
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
      final token = await AuthService.getToken();
      print('DEBUG: Token: ${token?.substring(0, 20)}...');
      print('DEBUG: Headers: $headers');
      print('DEBUG: Request URL: ${options.uri}');
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

  return dio;
});

// API service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider);
  return ApiService(dio);
});