import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Event Integration Tests', () {
    testWidgets('T055: Event RSVP test', (WidgetTester tester) async {
      // Login first
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to events
      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      // Should show events list
      expect(find.text('Upcoming Events'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Tap on first event
      await tester.tap(find.byKey(const Key('event_item_0')));
      await tester.pumpAndSettle();

      // Should show event details
      expect(find.text('Event Details'), findsOneWidget);
      expect(find.text('RSVP'), findsOneWidget);

      // Test RSVP - Attending
      await tester.tap(find.byKey(const Key('rsvp_attending')));
      await tester.pumpAndSettle();

      // Should show guests field
      expect(find.byKey(const Key('guests_count_field')), findsOneWidget);

      // Enter guest count
      await tester.enterText(find.byKey(const Key('guests_count_field')), '2');
      await tester.tap(find.byKey(const Key('submit_rsvp_button')));
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('RSVP submitted successfully'), findsOneWidget);

      // Should show updated RSVP status
      expect(find.text('You are attending'), findsOneWidget);
      expect(find.text('Guests: 2'), findsOneWidget);
    });

    testWidgets('Event RSVP - Not Attending', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('event_item_1')));
      await tester.pumpAndSettle();

      // Test RSVP - Not Attending
      await tester.tap(find.byKey(const Key('rsvp_not_attending')));
      await tester.tap(find.byKey(const Key('submit_rsvp_button')));
      await tester.pumpAndSettle();

      expect(find.text('RSVP submitted successfully'), findsOneWidget);
      expect(find.text('You are not attending'), findsOneWidget);

      // Should not show guests field for not attending
      expect(find.byKey(const Key('guests_count_field')), findsNothing);
    });

    testWidgets('Event RSVP - Maybe', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('event_item_2')));
      await tester.pumpAndSettle();

      // Test RSVP - Maybe
      await tester.tap(find.byKey(const Key('rsvp_maybe')));
      await tester.tap(find.byKey(const Key('submit_rsvp_button')));
      await tester.pumpAndSettle();

      expect(find.text('RSVP submitted successfully'), findsOneWidget);
      expect(find.text('You might attend'), findsOneWidget);
    });

    testWidgets('Event capacity validation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      // Find full capacity event
      await tester.tap(find.byKey(const Key('event_item_full')));
      await tester.pumpAndSettle();

      // Should show capacity warning
      expect(find.text('Event Full'), findsOneWidget);
      expect(find.text('Capacity: 50/50'), findsOneWidget);

      // RSVP button should be disabled
      final rsvpButton = tester.widget<ElevatedButton>(find.byKey(const Key('rsvp_attending')));
      expect(rsvpButton.enabled, false);
    });

    testWidgets('Event calendar integration', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('event_item_0')));
      await tester.pumpAndSettle();

      // RSVP first
      await tester.tap(find.byKey(const Key('rsvp_attending')));
      await tester.tap(find.byKey(const Key('submit_rsvp_button')));
      await tester.pumpAndSettle();

      // Should show "Add to Calendar" button
      expect(find.byKey(const Key('add_to_calendar_button')), findsOneWidget);

      await tester.tap(find.byKey(const Key('add_to_calendar_button')));
      await tester.pumpAndSettle();

      // Should show calendar options
      expect(find.text('Add to Calendar'), findsOneWidget);
      expect(find.text('Google Calendar'), findsOneWidget);
      expect(find.text('Apple Calendar'), findsOneWidget);
    });

    testWidgets('Event location and directions', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('event_item_0')));
      await tester.pumpAndSettle();

      // Should show location information
      expect(find.text('Location'), findsOneWidget);
      expect(find.byKey(const Key('event_location')), findsOneWidget);

      // Should have directions button
      expect(find.byKey(const Key('get_directions_button')), findsOneWidget);

      await tester.tap(find.byKey(const Key('get_directions_button')));
      await tester.pumpAndSettle();

      // Should open maps application
      expect(find.text('Opening Maps'), findsOneWidget);
    });

    testWidgets('Event attendance statistics (for leaders)', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login as leader
      await tester.enterText(find.byKey(const Key('email_field')), 'leader@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('events_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('event_item_0')));
      await tester.pumpAndSettle();

      // Leaders should see attendance statistics
      expect(find.text('Attendance Statistics'), findsOneWidget);
      expect(find.text('Attending: 15'), findsOneWidget);
      expect(find.text('Not Attending: 5'), findsOneWidget);
      expect(find.text('Maybe: 3'), findsOneWidget);

      // Should have export attendee list button
      expect(find.byKey(const Key('export_attendees_button')), findsOneWidget);
    });
  });
}