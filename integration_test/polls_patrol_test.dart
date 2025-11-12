import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  patrolTest(
    'polls functionality test',
    ($) async {
      await app.main();
      await $.pumpAndSettle();

      // Wait for login screen and navigate to member flow
      await $.tap(find.byKey(const ValueKey('member_login_button')));
      await $.pumpAndSettle();

      // Fill login form
      await $.enterText(find.byKey(const ValueKey('email_field')), 'member@test.com');
      await $.enterText(find.byKey(const ValueKey('password_field')), 'password123');
      await $.tap(find.byKey(const ValueKey('login_button')));
      await $.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to polls tab
      await $.tap(find.byKey(const ValueKey('polls_tab')));
      await $.pumpAndSettle(const Duration(seconds: 2));

      // Check if polls are loaded
      expect(find.text('Polls'), findsOneWidget);

      // Look for poll cards - if they exist, test interaction
      final pollCards = find.byKey(const ValueKey('poll_card')).evaluate();
      if (pollCards.isNotEmpty) {
        // Tap on first poll
        await $.tap(find.byKey(const ValueKey('poll_card')).first);
        await $.pumpAndSettle();

        // Check poll details page
        expect(find.text('Poll Details'), findsOneWidget);

        // Try to vote if poll options are available
        final voteButtons = find.byKey(const ValueKey('poll_option_button')).evaluate();
        if (voteButtons.isNotEmpty) {
          await $.tap(find.byKey(const ValueKey('poll_option_button')).first);
          await $.pumpAndSettle();

          // Check for vote confirmation
          await $.tap(find.byKey(const ValueKey('submit_vote_button')));
          await $.pumpAndSettle(const Duration(seconds: 2));
        }

        // Navigate back
        await $.tap(find.byIcon(Icons.arrow_back));
        await $.pumpAndSettle();
      }

      // Verify polls page is still accessible
      expect(find.text('Polls'), findsOneWidget);
    },
  );
}