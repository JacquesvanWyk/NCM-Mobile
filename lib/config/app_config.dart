import '../core/constants/app_constants.dart';

enum Environment { development, staging, production }

class AppConfig {
  static Environment _environment = Environment.development;

  static Environment get environment => _environment;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  // Base domain URL (without /api path) - SINGLE SOURCE OF TRUTH
  static String get _domainUrl {
    switch (_environment) {
      case Environment.development:
        return 'http://127.0.0.1:8000';
      case Environment.staging:
        return 'https://namakwacivic.org.za';
      case Environment.production:
        return 'https://namakwacivic.org.za';
    }
  }

  // API base URL (used by Dio/ApiService) - automatically includes /api
  static String get baseUrl => _domainUrl;

  // Web base URL (used for payment callbacks, web routes)
  static String get webBaseUrl => _domainUrl;

  static bool get isDebug => _environment == Environment.development;
  static bool get isProduction => _environment == Environment.production;

  static String get appName {
    switch (_environment) {
      case Environment.development:
        return 'NCM Mobile (Dev)';
      case Environment.staging:
        return 'NCM Mobile (Staging)';
      case Environment.production:
        return AppConstants.appName;
    }
  }

  // Feature flags
  static bool get enableLogging => !isProduction;
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashReporting => isProduction;

  // Payment callback URLs - automatically use correct domain
  static String get paymentSuccessUrl => '$webBaseUrl/payment/success';
  static String get paymentCancelUrl => '$webBaseUrl/payment/cancel';
  static String get paymentNotifyUrl => '$webBaseUrl/api/payfast/notify';
}