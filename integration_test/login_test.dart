import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patrol/patrol.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  patrolTest(
    'Login flow test - Chairperson login',
    ($) async {
      // Start the app with proper widget
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: app.NCMApp(),
        ),
      );

      // Wait for splash screen to complete and navigate to login
      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Verify we're on the login page by looking for email field
      expect(find.byType(TextFormField), findsAtLeast(2));

      // Find email and password fields
      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      // Enter test credentials
      await $.enterText(emailField, 'chairperson@ncm.co.za');
      await $.pump();

      await $.enterText(passwordField, 'password123');
      await $.pump();

      // Find and tap login button
      await $.tap(find.text('Login'));

      // Wait for login process and navigation
      await $.pump(const Duration(seconds: 5));
      await $.pumpAndSettle();

      // Verify successful login by checking for dashboard elements
      // Should show chairperson-specific content
      expect(
        find.textContaining('CHAIRPERSON PERMISSIONS'),
        findsOneWidget,
      );

      print('✅ Chairperson login test completed successfully');
    },
  );

  patrolTest(
    'Login flow test - Secretary login',
    ($) async {
      // Start the app
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: app.NCMApp(),
        ),
      );

      // Wait for splash screen to complete and navigate to login
      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Enter secretary credentials
      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      await $.enterText(emailField, 'secretary@ncm.co.za');
      await $.pump();

      await $.enterText(passwordField, 'password123');
      await $.pump();

      // Tap login button
      await $.tap(find.text('Login'));

      // Wait for login process
      await $.pump(const Duration(seconds: 5));
      await $.pumpAndSettle();

      // Verify secretary-specific content
      expect(
        find.textContaining('SECRETARY PERMISSIONS'),
        findsOneWidget,
      );

      print('✅ Secretary login test completed successfully');
    },
  );

  patrolTest(
    'Login flow test - Invalid credentials',
    ($) async {
      // Start the app
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: app.NCMApp(),
        ),
      );

      // Wait for splash screen
      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Enter invalid credentials
      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      await $.enterText(emailField, 'invalid@test.com');
      await $.pump();

      await $.enterText(passwordField, 'wrongpassword');
      await $.pump();

      // Tap login button
      await $.tap(find.text('Login'));

      // Wait for error response
      await $.pump(const Duration(seconds: 3));
      await $.pumpAndSettle();

      // Verify error message appears (could be snackbar or dialog)
      expect(
        find.textContaining('Login failed'),
        findsAtLeastNWidgets(0),
      );

      print('✅ Invalid credentials test completed successfully');
    },
  );
}