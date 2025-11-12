import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Profile Integration Tests', () {
    testWidgets('T057: Profile update test', (WidgetTester tester) async {
      // Login first
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to profile
      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Should show profile information
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byKey(const Key('profile_photo')), findsOneWidget);
      expect(find.byKey(const Key('edit_profile_button')), findsOneWidget);

      // Tap edit profile
      await tester.tap(find.byKey(const Key('edit_profile_button')));
      await tester.pumpAndSettle();

      // Should show edit form
      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.byKey(const Key('first_name_field')), findsOneWidget);
      expect(find.byKey(const Key('last_name_field')), findsOneWidget);
      expect(find.byKey(const Key('phone_field')), findsOneWidget);

      // Update profile information
      await tester.enterText(find.byKey(const Key('first_name_field')), 'Updated John');
      await tester.enterText(find.byKey(const Key('phone_field')), '+27 82 555 0123');

      await tester.tap(find.byKey(const Key('save_profile_button')));
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('Profile updated successfully'), findsOneWidget);

      // Should return to profile view with updated info
      expect(find.text('Updated John'), findsOneWidget);
      expect(find.text('+27 82 555 0123'), findsOneWidget);
    });

    testWidgets('Profile photo upload', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Tap on profile photo to change
      await tester.tap(find.byKey(const Key('profile_photo')));
      await tester.pumpAndSettle();

      // Should show photo options
      expect(find.text('Update Profile Photo'), findsOneWidget);
      expect(find.text('Take Photo'), findsOneWidget);
      expect(find.text('Choose from Gallery'), findsOneWidget);
      expect(find.text('Remove Photo'), findsOneWidget);

      // Simulate selecting from gallery
      await tester.tap(find.text('Choose from Gallery'));
      await tester.pumpAndSettle();

      // Should show upload progress
      expect(find.text('Uploading photo...'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);

      // Wait for upload to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should show success message
      expect(find.text('Profile photo updated successfully'), findsOneWidget);

      // Should show new photo
      expect(find.byKey(const Key('updated_profile_photo')), findsOneWidget);
    });

    testWidgets('Password change functionality', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Scroll down to find change password button
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('change_password_button')));
      await tester.pumpAndSettle();

      // Should show password change form
      expect(find.text('Change Password'), findsOneWidget);
      expect(find.byKey(const Key('current_password_field')), findsOneWidget);
      expect(find.byKey(const Key('new_password_field')), findsOneWidget);
      expect(find.byKey(const Key('confirm_password_field')), findsOneWidget);

      // Enter password details
      await tester.enterText(find.byKey(const Key('current_password_field')), 'password123');
      await tester.enterText(find.byKey(const Key('new_password_field')), 'newpassword456');
      await tester.enterText(find.byKey(const Key('confirm_password_field')), 'newpassword456');

      await tester.tap(find.byKey(const Key('save_password_button')));
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('Password changed successfully'), findsOneWidget);

      // Should clear the form
      expect(find.text('newpassword456'), findsNothing);
    });

    testWidgets('Notification preferences', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Scroll to notification settings
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Should show notification preference switches
      expect(find.text('Notification Preferences'), findsOneWidget);
      expect(find.byKey(const Key('push_notifications_switch')), findsOneWidget);
      expect(find.byKey(const Key('email_notifications_switch')), findsOneWidget);
      expect(find.byKey(const Key('announcement_notifications_switch')), findsOneWidget);

      // Toggle announcement notifications
      await tester.tap(find.byKey(const Key('announcement_notifications_switch')));
      await tester.pumpAndSettle();

      // Should show confirmation
      expect(find.text('Preferences updated'), findsOneWidget);

      // Toggle email notifications
      await tester.tap(find.byKey(const Key('email_notifications_switch')));
      await tester.pumpAndSettle();

      expect(find.text('Preferences updated'), findsOneWidget);
    });

    testWidgets('Membership information display', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Should show membership information
      expect(find.text('Membership Information'), findsOneWidget);
      expect(find.byKey(const Key('membership_number')), findsOneWidget);
      expect(find.byKey(const Key('membership_status')), findsOneWidget);
      expect(find.byKey(const Key('municipality_name')), findsOneWidget);

      // Should show membership card
      expect(find.byKey(const Key('digital_membership_card')), findsOneWidget);

      await tester.tap(find.byKey(const Key('digital_membership_card')));
      await tester.pumpAndSettle();

      // Should show full-screen membership card
      expect(find.text('Digital Membership Card'), findsOneWidget);
      expect(find.byKey(const Key('qr_code')), findsOneWidget);
      expect(find.byKey(const Key('member_photo')), findsOneWidget);
    });

    testWidgets('Payment history view', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Scroll to payment history
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -400));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('payment_history_button')));
      await tester.pumpAndSettle();

      // Should show payment history
      expect(find.text('Payment History'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Should show payment details
      expect(find.text('Membership Payment'), findsAtLeastNWidgets(1));
      expect(find.text('Paid'), findsAtLeastNWidgets(1));

      // Tap on payment item
      await tester.tap(find.byKey(const Key('payment_history_item_0')));
      await tester.pumpAndSettle();

      // Should show payment details
      expect(find.text('Payment Details'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Payment Date'), findsOneWidget);
      expect(find.text('Coverage Period'), findsOneWidget);
    });

    testWidgets('Profile validation errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit_profile_button')));
      await tester.pumpAndSettle();

      // Clear required fields
      await tester.enterText(find.byKey(const Key('first_name_field')), '');
      await tester.enterText(find.byKey(const Key('phone_field')), 'invalid-phone');

      await tester.tap(find.byKey(const Key('save_profile_button')));
      await tester.pumpAndSettle();

      // Should show validation errors
      expect(find.text('First name is required'), findsOneWidget);
      expect(find.text('Please enter a valid phone number'), findsOneWidget);

      // Form should not be saved
      expect(find.text('Profile updated successfully'), findsNothing);
    });
  });
}