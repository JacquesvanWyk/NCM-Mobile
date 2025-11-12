import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:ncm_mobile_app/features/auth/pages/login_page.dart';
import 'package:ncm_mobile_app/providers/auth_provider.dart';

@GenerateMocks([AuthNotifier])
import 'login_page_test.mocks.dart';

void main() {
  group('LoginPage Widget Tests', () {
    late MockAuthNotifier mockAuthNotifier;

    setUp(() {
      mockAuthNotifier = MockAuthNotifier();
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          authProvider.overrideWith(() => mockAuthNotifier),
        ],
        child: const MaterialApp(
          home: LoginPage(),
        ),
      );
    }

    testWidgets('should display login form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Find email field
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email + Password
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should display login button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should show password toggle button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Find password visibility toggle
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Tap to toggle password visibility
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should validate empty email field', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap login button without entering email
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show validation error
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('should validate invalid email format', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show validation error
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('should validate empty password field', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter valid email but no password
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show validation error
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('should show loading indicator during login', (WidgetTester tester) async {
      // Setup mock to return a delayed future
      when(mockAuthNotifier.login(any, any))
          .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 100)));

      await tester.pumpWidget(createWidgetUnderTest());

      // Enter valid credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      // Tap login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should call login with correct credentials', (WidgetTester tester) async {
      when(mockAuthNotifier.login(any, any))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());

      const email = 'test@example.com';
      const password = 'password123';

      // Enter credentials
      await tester.enterText(find.byType(TextFormField).first, email);
      await tester.enterText(find.byType(TextFormField).last, password);

      // Tap login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify login was called with correct parameters
      verify(mockAuthNotifier.login(email, password)).called(1);
    });

    testWidgets('should display NCM branding', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Should show NCM logo or branding
      expect(find.text('NCM'), findsWidgets);
    });

    testWidgets('should have remember me checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Should have remember me checkbox
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
    });

    testWidgets('should toggle remember me checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final checkbox = find.byType(Checkbox);

      // Initially unchecked
      Checkbox checkboxWidget = tester.widget(checkbox);
      expect(checkboxWidget.value, false);

      // Tap to check
      await tester.tap(checkbox);
      await tester.pump();

      // Should be checked now
      checkboxWidget = tester.widget(checkbox);
      expect(checkboxWidget.value, true);
    });
  });
}