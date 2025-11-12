import 'package:mockito/mockito.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Mock classes for testing
class MockNotificationSettings extends Mock implements NotificationSettings {}

class MockIosDeviceInfo extends Mock implements IosDeviceInfo {}

class MockAndroidDeviceInfo extends Mock implements AndroidDeviceInfo {}

class MockRemoteMessage extends Mock implements RemoteMessage {}

class MockRemoteNotification extends Mock implements RemoteNotification {}

// Test data helpers
class TestData {
  static RemoteMessage createTestMessage({
    String? messageId,
    RemoteNotification? notification,
    Map<String, dynamic>? data,
  }) {
    return RemoteMessage(
      messageId: messageId ?? 'test_message_id',
      notification: notification,
      data: data ?? {},
    );
  }

  static RemoteNotification createTestNotification({
    String? title,
    String? body,
  }) {
    return RemoteNotification(
      title: title ?? 'Test Title',
      body: body ?? 'Test Body',
    );
  }

  static Map<String, dynamic> createFcmTokenRequest({
    String? fcmToken,
    String? deviceId,
    String? deviceType,
    String? appVersion,
  }) {
    return {
      'fcm_token': fcmToken ?? 'test_fcm_token',
      'device_id': deviceId ?? 'test_device_id',
      'device_type': deviceType ?? 'ios',
      'app_version': appVersion ?? '1.0.0',
    };
  }

  static Map<String, dynamic> createNotificationData({
    String? screen,
    String? action,
    Map<String, dynamic>? metadata,
  }) {
    final data = <String, dynamic>{};

    if (screen != null) data['screen'] = screen;
    if (action != null) data['action'] = action;
    if (metadata != null) data.addAll(metadata);

    return data;
  }
}

// Test constants
class TestConstants {
  static const String testFcmToken = 'fcm_token_12345_test';
  static const String testDeviceId = 'device_12345_test';
  static const String testUserId = 'user_12345_test';
  static const String testAppVersion = '1.0.0-test';

  static const Map<String, dynamic> sampleNotificationData = {
    'screen': 'home',
    'user_id': '123',
    'action': 'refresh',
  };

  static const List<String> validDeviceTypes = ['ios', 'android'];
  static const List<String> notificationStatuses = ['draft', 'scheduled', 'sent', 'failed'];
}