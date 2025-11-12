import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:ncm_mobile_app/features/dashboard/pages/field_worker_dashboard_page.dart';
import 'package:ncm_mobile_app/providers/visits_provider.dart';
import 'package:ncm_mobile_app/providers/auth_provider.dart';
import 'package:ncm_mobile_app/models/visit.dart';
import 'package:ncm_mobile_app/models/user.dart';

@GenerateMocks([VisitsNotifier, AuthNotifier])
import 'field_worker_dashboard_page_test.mocks.dart';

void main() {
  group('FieldWorkerDashboardPage Widget Tests', () {
    late MockVisitsNotifier mockVisitsNotifier;
    late MockAuthNotifier mockAuthNotifier;

    setUp(() {
      mockVisitsNotifier = MockVisitsNotifier();
      mockAuthNotifier = MockAuthNotifier();
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          visitsProvider.overrideWith(() => mockVisitsNotifier),
          authProvider.overrideWith(() => mockAuthNotifier),
        ],
        child: const MaterialApp(
          home: FieldWorkerDashboardPage(),
        ),
      );
    }

    testWidgets('should display dashboard title and greeting', (WidgetTester tester) async {
      final mockUser = User(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        role: 'field_worker',
      );

      when(mockAuthNotifier.currentUser).thenReturn(mockUser);
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Good morning, John'), findsOneWidget);
    });

    testWidgets('should display today\'s visits section', (WidgetTester tester) async {
      final mockUser = User(
        id: 1,
        name: 'Field Worker',
        email: 'fw@example.com',
        role: 'field_worker',
      );

      final todaysVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now(),
          purpose: 'Today\'s visit',
          status: 'scheduled',
          priority: 'high',
        ),
      ];

      when(mockAuthNotifier.currentUser).thenReturn(mockUser);
      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(todaysVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Today\'s Visits'), findsOneWidget);
      expect(find.text('Today\'s visit'), findsOneWidget);
    });

    testWidgets('should display quick actions section', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Register Member'), findsOneWidget);
      expect(find.text('Schedule Visit'), findsOneWidget);
      expect(find.text('View Reports'), findsOneWidget);
    });

    testWidgets('should display statistics cards', (WidgetTester tester) async {
      final mockVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now(),
          purpose: 'Visit 1',
          status: 'completed',
          priority: 'high',
        ),
        Visit(
          id: 2,
          memberId: 2,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().add(const Duration(days: 1)),
          purpose: 'Visit 2',
          status: 'scheduled',
          priority: 'medium',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should display statistics
      expect(find.text('Statistics'), findsOneWidget);
      expect(find.text('Total Visits'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('Scheduled'), findsOneWidget);
    });

    testWidgets('should navigate to member registration on quick action tap', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      // Tap on Register Member quick action
      await tester.tap(find.text('Register Member'));
      await tester.pumpAndSettle();

      // Should navigate to registration page (navigation testing would need proper setup)
      // For now, just verify the button is tappable
      expect(find.text('Register Member'), findsOneWidget);
    });

    testWidgets('should display urgent visits banner when present', (WidgetTester tester) async {
      final urgentVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().subtract(const Duration(hours: 1)), // Overdue
          purpose: 'Urgent visit',
          status: 'scheduled',
          priority: 'high',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(urgentVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should show urgent attention banner
      expect(find.text('Requires Attention'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('should show empty state for today\'s visits', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('No visits scheduled for today'), findsOneWidget);
      expect(find.text('Tap "Schedule Visit" to add one'), findsOneWidget);
    });

    testWidgets('should display recent activity section', (WidgetTester tester) async {
      final recentVisits = [
        Visit(
          id: 1,
          memberId: 1,
          fieldWorkerId: 1,
          municipalityId: 1,
          visitDate: DateTime.now().subtract(const Duration(days: 1)),
          purpose: 'Recent visit',
          status: 'completed',
          priority: 'medium',
        ),
      ];

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(recentVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Recent Activity'), findsOneWidget);
      expect(find.text('Recent visit'), findsOneWidget);
    });

    testWidgets('should show loading state', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.loading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should refresh data on pull down', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));
      when(mockVisitsNotifier.fetchVisits()).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());

      // Perform pull to refresh
      await tester.fling(find.byType(RefreshIndicator), const Offset(0, 300), 1000);
      await tester.pump();

      verify(mockVisitsNotifier.fetchVisits()).called(1);
    });

    testWidgets('should display floating action button for new visit', (WidgetTester tester) async {
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should show correct time-based greeting', (WidgetTester tester) async {
      final mockUser = User(
        id: 1,
        name: 'Field Worker',
        email: 'fw@example.com',
        role: 'field_worker',
      );

      when(mockAuthNotifier.currentUser).thenReturn(mockUser);
      when(mockVisitsNotifier.state).thenReturn(const AsyncValue.data([]));

      await tester.pumpWidget(createWidgetUnderTest());

      // Should show appropriate greeting based on time
      final greetings = ['Good morning', 'Good afternoon', 'Good evening'];
      final greetingFound = greetings.any((greeting) =>
          find.textContaining(greeting).evaluate().isNotEmpty);

      expect(greetingFound, isTrue);
    });

    testWidgets('should display performance metrics', (WidgetTester tester) async {
      final mockVisits = List.generate(10, (index) => Visit(
        id: index + 1,
        memberId: index + 1,
        fieldWorkerId: 1,
        municipalityId: 1,
        visitDate: DateTime.now().subtract(Duration(days: index)),
        purpose: 'Visit ${index + 1}',
        status: index % 2 == 0 ? 'completed' : 'scheduled',
        priority: 'medium',
      ));

      when(mockVisitsNotifier.state).thenReturn(AsyncValue.data(mockVisits));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should show performance metrics
      expect(find.text('This Week'), findsOneWidget);
      expect(find.text('This Month'), findsOneWidget);
    });
  });
}