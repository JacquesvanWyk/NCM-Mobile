import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../data/models/notification_model.dart';

// Notification list state
final notificationListProvider =
    StateNotifierProvider<NotificationListNotifier, AsyncValue<List<NotificationModel>>>((ref) {
  return NotificationListNotifier(ref);
});

class NotificationListNotifier extends StateNotifier<AsyncValue<List<NotificationModel>>> {
  final Ref ref;
  int _currentPage = 1;
  bool _hasMore = true;

  NotificationListNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchNotifications();
  }

  Future<void> fetchNotifications({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      state = const AsyncValue.loading();
    }

    if (!_hasMore && !refresh) return;

    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/notifications?page=$_currentPage');
      final data = response.data as Map<String, dynamic>;

      final notifications = (data['notifications'] as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      final pagination = data['pagination'] as Map<String, dynamic>;
      _hasMore = pagination['current_page'] < pagination['last_page'];
      _currentPage++;

      if (refresh) {
        state = AsyncValue.data(notifications);
      } else {
        state = AsyncValue.data([
          ...state.value ?? [],
          ...notifications,
        ]);
      }

      // Refresh unread count
      ref.read(unreadNotificationCountProvider.notifier).fetchUnreadCount();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final apiClient = ApiClient();
      await apiClient.post('/notifications/$notificationId/read', {});

      // Update local state
      state = state.whenData((notifications) {
        return notifications.map((notification) {
          if (notification.id == notificationId) {
            return notification.copyWith(readAt: DateTime.now());
          }
          return notification;
        }).toList();
      });

      // Update unread count
      ref.read(unreadNotificationCountProvider.notifier).fetchUnreadCount();
    } catch (e) {
      // Handle error silently or show a snackbar
      print('Error marking notification as read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final apiClient = ApiClient();
      await apiClient.post('/notifications/read-all', {});

      // Update local state
      state = state.whenData((notifications) {
        return notifications.map((notification) {
          return notification.copyWith(readAt: DateTime.now());
        }).toList();
      });

      // Update unread count
      ref.read(unreadNotificationCountProvider.notifier).fetchUnreadCount();
    } catch (e) {
      print('Error marking all notifications as read: $e');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      final apiClient = ApiClient();
      await apiClient.delete('/notifications/$notificationId');

      // Remove from local state
      state = state.whenData((notifications) {
        return notifications.where((n) => n.id != notificationId).toList();
      });

      // Update unread count
      ref.read(unreadNotificationCountProvider.notifier).fetchUnreadCount();
    } catch (e) {
      print('Error deleting notification: $e');
    }
  }
}

// Unread notification count
final unreadNotificationCountProvider =
    StateNotifierProvider<UnreadNotificationCountNotifier, AsyncValue<int>>((ref) {
  return UnreadNotificationCountNotifier();
});

class UnreadNotificationCountNotifier extends StateNotifier<AsyncValue<int>> {
  UnreadNotificationCountNotifier() : super(const AsyncValue.loading()) {
    fetchUnreadCount();
  }

  Future<void> fetchUnreadCount() async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/notifications/unread-count');
      final data = response.data as Map<String, dynamic>;
      state = AsyncValue.data(data['unread_count'] as int);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Push notification stats (for leaders)
final pushNotificationStatsProvider =
    FutureProvider<PushNotificationStats>((ref) async {
  final apiClient = ApiClient();
  final response = await apiClient.get('/v1/push-notifications/stats');
  final data = response.data as Map<String, dynamic>;
  return PushNotificationStats.fromJson(data);
});

// Send push notification (for leaders)
final sendPushNotificationProvider = Provider((ref) => SendPushNotificationService());

class SendPushNotificationService {
  Future<Map<String, dynamic>> send({
    required String title,
    required String body,
    String recipientType = 'all',
    Map<String, dynamic>? data,
    String? clickAction,
  }) async {
    final apiClient = ApiClient();
    final response = await apiClient.post('/v1/push-notifications/send', {
      'title': title,
      'body': body,
      'recipient_type': recipientType,
      'data': data,
      'click_action': clickAction,
    });
    return response.data as Map<String, dynamic>;
  }
}

// Push notification stats model
class PushNotificationStats {
  final int total;
  final int sent;
  final int pending;
  final int failed;
  final int totalRecipients;
  final int successfulDeliveries;

  PushNotificationStats({
    required this.total,
    required this.sent,
    required this.pending,
    required this.failed,
    required this.totalRecipients,
    required this.successfulDeliveries,
  });

  factory PushNotificationStats.fromJson(Map<String, dynamic> json) {
    return PushNotificationStats(
      total: json['total'] ?? 0,
      sent: json['sent'] ?? 0,
      pending: json['pending'] ?? 0,
      failed: json['failed'] ?? 0,
      totalRecipients: json['total_recipients'] ?? 0,
      successfulDeliveries: json['successful_deliveries'] ?? 0,
    );
  }
}
