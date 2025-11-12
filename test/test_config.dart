import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test configuration and setup utilities
class TestConfig {
  /// Set up common test environment
  static void setUp() {
    // Set up method channel mocks for Firebase
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock Firebase Core
    const MethodChannel('plugins.flutter.io/firebase_core')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'Firebase#initializeCore') {
        return {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'test_api_key',
            'appId': 'test_app_id',
            'messagingSenderId': 'test_sender_id',
            'projectId': 'test_project_id',
          },
          'pluginConstants': {},
        };
      }
      return null;
    });

    // Mock Firebase Messaging
    const MethodChannel('plugins.flutter.io/firebase_messaging')
        .setMockMethodCallHandler((methodCall) async {
      switch (methodCall.method) {
        case 'Messaging#getToken':
          return 'mock_fcm_token';
        case 'Messaging#requestPermission':
          return {
            'authorizationStatus': 1, // AuthorizationStatus.authorized
          };
        case 'Messaging#deleteToken':
          return null;
        default:
          return null;
      }
    });

    // Mock Shared Preferences
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{};
      }
      return null;
    });

    // Mock Device Info Plus
    const MethodChannel('dev.fluttercommunity.plus/device_info')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getIosDeviceInfo') {
        return {
          'identifierForVendor': 'mock_ios_device_id',
          'model': 'iPhone',
          'systemVersion': '15.0',
        };
      } else if (methodCall.method == 'getAndroidDeviceInfo') {
        return {
          'id': 'mock_android_device_id',
          'model': 'Test Device',
          'version': {'sdkInt': 30},
        };
      }
      return null;
    });

    // Mock Package Info Plus
    const MethodChannel('plugins.flutter.io/package_info_plus')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getAll') {
        return {
          'appName': 'NCM Mobile App Test',
          'packageName': 'design.motionstack.ncm.test',
          'version': '1.0.0',
          'buildNumber': '1',
        };
      }
      return null;
    });

    // Mock Flutter Local Notifications
    const MethodChannel('dexterous.com/flutter/local_notifications')
        .setMockMethodCallHandler((methodCall) async {
      switch (methodCall.method) {
        case 'initialize':
        case 'show':
        case 'cancel':
        case 'cancelAll':
          return null;
        default:
          return null;
      }
    });
  }

  /// Clean up test environment
  static void tearDown() {
    // Reset method channel handlers
    const MethodChannel('plugins.flutter.io/firebase_core')
        .setMockMethodCallHandler(null);
    const MethodChannel('plugins.flutter.io/firebase_messaging')
        .setMockMethodCallHandler(null);
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler(null);
    const MethodChannel('dev.fluttercommunity.plus/device_info')
        .setMockMethodCallHandler(null);
    const MethodChannel('plugins.flutter.io/package_info_plus')
        .setMockMethodCallHandler(null);
    const MethodChannel('dexterous.com/flutter/local_notifications')
        .setMockMethodCallHandler(null);
  }
}

/// Test data factories
class TestDataFactory {
  static Map<String, dynamic> createFcmTokenRequest({
    String? fcmToken,
    String? deviceId,
    String? deviceType,
    String? appVersion,
  }) {
    return {
      'fcm_token': fcmToken ?? 'test_fcm_token_123',
      'device_id': deviceId ?? 'test_device_id_123',
      'device_type': deviceType ?? 'ios',
      'app_version': appVersion ?? '1.0.0',
    };
  }

  static Map<String, dynamic> createNotificationPayload({
    String? title,
    String? body,
    Map<String, dynamic>? data,
  }) {
    return {
      'notification': {
        'title': title ?? 'Test Notification',
        'body': body ?? 'This is a test notification',
      },
      'data': data ?? {'screen': 'home'},
    };
  }
}

/// Common test assertions
class TestAssertions {
  static void assertFcmTokenRequest(Map<String, dynamic> request) {
    expect(request['fcm_token'], isA<String>());
    expect(request['device_id'], isA<String>());
    expect(request['device_type'], isIn(['ios', 'android']));
    expect(request['app_version'], isA<String>());
  }

  static void assertNotificationPayload(Map<String, dynamic> payload) {
    expect(payload['notification'], isNotNull);
    expect(payload['notification']['title'], isA<String>());
    expect(payload['notification']['body'], isA<String>());
  }
}