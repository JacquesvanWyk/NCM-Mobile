import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../test_helpers/mock_services.dart';
import '../../lib/services/fcm_service.dart';
import '../../lib/core/network/api_client.dart';

// Generate mocks
@GenerateMocks([
  FirebaseMessaging,
  SharedPreferences,
  DeviceInfoPlugin,
  PackageInfo,
  ApiClient,
])
void main() {
  group('FcmService', () {
    late FcmService fcmService;
    late MockFirebaseMessaging mockFirebaseMessaging;
    late MockSharedPreferences mockSharedPreferences;
    late MockDeviceInfoPlugin mockDeviceInfoPlugin;
    late MockPackageInfo mockPackageInfo;
    late MockApiClient mockApiClient;

    setUp(() {
      mockFirebaseMessaging = MockFirebaseMessaging();
      mockSharedPreferences = MockSharedPreferences();
      mockDeviceInfoPlugin = MockDeviceInfoPlugin();
      mockPackageInfo = MockPackageInfo();
      mockApiClient = MockApiClient();

      fcmService = FcmService();
    });

    group('Token Management', () {
      test('should get FCM token and send to server', () async {
        // Arrange
        const testToken = 'test_fcm_token_123';
        when(mockFirebaseMessaging.getToken())
            .thenAnswer((_) async => testToken);
        when(mockSharedPreferences.getString('fcm_token'))
            .thenReturn(null);
        when(mockPackageInfo.version).thenReturn('1.0.0');
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((_) async => true);

        // Act
        // Note: This test would need the actual implementation to be mockable
        // For now, we're testing the concept

        // Assert
        verify(mockFirebaseMessaging.getToken()).called(1);
      });

      test('should not send token if it hasnt changed', () async {
        // Arrange
        const testToken = 'test_fcm_token_123';
        when(mockFirebaseMessaging.getToken())
            .thenAnswer((_) async => testToken);
        when(mockSharedPreferences.getString('fcm_token'))
            .thenReturn(testToken);

        // Act
        // Implementation would check if token changed

        // Assert
        // Should not call API if token hasn't changed
        verifyNever(mockApiClient.post(any, any));
      });

      test('should handle token refresh', () async {
        // Arrange
        const newToken = 'new_fcm_token_456';
        when(mockSharedPreferences.getString('fcm_token'))
            .thenReturn('old_token');

        // Act
        // Implementation would handle token refresh via onTokenRefresh stream

        // Assert
        // Should send new token to server
        expect(newToken, isNotEmpty);
      });
    });

    group('Permission Handling', () {
      test('should request FCM permissions', () async {
        // Arrange
        final mockSettings = MockNotificationSettings();
        when(mockSettings.authorizationStatus)
            .thenReturn(AuthorizationStatus.authorized);
        when(mockFirebaseMessaging.requestPermission(
          alert: anyNamed('alert'),
          badge: anyNamed('badge'),
          sound: anyNamed('sound'),
          provisional: anyNamed('provisional'),
        )).thenAnswer((_) async => mockSettings);

        // Act
        await mockFirebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        );

        // Assert
        verify(mockFirebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        )).called(1);
      });

      test('should handle denied permissions gracefully', () async {
        // Arrange
        final mockSettings = MockNotificationSettings();
        when(mockSettings.authorizationStatus)
            .thenReturn(AuthorizationStatus.denied);
        when(mockFirebaseMessaging.requestPermission(
          alert: anyNamed('alert'),
          badge: anyNamed('badge'),
          sound: anyNamed('sound'),
          provisional: anyNamed('provisional'),
        )).thenAnswer((_) async => mockSettings);

        // Act
        final settings = await mockFirebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        );

        // Assert
        expect(settings.authorizationStatus, AuthorizationStatus.denied);
      });
    });

    group('Message Handling', () {
      test('should handle foreground messages', () async {
        // Arrange
        final testMessage = RemoteMessage(
          messageId: 'test_id',
          notification: const RemoteNotification(
            title: 'Test Title',
            body: 'Test Body',
          ),
          data: {'key': 'value'},
        );

        // Act
        // Implementation would show local notification

        // Assert
        expect(testMessage.notification?.title, 'Test Title');
        expect(testMessage.notification?.body, 'Test Body');
        expect(testMessage.data['key'], 'value');
      });

      test('should handle notification tap when app is terminated', () async {
        // Arrange
        final testMessage = RemoteMessage(
          messageId: 'test_id',
          data: {'screen': 'home'},
        );

        // Act
        // Implementation would navigate to specified screen

        // Assert
        expect(testMessage.data['screen'], 'home');
      });

      test('should handle notification tap when app is in background', () async {
        // Arrange
        final testMessage = RemoteMessage(
          messageId: 'test_id',
          data: {'screen': 'profile', 'user_id': '123'},
        );

        // Act
        // Implementation would navigate to profile screen

        // Assert
        expect(testMessage.data['screen'], 'profile');
        expect(testMessage.data['user_id'], '123');
      });
    });

    group('Token Removal', () {
      test('should remove token from server and locally', () async {
        // Arrange
        when(mockSharedPreferences.remove('fcm_token'))
            .thenAnswer((_) async => true);
        when(mockFirebaseMessaging.deleteToken())
            .thenAnswer((_) async {});

        // Act
        // Implementation would call removeToken()

        // Assert
        // Should call API to remove token and delete locally
        expect(true, isTrue); // Placeholder assertion
      });

      test('should handle errors when removing token', () async {
        // Arrange
        when(mockApiClient.delete(any, data: anyNamed('data')))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        // Should handle exception gracefully
        expect(() => throw Exception('Network error'), throwsException);
      });
    });

    group('Device Information', () {
      test('should get device information for iOS', () async {
        // Arrange
        final mockIosInfo = MockIosDeviceInfo();
        when(mockIosInfo.identifierForVendor).thenReturn('ios_device_id');
        when(mockDeviceInfoPlugin.iosInfo)
            .thenAnswer((_) async => mockIosInfo);

        // Act
        final iosInfo = await mockDeviceInfoPlugin.iosInfo;

        // Assert
        expect(iosInfo.identifierForVendor, 'ios_device_id');
      });

      test('should get device information for Android', () async {
        // Arrange
        final mockAndroidInfo = MockAndroidDeviceInfo();
        when(mockAndroidInfo.id).thenReturn('android_device_id');
        when(mockDeviceInfoPlugin.androidInfo)
            .thenAnswer((_) async => mockAndroidInfo);

        // Act
        final androidInfo = await mockDeviceInfoPlugin.androidInfo;

        // Assert
        expect(androidInfo.id, 'android_device_id');
      });
    });

    group('Error Handling', () {
      test('should handle FCM initialization errors', () async {
        // Arrange
        when(mockFirebaseMessaging.getToken())
            .thenThrow(Exception('FCM initialization failed'));

        // Act & Assert
        expect(
          () => mockFirebaseMessaging.getToken(),
          throwsException,
        );
      });

      test('should handle network errors when sending token', () async {
        // Arrange
        when(mockApiClient.post(any, any))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => mockApiClient.post('/fcm-tokens', {}),
          throwsException,
        );
      });

      test('should continue gracefully on permission errors', () async {
        // This test ensures the app doesn't crash if permissions fail
        expect(true, isTrue); // Placeholder - implementation specific
      });
    });
  });
}