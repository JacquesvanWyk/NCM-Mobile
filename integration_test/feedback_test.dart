import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Feedback Integration Tests', () {
    testWidgets('T056: Feedback submission test', (WidgetTester tester) async {
      // Login first
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to feedback
      await tester.tap(find.byKey(const Key('feedback_tab')));
      await tester.pumpAndSettle();

      // Should show feedback form
      expect(find.text('Submit Feedback'), findsOneWidget);
      expect(find.byKey(const Key('feedback_category_dropdown')), findsOneWidget);
      expect(find.byKey(const Key('feedback_message_field')), findsOneWidget);

      // Select feedback category
      await tester.tap(find.byKey(const Key('feedback_category_dropdown')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Service Delivery'));
      await tester.pumpAndSettle();

      // Enter feedback message
      await tester.enterText(
        find.byKey(const Key('feedback_message_field')),
        'The water supply has been inconsistent in our area for the past week. Please investigate.'
      );

      // Submit feedback
      await tester.tap(find.byKey(const Key('submit_feedback_button')));
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('Feedback submitted successfully'), findsOneWidget);
      expect(find.text('Thank you for your feedback'), findsOneWidget);

      // Form should be cleared
      expect(find.text('The water supply has been inconsistent'), findsNothing);
    });

    testWidgets('Feedback with photo attachment', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('feedback_tab')));
      await tester.pumpAndSettle();

      // Select category and enter message
      await tester.tap(find.byKey(const Key('feedback_category_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Infrastructure'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('feedback_message_field')),
        'Pothole on Main Street needs urgent attention.'
      );

      // Add photo attachment
      await tester.tap(find.byKey(const Key('attach_photo_button')));
      await tester.pumpAndSettle();

      // Should show photo options
      expect(find.text('Choose Photo'), findsOneWidget);
      expect(find.text('Take Photo'), findsOneWidget);
      expect(find.text('Choose from Gallery'), findsOneWidget);

      // Simulate photo selection
      await tester.tap(find.text('Choose from Gallery'));
      await tester.pumpAndSettle();

      // Should show photo preview
      expect(find.byKey(const Key('photo_preview')), findsOneWidget);
      expect(find.byKey(const Key('remove_photo_button')), findsOneWidget);

      // Submit with photo
      await tester.tap(find.byKey(const Key('submit_feedback_button')));
      await tester.pumpAndSettle();

      expect(find.text('Feedback with photo submitted successfully'), findsOneWidget);
    });

    testWidgets('Feedback category validation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('feedback_tab')));
      await tester.pumpAndSettle();

      // Try to submit without category
      await tester.enterText(
        find.byKey(const Key('feedback_message_field')),
        'Test feedback message'
      );

      await tester.tap(find.byKey(const Key('submit_feedback_button')));
      await tester.pumpAndSettle();

      // Should show validation error
      expect(find.text('Please select a category'), findsOneWidget);

      // Form should not be submitted
      expect(find.text('Feedback submitted successfully'), findsNothing);
    });

    testWidgets('Feedback message validation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('feedback_tab')));
      await tester.pumpAndSettle();

      // Select category but leave message empty
      await tester.tap(find.byKey(const Key('feedback_category_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('General'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('submit_feedback_button')));
      await tester.pumpAndSettle();

      // Should show validation error
      expect(find.text('Please enter your feedback message'), findsOneWidget);
    });

    testWidgets('Feedback offline queueing', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Simulate offline mode
      await tester.tap(find.byKey(const Key('offline_mode_toggle')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('feedback_tab')));
      await tester.pumpAndSettle();

      // Should show offline indicator
      expect(find.text('Offline Mode'), findsOneWidget);

      // Submit feedback while offline
      await tester.tap(find.byKey(const Key('feedback_category_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Service Delivery'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('feedback_message_field')),
        'Offline feedback submission test'
      );

      await tester.tap(find.byKey(const Key('submit_feedback_button')));
      await tester.pumpAndSettle();

      // Should show queued message
      expect(find.text('Feedback queued for submission'), findsOneWidget);
      expect(find.text('Will be sent when connection is restored'), findsOneWidget);

      // Go back online
      await tester.tap(find.byKey(const Key('offline_mode_toggle')));
      await tester.pumpAndSettle();

      // Should show sync in progress
      expect(find.text('Syncing queued feedback'), findsOneWidget);
    });

    testWidgets('Feedback history view', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('feedback_tab')));
      await tester.pumpAndSettle();

      // Should have history tab
      expect(find.byKey(const Key('feedback_history_tab')), findsOneWidget);

      await tester.tap(find.byKey(const Key('feedback_history_tab')));
      await tester.pumpAndSettle();

      // Should show previous feedback submissions
      expect(find.text('Your Feedback History'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Should show feedback status
      expect(find.text('Submitted'), findsAtLeastNWidgets(1));
      expect(find.text('Under Review'), findsAtLeastNWidgets(1));

      // Tap on feedback item to view details
      await tester.tap(find.byKey(const Key('feedback_history_item_0')));
      await tester.pumpAndSettle();

      // Should show feedback details
      expect(find.text('Feedback Details'), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Submitted on'), findsOneWidget);
    });
  });
}