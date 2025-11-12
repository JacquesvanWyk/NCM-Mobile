import '../../config/app_config.dart';

class AppConstants {
  // API Configuration - Use AppConfig for dynamic baseUrl
  // To change environment: AppConfig.setEnvironment(Environment.production)
  static String get baseUrl => AppConfig.baseUrl;
  static const String apiVersion = 'v1';

  // Authentication
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String refreshTokenKey = 'refresh_token';

  // Storage Keys
  static const String isFirstTimeKey = 'is_first_time';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';

  // App Information
  static const String appName = 'NCM Mobile';
  static const String appVersion = '1.0.0';

  // Network
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image Configuration
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];

  // Municipal Service Categories
  static const Map<String, String> serviceIcons = {
    'water-drop': '💧',
    'lightning-bolt': '⚡',
    'road': '🛣️',
    'trash': '🗑️',
    'home': '🏠',
    'tree': '🌳',
    'shield': '🛡️',
    'medical-cross': '🏥',
    'bus': '🚌',
    'building': '🏢',
  };
}