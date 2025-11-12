import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Announcement Integration Tests', () {
    testWidgets('T054: Announcement viewing test', (WidgetTester tester) async {
      // Login first
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to announcements
      await tester.tap(find.byKey(const Key('announcements_tab')));
      await tester.pumpAndSettle();

      // Should show announcements list
      expect(find.text('Announcements'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Should show announcements with priority indicators
      expect(find.byKey(const Key('priority_urgent')), findsAtLeastNWidgets(1));
      expect(find.byKey(const Key('priority_high')), findsAtLeastNWidgets(1));

      // Tap on first announcement
      await tester.tap(find.byKey(const Key('announcement_item_0')));
      await tester.pumpAndSettle();

      // Should show announcement details
      expect(find.text('Announcement Details'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Should have back button
      await tester.tap(find.byKey(const Key('back_button')));
      await tester.pumpAndSettle();

      // Should return to announcements list
      expect(find.text('Announcements'), findsOneWidget);
    });

    testWidgets('Urgent announcements shown prominently', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('announcements_tab')));
      await tester.pumpAndSettle();

      // Urgent announcements should appear at top
      final urgentFinder = find.byKey(const Key('priority_urgent'));
      expect(urgentFinder, findsAtLeastNWidgets(1));

      // Should have distinct visual styling
      final urgentWidget = tester.widget<Container>(urgentFinder.first);
      expect(urgentWidget.decoration, isNotNull);
    });

    testWidgets('Announcement filtering by priority', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('announcements_tab')));
      await tester.pumpAndSettle();

      // Tap filter button
      await tester.tap(find.byKey(const Key('filter_button')));
      await tester.pumpAndSettle();

      // Select 'urgent' filter
      await tester.tap(find.byKey(const Key('filter_urgent')));
      await tester.pumpAndSettle();

      // Should show only urgent announcements
      expect(find.byKey(const Key('priority_urgent')), findsAtLeastNWidgets(1));
      expect(find.byKey(const Key('priority_medium')), findsNothing);
      expect(find.byKey(const Key('priority_low')), findsNothing);
    });

    testWidgets('Announcement refresh and pagination', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('announcements_tab')));
      await tester.pumpAndSettle();

      // Test pull-to-refresh
      await tester.drag(find.byType(ListView), const Offset(0, 300));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should show refresh indicator during refresh
      expect(find.byType(RefreshIndicator), findsOneWidget);

      // Scroll to bottom to test pagination
      await tester.drag(find.byType(ListView), const Offset(0, -3000));
      await tester.pumpAndSettle();

      // Should load more announcements
      expect(find.byKey(const Key('loading_more_indicator')), findsOneWidget);
    });

    testWidgets('Offline announcement caching', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Load announcements while online
      await tester.tap(find.byKey(const Key('announcements_tab')));
      await tester.pumpAndSettle();

      final onlineAnnouncementCount = tester.widgetList(find.byKey(const Key('announcement_item'))).length;

      // Simulate offline mode
      await tester.tap(find.byKey(const Key('offline_mode_toggle')));
      await tester.pumpAndSettle();

      // Navigate away and back
      await tester.tap(find.byKey(const Key('dashboard_tab')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('announcements_tab')));
      await tester.pumpAndSettle();

      // Should still show cached announcements
      expect(find.text('Announcements'), findsOneWidget);
      expect(find.text('Offline Mode'), findsOneWidget);

      final offlineAnnouncementCount = tester.widgetList(find.byKey(const Key('announcement_item'))).length;
      expect(offlineAnnouncementCount, equals(onlineAnnouncementCount));
    });

    testWidgets('Push notification integration for announcements', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Simulate push notification tap
      await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
        'flutter/local_notifications',
        const StandardMethodCodec().encodeMethodCall(
          const MethodCall('notification_tapped', {
            'type': 'announcement',
            'announcement_id': '123',
          }),
        ),
        (data) {},
      );

      await tester.pumpAndSettle();

      // Should navigate directly to announcement details
      expect(find.text('Announcement Details'), findsOneWidget);
      expect(find.text('Push Notification'), findsOneWidget);
    });
  });
}