import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Poll Integration Tests', () {
    testWidgets('T053: Poll participation test', (WidgetTester tester) async {
      // Login first
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to polls section
      await tester.tap(find.byKey(const Key('polls_tab')));
      await tester.pumpAndSettle();

      // Should show list of polls
      expect(find.text('Active Polls'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Tap on first poll
      await tester.tap(find.byKey(const Key('poll_item_0')));
      await tester.pumpAndSettle();

      // Should show poll details
      expect(find.text('Poll Details'), findsOneWidget);
      expect(find.text('Vote'), findsOneWidget);

      // Test single choice poll voting
      await tester.tap(find.byKey(const Key('choice_option_1')));
      await tester.tap(find.byKey(const Key('submit_vote_button')));
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('Vote submitted successfully'), findsOneWidget);

      // Should disable further voting
      expect(find.text('You have already voted'), findsOneWidget);
      expect(find.byKey(const Key('submit_vote_button')), findsNothing);
    });

    testWidgets('Multiple choice poll voting', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login and navigate to polls
      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('polls_tab')));
      await tester.pumpAndSettle();

      // Tap on multiple choice poll
      await tester.tap(find.byKey(const Key('poll_item_1')));
      await tester.pumpAndSettle();

      // Select multiple options
      await tester.tap(find.byKey(const Key('choice_option_1')));
      await tester.tap(find.byKey(const Key('choice_option_3')));
      await tester.tap(find.byKey(const Key('submit_vote_button')));
      await tester.pumpAndSettle();

      expect(find.text('Vote submitted successfully'), findsOneWidget);
    });

    testWidgets('Text poll submission', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login and navigate to polls
      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('polls_tab')));
      await tester.pumpAndSettle();

      // Tap on text poll
      await tester.tap(find.byKey(const Key('poll_item_2')));
      await tester.pumpAndSettle();

      // Enter text response
      await tester.enterText(
        find.byKey(const Key('text_response_field')),
        'This is my detailed response to the poll question.'
      );
      await tester.tap(find.byKey(const Key('submit_vote_button')));
      await tester.pumpAndSettle();

      expect(find.text('Vote submitted successfully'), findsOneWidget);
    });

    testWidgets('Poll offline sync functionality', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login
      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to polls and wait for data to load
      await tester.tap(find.byKey(const Key('polls_tab')));
      await tester.pumpAndSettle();

      // Should show cached polls even when offline
      expect(find.text('Active Polls'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Simulate offline mode
      await tester.tap(find.byKey(const Key('offline_mode_toggle')));
      await tester.pumpAndSettle();

      // Should still show polls from cache
      expect(find.text('Active Polls'), findsOneWidget);
      expect(find.text('Offline Mode'), findsOneWidget);

      // Try to vote while offline
      await tester.tap(find.byKey(const Key('poll_item_0')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('choice_option_1')));
      await tester.tap(find.byKey(const Key('submit_vote_button')));
      await tester.pumpAndSettle();

      // Should queue vote for sync
      expect(find.text('Vote queued for sync'), findsOneWidget);
    });

    testWidgets('Poll results display (admin/leader view)', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login as leader
      await tester.enterText(find.byKey(const Key('email_field')), 'leader@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('polls_tab')));
      await tester.pumpAndSettle();

      // Should see results button for leaders
      expect(find.byKey(const Key('view_results_button')), findsOneWidget);

      await tester.tap(find.byKey(const Key('view_results_button')));
      await tester.pumpAndSettle();

      // Should show poll results
      expect(find.text('Poll Results'), findsOneWidget);
      expect(find.text('Participation Rate'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing); // Results loaded
    });
  });
}