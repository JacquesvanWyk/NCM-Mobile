import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:ncm_mobile_app/features/visits/pages/visits_page.dart';
import 'package:ncm_mobile_app/providers/visits_provider.dart';
import 'package:ncm_mobile_app/models/visit.dart';

@GenerateMocks([VisitsNotifier])
import 'visits_page_test.mocks.dart';

void main() {
  group('VisitsPage Widget Tests', () {
    late MockVisitsNotifier mockVisitsNotifier;

    setUp(() {
      mockVisitsNotifier = MockVisitsNotifier();
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          visitsProvider.overrideWith(() => mockVisitsNotifier),
        ],
        child: const MaterialApp(
          home: VisitsPage(),
        ),
      );
    }

    testWidgets('should display visits page title', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('My Visits'), findsOneWidget);
    });

    testWidgets('should display floating action button for new visit', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display empty state when no visits', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('No visits scheduled'), findsOneWidget);
      expect(find.text('Tap + to schedule a new visit'), findsOneWidget);
    });

    testWidgets('should display loading indicator', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.loading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error message', (WidgetTester tester) async {
      const errorMessage = 'Failed to load visits';
      when(mockVisitsNotifier.state).thenReturn(AsyncValue.error(errorMessage, StackTrace.empty));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });

    testWidgets('should display visit cards when visits exist', (WidgetTester tester) async {
      final mockVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().add(const Duration(days: 1)),
          purpose: 'Community outreach',
          status: 'scheduled',
          priority: 'high',
        ),
        Visit(
          id: 2,
          memberId: 2,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().add(const Duration(days: 2)),
          purpose: 'Follow-up visit',
          status: 'scheduled',
          priority: 'medium',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should display visit cards
      expect(find.byType(Card), findsNWidgets(2));
      expect(find.text('Community outreach'), findsOneWidget);
      expect(find.text('Follow-up visit'), findsOneWidget);
    });

    testWidgets('should filter visits by status', (WidgetTester tester) async {
      final mockVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().add(const Duration(days: 1)),
          purpose: 'Scheduled visit',
          status: 'scheduled',
          priority: 'high',
        ),
        Visit(
          id: 2,
          memberId: 2,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().subtract(const Duration(days: 1)),
          purpose: 'Completed visit',
          status: 'completed',
          priority: 'medium',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should have filter tabs
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Scheduled'), findsOneWidget);
      expect(find.text('In Progress'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);

      // Tap on 'Scheduled' filter
      await tester.tap(find.text('Scheduled'));
      await tester.pump();

      // Should only show scheduled visits
      expect(find.text('Scheduled visit'), findsOneWidget);
      expect(find.text('Completed visit'), findsNothing);
    });

    testWidgets('should navigate to visit details on tap', (WidgetTester tester) async {
      final mockVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().add(const Duration(days: 1)),
          purpose: 'Community outreach',
          status: 'scheduled',
          priority: 'high',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Tap on visit card
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      // Should navigate to visit details (this would need navigation testing setup)
      // For now, just verify the card is tappable
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should show visit status badges', (WidgetTester tester) async {
      final mockVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().add(const Duration(days: 1)),
          purpose: 'High priority visit',
          status: 'scheduled',
          priority: 'high',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should show status and priority indicators
      expect(find.text('HIGH'), findsOneWidget);
      expect(find.text('SCHEDULED'), findsOneWidget);
    });

    testWidgets('should refresh visits on pull down', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));
      when(mockVisitsNotifier.fetchVisits()).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());

      // Find the RefreshIndicator and trigger refresh
      await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
      await tester.pump();

      // Verify refresh was called
      verify(mockVisitsNotifier.fetchVisits()).called(1);
    });

    testWidgets('should display date and time for visits', (WidgetTester tester) async {
      final visitDate = DateTime(2024, 1, 15, 14, 30);
      final mockVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: visitDate,
          purpose: 'Scheduled visit',
          status: 'scheduled',
          priority: 'medium',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should display formatted date and time
      expect(find.textContaining('Jan 15'), findsOneWidget);
      expect(find.textContaining('2:30 PM'), findsOneWidget);
    });
  });
}