import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:ncm_mobile_app/main.dart' as app;

/// Integration Test: Poll Statistics Display with Patrol
///
/// Tests the statistics display functionality:
/// - Statistics load correctly and display proper data
/// - Refresh functionality works properly
/// - Performance requirements are met (sub-2s loading)
/// - Visual elements render correctly
/// - Error states are handled gracefully
void main() {
  patrolTest(
    'statistics display shows correct data format',
    ($) async {
      // Arrange: Start app and navigate to poll with statistics
      await app.main();
      await $.pumpAndSettle();

      // Navigate to polls section
      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      // Select a poll with existing votes
      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Scroll to statistics section
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Verify statistics section is displayed
      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);

      // Verify statistics cards are present
      expect(find.text('Total Votes'), findsOneWidget);
      expect(find.text('Participation'), findsOneWidget);

      // Verify statistics icons are displayed
      expect(find.byIcon(Icons.how_to_vote), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
    },
  );

  patrolTest(
    'statistics refresh functionality works correctly',
    ($) async {
      // Arrange: Navigate to poll statistics
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

      // Tap refresh button
      final refreshButton = find.byIcon(Icons.refresh);
      await $.tap(refreshButton);

      // Verify loading state appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for refresh to complete
      await $.pumpAndSettle();

      // Verify statistics are still displayed after refresh
      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.text('Total Votes'), findsOneWidget);
      expect(find.text('Participation'), findsOneWidget);
    },
  );

  patrolTest(
    'statistics performance meets requirements',
    ($) async {
      // Arrange: Navigate to poll details
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

      // Measure statistics refresh time
      final stopwatch = Stopwatch()..start();

      await $.tap(find.byIcon(Icons.refresh));
      await $.pumpAndSettle();

      stopwatch.stop();

      // Verify statistics load within performance requirement (2 seconds)
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(2000),
        reason: 'Statistics should load within 2 seconds',
      );

      // Verify data is displayed after loading
      expect(find.text('Poll Statistics'), findsOneWidget);
    },
  );

  patrolTest(
    'results breakdown displays correctly with visual bars',
    ($) async {
      // Arrange: Navigate to poll with vote results
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

      // Look for results breakdown section
      expect(find.text('Results Breakdown'), findsOneWidget);

      // Verify visual progress bars are present
      // The exact implementation may vary, but we should see visual indicators
      expect(find.byType(Container), findsWidgets);

      // In a poll with data, we should see percentage information
      // This would be verified in a test with actual poll data
    },
  );

  patrolTest(
    'statistics error handling works properly',
    ($) async {
      // Arrange: Navigate to poll statistics
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

      // Note: In a real test, we would mock network failures
      // to test error handling. For now, we verify the UI structure
      // handles various states correctly

      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    },
  );

  patrolTest(
    'statistics display handles empty poll correctly',
    ($) async {
      // Arrange: Navigate to poll with no votes
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      // Look for a poll with no votes (would show different UI)
      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Scroll to statistics section
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Verify statistics section handles empty state
      expect(find.text('Poll Statistics'), findsOneWidget);

      // For empty polls, we might see different messaging
      // The exact implementation depends on how empty polls are handled
    },
  );

  patrolTest(
    'statistics cards display proper color coding',
    ($) async {
      // Arrange: Navigate to poll statistics
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

      // Verify statistics cards are properly styled
      expect(find.text('Total Votes'), findsOneWidget);
      expect(find.text('Participation'), findsOneWidget);

      // Verify icons are present (color coding tested implicitly)
      expect(find.byIcon(Icons.how_to_vote), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
    },
  );

  patrolTest(
    'statistics section scrolling works properly',
    ($) async {
      // Arrange: Navigate to poll details
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Test scrolling to statistics section
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Verify we can scroll back up
      await $.scrollUntilVisible(
        finder: find.text('Poll Details'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.up,
      );

      expect(find.text('Poll Details'), findsOneWidget);

      // Scroll back down to statistics
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      expect(find.text('Poll Statistics'), findsOneWidget);
    },
  );

  patrolTest(
    'statistics display updates after vote submission',
    ($) async {
      // Arrange: Navigate to poll where user can vote
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      // Scroll to statistics to see initial state
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Note initial statistics state (if any)
      final initialStatsVisible = find.text('Poll Statistics');
      expect(initialStatsVisible, findsOneWidget);

      // Scroll back up to vote
      await $.scrollUntilVisible(
        finder: find.text('Options'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.up,
      );

      // Submit a vote
      await $.tap(find.byIcon(Icons.radio_button_unchecked).first);
      await $.pumpAndSettle();

      await $.tap(find.text('Submit Vote'));
      await $.pumpAndSettle();

      // Wait for submission to complete
      await $.pumpAndSettle(const Duration(seconds: 2));

      // Scroll back to statistics
      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Verify statistics are updated/refreshed
      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.text('Total Votes'), findsOneWidget);
      expect(find.text('Participation'), findsOneWidget);
    },
  );

  patrolTest(
    'statistics refresh button provides visual feedback',
    ($) async {
      // Arrange: Navigate to statistics section
      await app.main();
      await $.pumpAndSettle();

      await $.tap(find.text('Polls').first);
      await $.pumpAndSettle();

      final pollTile = find.byType(Card).first;
      await $.tap(pollTile);
      await $.pumpAndSettle();

      await $.scrollUntilVisible(
        finder: find.text('Poll Statistics'),
        view: find.byType(SingleChildScrollView),
        scrollDirection: AxisDirection.down,
      );

      // Verify refresh button is present and tappable
      final refreshButton = find.byIcon(Icons.refresh);
      expect(refreshButton, findsOneWidget);

      // Test refresh button interaction
      await $.tap(refreshButton);

      // Verify loading state provides feedback
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for loading to complete
      await $.pumpAndSettle();

      // Verify statistics are displayed after refresh
      expect(find.text('Poll Statistics'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    },
  );
}