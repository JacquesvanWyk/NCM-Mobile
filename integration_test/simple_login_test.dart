import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Integration Tests', () {
    testWidgets('Should show login form on startup', (WidgetTester tester) async {
      // Start the app
      await tester.pumpWidget(
        const ProviderScope(
          child: app.NCMApp(),
        ),
      );

      // Wait for splash screen to complete
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify we have email and password fields
      expect(find.byType(TextFormField), findsAtLeast(2));

      print('✅ Login form test completed successfully');
    });

    testWidgets('Should attempt chairperson login', (WidgetTester tester) async {
      // Start the app
      await tester.pumpWidget(
        const ProviderScope(
          child: app.NCMApp(),
        ),
      );

      // Wait for splash screen
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Find form fields
      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      // Enter test credentials
      await tester.enterText(emailField, 'chairperson@ncm.co.za');
      await tester.enterText(passwordField, 'password123');

      await tester.pumpAndSettle();

      // Find and tap login button (it's an ElevatedButton)
      final loginButton = find.byType(ElevatedButton);
      expect(loginButton, findsOneWidget);
      await tester.tap(loginButton);

      // Wait for login process
      await tester.pumpAndSettle(const Duration(seconds: 5));

      print('✅ Chairperson login test completed');
    });
  });
}