import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/features/notifications/widgets/notification_list_item.dart';

void main() {
  group('NotificationListItem Widget Tests', () {
    late NotificationData testNotification;

    setUp(() {
      testNotification = NotificationData(
        id: 'test_1',
        title: 'Test Notification',
        body: 'This is a test notification body',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      );
    });

    testWidgets('should display notification content correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: testNotification,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Notification'), findsOneWidget);
      expect(find.text('This is a test notification body'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('should show unread notification with bold title', (tester) async {
      // Arrange
      final unreadNotification = NotificationData(
        id: 'test_1',
        title: 'Unread Notification',
        body: 'This is unread',
        timestamp: DateTime.now(),
        isRead: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: unreadNotification,
            ),
          ),
        ),
      );

      // Assert
      final titleFinder = find.text('Unread Notification');
      expect(titleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should show read notification with normal title weight', (tester) async {
      // Arrange
      final readNotification = NotificationData(
        id: 'test_1',
        title: 'Read Notification',
        body: 'This is read',
        timestamp: DateTime.now(),
        isRead: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: readNotification,
            ),
          ),
        ),
      );

      // Assert
      final titleFinder = find.text('Read Notification');
      expect(titleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.fontWeight, FontWeight.normal);
    });

    testWidgets('should call onTap when notification is tapped', (tester) async {
      // Arrange
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: testNotification,
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(NotificationListItem));
      await tester.pumpAndSettle();

      // Assert
      expect(wasTapped, isTrue);
    });

    testWidgets('should show popup menu with correct options for unread notification', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: testNotification, // isRead: false
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Mark as read'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('should not show mark as read option for read notification', (tester) async {
      // Arrange
      final readNotification = NotificationData(
        id: 'test_1',
        title: 'Read Notification',
        body: 'This is read',
        timestamp: DateTime.now(),
        isRead: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: readNotification,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Mark as read'), findsNothing);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('should call onMarkAsRead when menu item is selected', (tester) async {
      // Arrange
      bool wasMarkedAsRead = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: testNotification,
              onMarkAsRead: () {
                wasMarkedAsRead = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mark as read'));
      await tester.pumpAndSettle();

      // Assert
      expect(wasMarkedAsRead, isTrue);
    });

    testWidgets('should call onDelete when delete menu item is selected', (tester) async {
      // Arrange
      bool wasDeleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: testNotification,
              onDelete: () {
                wasDeleted = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Assert
      expect(wasDeleted, isTrue);
    });

    group('Timestamp Formatting', () {
      testWidgets('should show "Just now" for recent notifications', (tester) async {
        // Arrange
        final recentNotification = NotificationData(
          id: 'test_1',
          title: 'Recent',
          body: 'Recent notification',
          timestamp: DateTime.now().subtract(const Duration(seconds: 30)),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NotificationListItem(
                notification: recentNotification,
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Just now'), findsOneWidget);
      });

      testWidgets('should show minutes ago for notifications under 1 hour', (tester) async {
        // Arrange
        final minutesAgoNotification = NotificationData(
          id: 'test_1',
          title: 'Minutes Ago',
          body: 'Old notification',
          timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NotificationListItem(
                notification: minutesAgoNotification,
              ),
            ),
          ),
        );

        // Assert
        expect(find.textContaining('45m ago'), findsOneWidget);
      });

      testWidgets('should show hours ago for notifications under 1 day', (tester) async {
        // Arrange
        final hoursAgoNotification = NotificationData(
          id: 'test_1',
          title: 'Hours Ago',
          body: 'Old notification',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NotificationListItem(
                notification: hoursAgoNotification,
              ),
            ),
          ),
        );

        // Assert
        expect(find.textContaining('3h ago'), findsOneWidget);
      });

      testWidgets('should show days ago for notifications under 1 week', (tester) async {
        // Arrange
        final daysAgoNotification = NotificationData(
          id: 'test_1',
          title: 'Days Ago',
          body: 'Old notification',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NotificationListItem(
                notification: daysAgoNotification,
              ),
            ),
          ),
        );

        // Assert
        expect(find.textContaining('3d ago'), findsOneWidget);
      });
    });

    testWidgets('should handle long text with ellipsis', (tester) async {
      // Arrange
      final longTextNotification = NotificationData(
        id: 'test_1',
        title: 'This is a very long notification title that should be truncated with ellipsis',
        body: 'This is a very long notification body that should be truncated with ellipsis after two lines of text to maintain proper UI layout and readability',
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListItem(
              notification: longTextNotification,
            ),
          ),
        ),
      );

      // Assert
      final titleText = tester.widget<Text>(
        find.textContaining('This is a very long notification title')
      );
      final bodyText = tester.widget<Text>(
        find.textContaining('This is a very long notification body')
      );

      expect(titleText.maxLines, 1);
      expect(titleText.overflow, TextOverflow.ellipsis);
      expect(bodyText.maxLines, 2);
      expect(bodyText.overflow, TextOverflow.ellipsis);
    });
  });
}