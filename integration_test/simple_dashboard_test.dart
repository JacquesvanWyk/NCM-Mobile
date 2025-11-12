import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Debug what actually shows on dashboard after login', (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(
      const ProviderScope(
        child: app.NCMApp(),
      ),
    );

    // Wait for splash screen and login
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Login as chairperson
    await tester.enterText(find.byType(TextFormField).at(0), 'chairperson@ncm.co.za');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));

    // Wait much longer for dashboard to fully load
    await tester.pumpAndSettle(const Duration(seconds: 10));
    await tester.pump(const Duration(seconds: 2)); // Extra time for FutureBuilder
    await tester.pumpAndSettle(const Duration(seconds: 3)); // Even more time

    print('=== ALL TEXT ON DASHBOARD ===');

    // Find all text widgets and print them
    final allText = find.byType(Text);
    final textWidgets = allText.evaluate().toList();

    for (int i = 0; i < textWidgets.length && i < 20; i++) {
      final widget = textWidgets[i].widget as Text;
      final textData = widget.data ?? widget.textSpan?.toPlainText() ?? 'No text';
      print('Text $i: "$textData"');
    }

    // Check what we actually have
    final loadingText = find.text('Loading...');
    final unknownUserText = find.text('Unknown User');
    final chairpersonText = find.text('Chairperson');

    print('=== SEARCH RESULTS ===');
    print('Loading... found: ${loadingText.evaluate().length}');
    print('Unknown User found: ${unknownUserText.evaluate().length}');
    print('Chairperson found: ${chairpersonText.evaluate().length}');

    expect(allText, findsAtLeast(10), reason: 'Should have many text widgets on dashboard');

    print('✅ Debug test completed - check output above');
  });
}