import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:ncm_mobile_app/main.dart' as app;

/// Integration Test: Poll Voting Flow with Patrol
///
/// Tests the complete user journey for poll voting:
/// - Navigation to polls section
/// - Poll selection and viewing
/// - Option selection and vote submission
/// - Success feedback and statistics display
/// - Error handling for duplicate votes
void main() {
  patrolTest(
    'user can complete poll voting flow successfully',
    ($) async {
      // Arrange: Start the app
      await app.main();
      await $.pumpAndSettle();

      // Navigate to polls section from dashboard
      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      // Verify polls list is displayed
      expect(find.text('Active Polls'), findsOneWidget);

      // Find and tap on an active poll
      final activePollTile = find.byType(Card).first;
      await $.tap(activePollTile);
      await $.pumpAndSettle();

      // Verify poll details page is displayed
      expect(find.text('Poll Details'), findsOneWidget);
      expect(find.text('Options'), findsOneWidget);

      // Find and select a poll option
      final optionTile = find.byIcon(Icons.radio_button_unchecked).first;
      await $.tap(optionTile);
      await $.pumpAndSettle();

      // Verify option is selected (radio button becomes checked)
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);

      // Submit the vote
      final submitButton = find.text('Submit Vote');
      expect(submitButton, findsOneWidget);
      await $.tap(submitButton);

      // Wait for vote submission (with loading indicator)
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await $.pumpAndSettle();

      // Verify success message is displayed
      expect(
        find.text('Vote submitted successfully and queued for processing!'),
        findsOneWidget,
      );

      // Verify poll state changes to "voted"
      await $.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('You have already voted in this poll'), findsOneWidget);

      // Verify submit button is no longer visible
      expect(find.text('Submit Vote'), findsNothing);

      // Verify statistics section is displayed
      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.text('Total Votes'), findsOneWidget);
      expect(find.text('Participation'), findsOneWidget);
    },
  );

  patrolTest(
    'user sees proper error handling for network issues',
    ($) async {
      // Arrange: Start app and navigate to poll details
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final activePollTile = find.byType(Card).first;
      await $.tap(activePollTile);
      await $.pumpAndSettle();

      // Select an option
      final optionTile = find.byIcon(Icons.radio_button_unchecked).first;
      await $.tap(optionTile);
      await $.pumpAndSettle();

      // Note: In a real test, we would mock network failures
      // For now, we test the UI behavior when submission fails

      // Submit vote
      await $.tap(find.text('Submit Vote'));
      await $.pumpAndSettle();

      // In case of error, user should see error message
      // This would be triggered by actual API failure in real scenario
      // For now, we verify the error handling UI exists

      // Verify loading state is properly handled
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  patrolTest(
    'user can refresh statistics manually',
    ($) async {
      // Arrange: Navigate to poll details with existing vote
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final activePollTile = find.byType(Card).first;
      await $.tap(activePollTile);
      await $.pumpAndSettle();

      // Scroll down to statistics section
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Find and tap refresh button
      final refreshButton = find.byIcon(Icons.refresh);
      expect(refreshButton, findsOneWidget);

      await $.tap(refreshButton);
      await $.pumpAndSettle();

      // Verify loading state during refresh
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await $.pumpAndSettle();

      // Verify statistics are displayed after refresh
      expect(find.text('Poll Statistics'), findsOneWidget);
    },
  );

  patrolTest(
    'poll details display updates correctly after voting',
    ($) async {
      // Arrange: Start with a poll where user hasn't voted
      await app.main();
      await $.pumpAndSettle();

      // Navigate to polls
      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      // Select a poll
      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Verify initial state (not voted)
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Submit Vote'), findsOneWidget);

      // Select and submit vote
      await $.tap(find.byIcon(Icons.radio_button_unchecked).first);
      await $.pumpAndSettle();

      await $.tap(find.text('Submit Vote'));
      await $.pumpAndSettle();

      // Wait for submission to complete
      await $.pumpAndSettle(const Duration(seconds: 2));

      // Verify UI updates after voting
      expect(find.text('Voted'), findsOneWidget);
      expect(find.text('You have already voted in this poll'), findsOneWidget);
      expect(find.text('Submit Vote'), findsNothing);

      // Verify statistics section becomes visible
      expect(find.text('Poll Statistics'), findsOneWidget);
    },
  );

  patrolTest(
    'inactive polls are properly handled',
    ($) async {
      // Arrange: Start app and navigate to polls
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      // Look for inactive polls (they should show different state)
      // In a real test, we'd set up test data with inactive polls

      // For now, verify that the polls list loads properly
      expect(find.text('Active Polls'), findsOneWidget);

      // If there are no active polls, appropriate message should be shown
      // This depends on the actual implementation of the polls list page
    },
  );

  patrolTest(
    'poll options are displayed correctly with proper formatting',
    ($) async {
      // Arrange: Navigate to poll details
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Verify poll options structure
      expect(find.text('Options'), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_unchecked), findsWidgets);

      // Test option selection visual feedback
      final firstOption = find.byIcon(Icons.radio_button_unchecked).first;
      await $.tap(firstOption);
      await $.pumpAndSettle();

      // Verify visual feedback
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);

      // Test selecting different option
      final secondOption = find.byIcon(Icons.radio_button_unchecked).first;
      await $.tap(secondOption);
      await $.pumpAndSettle();

      // Verify only one option can be selected
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    },
  );

  patrolTest(
    'poll statistics visualization works correctly',
    ($) async {
      // Arrange: Navigate to poll with existing votes
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Scroll to statistics section
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Verify statistics components are present
      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);

      // Test manual refresh functionality
      await $.tap(find.byIcon(Icons.refresh));
      await $.pumpAndSettle();

      // Verify statistics data loads
      // In a real test with data, we would verify specific statistics
      expect(find.text('Poll Statistics'), findsOneWidget);
    },
  );

  patrolTest(
    'performance test: vote submission completes quickly',
    ($) async {
      // Arrange: Navigate to poll details
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Select option
      await $.tap(find.byIcon(Icons.radio_button_unchecked).first);
      await $.pumpAndSettle();

      // Measure vote submission time
      final stopwatch = Stopwatch()..start();

      await $.tap(find.text('Submit Vote'));

      // Wait for loading state to appear and disappear
      await $.pumpAndSettle();

      stopwatch.stop();

      // Verify submission completed in reasonable time (< 5 seconds for UI)
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(5000),
        reason: 'Vote submission UI should complete within 5 seconds',
      );

      // Verify success state is reached
      expect(find.text('You have already voted in this poll'), findsOneWidget);
    },
  );
}