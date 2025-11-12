import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Payment Integration Tests', () {
    testWidgets('T058: Payment flow test', (WidgetTester tester) async {
      // Login first
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to payments
      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      // Should show payment options
      expect(find.text('Membership Payment'), findsOneWidget);
      expect(find.text('Current Status'), findsOneWidget);
      expect(find.byKey(const Key('make_payment_button')), findsOneWidget);

      // Tap make payment
      await tester.tap(find.byKey(const Key('make_payment_button')));
      await tester.pumpAndSettle();

      // Should show payment options
      expect(find.text('Select Payment Option'), findsOneWidget);
      expect(find.text('1 Year - R150'), findsOneWidget);
      expect(find.text('2 Years - R280'), findsOneWidget);
      expect(find.text('3 Years - R400'), findsOneWidget);

      // Select 1 year payment
      await tester.tap(find.byKey(const Key('payment_option_1_year')));
      await tester.pumpAndSettle();

      // Should show payment summary
      expect(find.text('Payment Summary'), findsOneWidget);
      expect(find.text('Amount: R150'), findsOneWidget);
      expect(find.text('Coverage: 1 Year'), findsOneWidget);

      // Proceed to payment
      await tester.tap(find.byKey(const Key('proceed_to_payment_button')));
      await tester.pumpAndSettle();

      // Should show payment methods
      expect(find.text('Choose Payment Method'), findsOneWidget);
      expect(find.text('Credit Card'), findsOneWidget);
      expect(find.text('EFT'), findsOneWidget);
      expect(find.text('PayFast'), findsOneWidget);

      // Select PayFast
      await tester.tap(find.byKey(const Key('payment_method_payfast')));
      await tester.tap(find.byKey(const Key('confirm_payment_button')));
      await tester.pumpAndSettle();

      // Should redirect to PayFast (simulate)
      expect(find.text('Redirecting to PayFast...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Payment retry functionality', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      // Should show failed payment
      expect(find.text('Payment Failed'), findsOneWidget);
      expect(find.byKey(const Key('retry_payment_button')), findsOneWidget);

      // Tap retry payment
      await tester.tap(find.byKey(const Key('retry_payment_button')));
      await tester.pumpAndSettle();

      // Should show retry confirmation
      expect(find.text('Retry Payment'), findsOneWidget);
      expect(find.text('Amount: R150'), findsOneWidget);

      await tester.tap(find.byKey(const Key('confirm_retry_button')));
      await tester.pumpAndSettle();

      // Should redirect to payment gateway
      expect(find.text('Redirecting to payment...'), findsOneWidget);
    });

    testWidgets('Payment history and status', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      // Should show membership status
      expect(find.text('Membership Status'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Expires:'), findsOneWidget);

      // Should show payment history section
      expect(find.text('Payment History'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Should show individual payments
      expect(find.text('Membership Payment - 1 Year'), findsAtLeastNWidgets(1));
      expect(find.text('Paid'), findsAtLeastNWidgets(1));
      expect(find.text('R150'), findsAtLeastNWidgets(1));

      // Tap on payment for details
      await tester.tap(find.byKey(const Key('payment_item_0')));
      await tester.pumpAndSettle();

      // Should show payment receipt
      expect(find.text('Payment Receipt'), findsOneWidget);
      expect(find.text('Payment ID'), findsOneWidget);
      expect(find.text('Payment Date'), findsOneWidget);
      expect(find.text('Coverage Period'), findsOneWidget);
    });

    testWidgets('Multiple year payment discount', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('make_payment_button')));
      await tester.pumpAndSettle();

      // Should show discount information
      expect(find.text('1 Year - R150'), findsOneWidget);
      expect(find.text('2 Years - R280 (Save R20)'), findsOneWidget);
      expect(find.text('3 Years - R400 (Save R50)'), findsOneWidget);

      // Select 3 year option
      await tester.tap(find.byKey(const Key('payment_option_3_years')));
      await tester.pumpAndSettle();

      // Should highlight savings
      expect(find.text('You save R50!'), findsOneWidget);
      expect(find.text('Amount: R400'), findsOneWidget);
      expect(find.text('Coverage: 3 Years'), findsOneWidget);
    });

    testWidgets('Payment validation and error handling', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      // Try to make payment without selecting option
      await tester.tap(find.byKey(const Key('make_payment_button')));
      await tester.pumpAndSettle();

      // Try to proceed without selecting payment option
      await tester.tap(find.byKey(const Key('proceed_to_payment_button')));
      await tester.pumpAndSettle();

      // Should show validation error
      expect(find.text('Please select a payment option'), findsOneWidget);

      // Select option and try without payment method
      await tester.tap(find.byKey(const Key('payment_option_1_year')));
      await tester.tap(find.byKey(const Key('proceed_to_payment_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('confirm_payment_button')));
      await tester.pumpAndSettle();

      // Should show payment method error
      expect(find.text('Please select a payment method'), findsOneWidget);
    });

    testWidgets('Payment offline queuing', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('email_field')), 'member@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Simulate offline mode
      await tester.tap(find.byKey(const Key('offline_mode_toggle')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      // Should show offline message
      expect(find.text('Offline Mode'), findsOneWidget);
      expect(find.text('Payment requires internet connection'), findsOneWidget);

      // Make payment button should be disabled
      final paymentButton = tester.widget<ElevatedButton>(find.byKey(const Key('make_payment_button')));
      expect(paymentButton.enabled, false);

      // Should show queued payments if any
      expect(find.text('Queued Payments'), findsOneWidget);
    });

    testWidgets('Membership expiry warning', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login with member whose membership is expiring soon
      await tester.enterText(find.byKey(const Key('email_field')), 'expiring@test.com');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should show expiry warning on dashboard
      expect(find.text('Membership Expiring Soon'), findsOneWidget);
      expect(find.text('Renew Now'), findsOneWidget);

      // Navigate to payments
      await tester.tap(find.byKey(const Key('payments_tab')));
      await tester.pumpAndSettle();

      // Should show expiry warning in payments
      expect(find.text('Expires in 7 days'), findsOneWidget);
      expect(find.byKey(const Key('urgent_renewal_banner')), findsOneWidget);

      // Make payment button should be prominent
      final paymentButton = tester.widget<ElevatedButton>(find.byKey(const Key('make_payment_button')));
      expect(paymentButton.style?.backgroundColor?.resolve({}), equals(Colors.red));
    });
  });
}