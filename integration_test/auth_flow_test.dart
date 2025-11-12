import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow Tests', () {
    testWidgets('T052: Login flow integration test', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should show login screen initially
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Test invalid login attempt
      await tester.enterText(find.byKey(const Key('email_field')), 'invalid@email.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'wrongpassword');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Invalid credentials'), findsOneWidget);

      // Test valid login
      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should navigate to dashboard
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Welcome'), findsOneWidget);
    });

    testWidgets('Login persists after app restart', (WidgetTester tester) async {
      // First login
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Simulate app restart by restarting
      await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
        'flutter/platform',
        const StandardMethodCodec().encodeMethodCall(const MethodCall('SystemNavigator.pop')),
        (data) {},
      );

      // Restart app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should skip login and go straight to dashboard
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Logout functionality works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login first
      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to profile/settings
      await tester.tap(find.byKey(const Key('profile_tab')));
      await tester.pumpAndSettle();

      // Tap logout
      await tester.tap(find.byKey(const Key('logout_button')));
      await tester.pumpAndSettle();

      // Should return to login screen
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('Municipality scoping validation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login with member from Municipality A
      await tester.enterText(find.byKey(const Key('email_field')), 'member@municipa.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should show only data from their municipality
      expect(find.text('Municipality A'), findsOneWidget);
      expect(find.text('Municipality B'), findsNothing);
    });
  });
}