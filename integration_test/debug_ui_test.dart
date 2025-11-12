import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncm_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Debug - Find all buttons and text widgets', (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(
      const ProviderScope(
        child: app.NCMApp(),
      ),
    );

    // Wait for splash screen
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Find all buttons
    final allButtons = find.byType(ElevatedButton);
    final allTextButtons = find.byType(TextButton);
    final allOutlinedButtons = find.byType(OutlinedButton);
    final allFloatingButtons = find.byType(FloatingActionButton);
    final allGestureDetectors = find.byType(GestureDetector);
    final allInkWells = find.byType(InkWell);

    print('=== UI DEBUG INFO ===');
    print('ElevatedButton count: ${allButtons.evaluate().length}');
    print('TextButton count: ${allTextButtons.evaluate().length}');
    print('OutlinedButton count: ${allOutlinedButtons.evaluate().length}');
    print('FloatingActionButton count: ${allFloatingButtons.evaluate().length}');
    print('GestureDetector count: ${allGestureDetectors.evaluate().length}');
    print('InkWell count: ${allInkWells.evaluate().length}');

    // Try to find text widgets that might be login related
    final loginTexts = find.textContaining('Login', findRichText: true);
    final signInTexts = find.textContaining('Sign', findRichText: true);
    final enterTexts = find.textContaining('Enter', findRichText: true);
    final submitTexts = find.textContaining('Submit', findRichText: true);

    print('Text containing "Login": ${loginTexts.evaluate().length}');
    print('Text containing "Sign": ${signInTexts.evaluate().length}');
    print('Text containing "Enter": ${enterTexts.evaluate().length}');
    print('Text containing "Submit": ${submitTexts.evaluate().length}');

    // If we have buttons, let's try tapping the first one
    if (allButtons.evaluate().isNotEmpty) {
      print('Attempting to tap first ElevatedButton');
      await tester.tap(allButtons.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    } else if (allTextButtons.evaluate().isNotEmpty) {
      print('Attempting to tap first TextButton');
      await tester.tap(allTextButtons.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    print('✅ Debug UI test completed');
  });
}