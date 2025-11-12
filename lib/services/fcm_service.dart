import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../core/network/api_client.dart';

class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  FirebaseMessaging get messaging => FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? _localNotifications;

  Future<void> initialize() async {
    await _setupLocalNotifications();
    await _requestPermissions();
    await _setupTokenRefreshListener();
    await _refreshToken();
  }

  Future<void> _setupLocalNotifications() async {
    _localNotifications = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications!.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _requestPermissions() async {
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('FCM: User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('FCM: User granted provisional permission');
    } else {
      print('FCM: User declined or has not accepted permission');
    }
  }

  Future<void> _setupTokenRefreshListener() async {
    messaging.onTokenRefresh.listen((token) async {
      print('FCM: Token refreshed: $token');
      await _sendTokenToServer(token);
    });
  }

  Future<void> _refreshToken() async {
    try {
      final token = await messaging.getToken();
      if (token != null) {
        print('FCM: Got token: $token');
        await _sendTokenToServer(token);
      }
    } catch (e) {
      print('FCM: Error getting token: $e');
    }
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('fcm_token');

      if (storedToken == token) {
        return; // Token hasn't changed
      }

      final deviceInfo = DeviceInfoPlugin();
      final packageInfo = await PackageInfo.fromPlatform();
      String deviceId;
      String deviceType;

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown_ios';
        deviceType = 'ios';
      } else {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceType = 'android';
      }

      final apiClient = ApiClient();
      await apiClient.post('/fcm-tokens', {
        'fcm_token': token,
        'device_id': deviceId,
        'device_type': deviceType,
        'app_version': packageInfo.version,
      });

      await prefs.setString('fcm_token', token);
      print('FCM: Token sent to server successfully');
    } catch (e) {
      print('FCM: Error sending token to server: $e');
    }
  }

  Future<void> setupMessageHandlers() async {
    // Handle when app is terminated and opened via notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    // Handle when app is in background and notification is tapped
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Handle when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleMessage(RemoteMessage message) {
    print('FCM: Message clicked: ${message.messageId}');
    // Navigate to specific screen based on message data
    if (message.data.containsKey('screen')) {
      final screen = message.data['screen'];
      print('FCM: Navigating to screen: $screen');
      // Implement navigation logic here
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    if (_localNotifications == null) return;

    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications!.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    print('FCM: Local notification tapped: ${response.payload}');
    // Handle local notification tap
  }

  Future<void> removeToken() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      String deviceId;

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown_ios';
      } else {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      }

      final apiClient = ApiClient();
      await apiClient.delete('/fcm-tokens', data: {
        'device_id': deviceId,
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('fcm_token');

      await messaging.deleteToken();
      print('FCM: Token removed successfully');
    } catch (e) {
      print('FCM: Error removing token: $e');
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('FCM: Background message received: ${message.messageId}');
}