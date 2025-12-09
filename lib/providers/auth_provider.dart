import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import '../config/app_config.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  AuthNotifier() : super(const AsyncValue.loading()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await AuthService.isLoggedIn();
      if (isLoggedIn) {
        final user = await AuthService.getUser();
        state = AsyncValue.data(user);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> login(String email, String password, {bool rememberMe = false}) async {
    try {
      state = const AsyncValue.loading();

      // Try online login first
      try {
        await _performOnlineLogin(email, password, rememberMe);
      } catch (e) {
        // If online login fails, try offline login with cached credentials
        final offlineSuccess = await _tryOfflineLogin(email, password);
        if (!offlineSuccess) {
          rethrow; // If offline login also fails, propagate the original error
        }
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> _performOnlineLogin(String email, String password, bool rememberMe) async {
    // Create API service with unauthenticated dio
    final dio = Dio();
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

      // Bypass SSL certificate verification for development
      if (AppConfig.isDebug) {
        (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
          final client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        };
      }

      final apiService = ApiService(dio);

      // Get FCM token
      String fcmToken = 'unavailable';
      try {
        final messaging = FirebaseMessaging.instance;
        final token = await messaging.getToken();
        if (token != null) {
          fcmToken = token;
        }
      } catch (e) {
        // FCM token fetch failed, continue with 'unavailable'
      }

      // Get device info
      final deviceInfoPlugin = DeviceInfoPlugin();
      final packageInfo = await PackageInfo.fromPlatform();
      String deviceId;
      String deviceType;
      String osVersion;
      String deviceName;

      if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown_ios';
        deviceType = 'ios';
        osVersion = iosInfo.systemVersion;
        deviceName = iosInfo.name;
      } else {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceType = 'android';
        osVersion = androidInfo.version.release;
        deviceName = androidInfo.model;
      }

      // Make mobile login request with device info
      final loginRequest = MobileLoginRequest(
        email: email,
        password: password,
        deviceInfo: DeviceInfo(
          deviceName: deviceName,
          deviceType: deviceType,
          deviceId: deviceId,
          osVersion: osVersion,
          appVersion: packageInfo.version,
          fcmToken: fcmToken,
        ),
      );
      final authResponse = await apiService.login(loginRequest);

      // Save token
      await AuthService.saveToken(authResponse.token);

      // authResponse.user is already a UserModel parsed from JSON
      // Just use it directly
      await AuthService.saveUser(authResponse.user);

      // Cache credentials for offline login
      await AuthService.cacheCredentials(email, password);

      state = AsyncValue.data(authResponse.user);
  }

  Future<bool> _tryOfflineLogin(String email, String password) async {
    try {
      // Check if credentials match cached credentials
      final isValid = await AuthService.validateCachedCredentials(email, password);
      if (!isValid) {
        return false;
      }

      // Load cached user data
      final cachedUser = await AuthService.getUser();
      if (cachedUser == null) {
        return false;
      }

      state = AsyncValue.data(cachedUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      // Try to call logout endpoint
      try {
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

        final headers = await AuthService.getAuthHeaders();
        dio.options.headers.addAll(headers);

        final apiService = ApiService(dio);
        await apiService.logout();
      } catch (e) {
        // Continue with local logout even if API fails
      }

      // Clear local data
      await AuthService.logout();

      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  UserModel? get currentUser => state.valueOrNull;

  bool get isLoggedIn => currentUser != null;

  bool get isMember => currentUser?.userType == 'member';

  bool get isLeader => currentUser?.leader != null;

  bool get isAdmin =>
    currentUser?.userType == 'super_admin' ||
    currentUser?.userType == 'municipality_admin';
}