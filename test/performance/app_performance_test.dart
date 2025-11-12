import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ncm_mobile_app/main.dart' as app;
import 'package:ncm_mobile_app/features/dashboard/pages/member_dashboard_page.dart';
import 'package:ncm_mobile_app/features/polls/pages/polls_page.dart';
import 'package:ncm_mobile_app/features/announcements/pages/announcements_page.dart';
import 'package:ncm_mobile_app/features/events/pages/events_page.dart';
import 'package:ncm_mobile_app/features/auth/pages/login_page.dart';
import 'package:ncm_mobile_app/core/services/auth_service.dart';
import 'package:ncm_mobile_app/core/services/api_service.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('NCM Mobile App Performance Tests', () {
    late Timeline timeline;
    late MemoryProfiler memoryProfiler;

    setUpAll(() {
      // Initialize performance monitoring
      timeline = Timeline();
      memoryProfiler = MemoryProfiler();
    });

    setUp(() async {
      // Clear any cached data before each test
      await AuthService.logout();
      binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    });

    tearDown(() async {
      // Clean up after each test
      timeline.finishSync();
      await memoryProfiler.dispose();
    });

    group('Widget Rendering Performance', () {
      testWidgets('Dashboard page rendering performance', (WidgetTester tester) async {
        final renderingMetrics = RenderingMetrics();

        // Start performance monitoring
        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: MemberDashboardPage(),
              ),
            ),
          );

          // Measure initial render time
          final stopwatch = Stopwatch()..start();
          await tester.pumpAndSettle();
          stopwatch.stop();

          renderingMetrics.initialRenderTime = stopwatch.elapsedMilliseconds;

          // Test widget rebuild performance
          await renderingMetrics.measureWidgetRebuilds(tester, 10);

          expect(renderingMetrics.initialRenderTime, lessThan(500),
            reason: 'Dashboard should render within 500ms');
          expect(renderingMetrics.averageRebuildTime, lessThan(16),
            reason: 'Widget rebuilds should be under 16ms (60fps)');
        }, reportKey: 'dashboard_rendering');
      });

      testWidgets('Login page rendering performance', (WidgetTester tester) async {
        final renderingMetrics = RenderingMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: LoginPage(),
              ),
            ),
          );

          final stopwatch = Stopwatch()..start();
          await tester.pumpAndSettle();
          stopwatch.stop();

          renderingMetrics.initialRenderTime = stopwatch.elapsedMilliseconds;

          expect(renderingMetrics.initialRenderTime, lessThan(300),
            reason: 'Login page should render within 300ms');
        }, reportKey: 'login_rendering');
      });

      testWidgets('Complex form rendering performance', (WidgetTester tester) async {
        final renderingMetrics = RenderingMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: ComplexFormWidget(),
                ),
              ),
            ),
          );

          final stopwatch = Stopwatch()..start();
          await tester.pumpAndSettle();
          stopwatch.stop();

          renderingMetrics.initialRenderTime = stopwatch.elapsedMilliseconds;

          expect(renderingMetrics.initialRenderTime, lessThan(400),
            reason: 'Complex forms should render within 400ms');
        }, reportKey: 'complex_form_rendering');
      });
    });

    group('List Scrolling Performance', () {
      testWidgets('Polls list scrolling performance', (WidgetTester tester) async {
        final scrollMetrics = ScrollPerformanceMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: PollsPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // Find scrollable widget
          final listView = find.byType(ListView).first;

          // Measure scroll performance
          await scrollMetrics.measureScrollPerformance(
            tester,
            listView,
            scrollDistance: 2000,
            duration: Duration(seconds: 2),
          );

          expect(scrollMetrics.averageFrameTime, lessThan(16),
            reason: 'Scroll should maintain 60fps (16ms per frame)');
          expect(scrollMetrics.droppedFrames, lessThan(5),
            reason: 'Should drop less than 5 frames during scroll');
        }, reportKey: 'polls_list_scrolling');
      });

      testWidgets('Announcements list scrolling performance', (WidgetTester tester) async {
        final scrollMetrics = ScrollPerformanceMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: AnnouncementsPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final listView = find.byType(ListView).first;

          await scrollMetrics.measureScrollPerformance(
            tester,
            listView,
            scrollDistance: 3000,
            duration: Duration(seconds: 3),
          );

          expect(scrollMetrics.averageFrameTime, lessThan(16));
          expect(scrollMetrics.droppedFrames, lessThan(5));
        }, reportKey: 'announcements_list_scrolling');
      });

      testWidgets('Events list scrolling performance', (WidgetTester tester) async {
        final scrollMetrics = ScrollPerformanceMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: EventsPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final listView = find.byType(ListView).first;

          await scrollMetrics.measureScrollPerformance(
            tester,
            listView,
            scrollDistance: 2500,
            duration: Duration(milliseconds: 2500),
          );

          expect(scrollMetrics.averageFrameTime, lessThan(16));
          expect(scrollMetrics.droppedFrames, lessThan(5));
        }, reportKey: 'events_list_scrolling');
      });

      testWidgets('Large list with images scrolling performance', (WidgetTester tester) async {
        final scrollMetrics = ScrollPerformanceMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: LargeImageListWidget(itemCount: 100),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final listView = find.byType(ListView).first;

          await scrollMetrics.measureScrollPerformance(
            tester,
            listView,
            scrollDistance: 5000,
            duration: Duration(seconds: 5),
          );

          expect(scrollMetrics.averageFrameTime, lessThan(20),
            reason: 'Image list should maintain reasonable performance');
          expect(scrollMetrics.droppedFrames, lessThan(10),
            reason: 'Should handle image loading during scroll');
        }, reportKey: 'image_list_scrolling');
      });
    });

    group('Image Loading Performance', () {
      testWidgets('Cached network image loading performance', (WidgetTester tester) async {
        final imageMetrics = ImageLoadingMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: ImageLoadingTestWidget(),
                ),
              ),
            ),
          );

          await imageMetrics.measureImageLoading(tester, [
            'https://picsum.photos/200/200?random=1',
            'https://picsum.photos/300/300?random=2',
            'https://picsum.photos/400/400?random=3',
          ]);

          expect(imageMetrics.averageLoadTime, lessThan(2000),
            reason: 'Images should load within 2 seconds');
          expect(imageMetrics.cacheHitRate, greaterThan(0.5),
            reason: 'Should have reasonable cache hit rate');
        }, reportKey: 'image_loading');
      });

      testWidgets('Image memory usage during loading', (WidgetTester tester) async {
        await binding.traceAction(() async {
          final initialMemory = await memoryProfiler.getCurrentMemoryUsage();

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: MultipleImageWidget(count: 20),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final finalMemory = await memoryProfiler.getCurrentMemoryUsage();
          final memoryIncrease = finalMemory - initialMemory;

          expect(memoryIncrease, lessThan(50 * 1024 * 1024),
            reason: 'Memory increase should be less than 50MB for 20 images');
        }, reportKey: 'image_memory_usage');
      });
    });

    group('Navigation Performance', () {
      testWidgets('Navigation transition performance', (WidgetTester tester) async {
        final navigationMetrics = NavigationMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: MemberDashboardPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // Test navigation to different pages
          final routes = [
            'Polls',
            'Announcements',
            'Events',
            'Feedback',
            'Payments',
          ];

          for (String route in routes) {
            await navigationMetrics.measureNavigation(tester, route);
          }

          expect(navigationMetrics.averageNavigationTime, lessThan(300),
            reason: 'Navigation should complete within 300ms');
          expect(navigationMetrics.maxNavigationTime, lessThan(500),
            reason: 'No navigation should take more than 500ms');
        }, reportKey: 'navigation_performance');
      });

      testWidgets('Back navigation performance', (WidgetTester tester) async {
        final navigationMetrics = NavigationMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: MemberDashboardPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // Navigate to a page and back multiple times
          for (int i = 0; i < 5; i++) {
            await navigationMetrics.measureBackNavigation(tester);
          }

          expect(navigationMetrics.averageBackNavigationTime, lessThan(200),
            reason: 'Back navigation should be faster than forward navigation');
        }, reportKey: 'back_navigation_performance');
      });
    });

    group('Memory Usage Tests', () {
      testWidgets('Memory usage during normal app usage', (WidgetTester tester) async {
        await binding.traceAction(() async {
          final memorySnapshots = <MemorySnapshot>[];

          // Initial memory snapshot
          memorySnapshots.add(await memoryProfiler.takeSnapshot('initial'));

          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: MemberDashboardPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();
          memorySnapshots.add(await memoryProfiler.takeSnapshot('dashboard_loaded'));

          // Navigate through different pages
          await tester.tap(find.text('Polls & Surveys'));
          await tester.pumpAndSettle();
          memorySnapshots.add(await memoryProfiler.takeSnapshot('polls_loaded'));

          await tester.pageBack();
          await tester.pumpAndSettle();
          memorySnapshots.add(await memoryProfiler.takeSnapshot('back_to_dashboard'));

          // Analyze memory usage patterns
          final analysis = memoryProfiler.analyzeSnapshots(memorySnapshots);

          expect(analysis.maxMemoryUsage, lessThan(100 * 1024 * 1024),
            reason: 'App should use less than 100MB of memory');
          expect(analysis.memoryLeakDetected, isFalse,
            reason: 'No memory leaks should be detected');
        }, reportKey: 'memory_usage');
      });

      testWidgets('Memory cleanup after page disposal', (WidgetTester tester) async {
        await binding.traceAction(() async {
          final initialMemory = await memoryProfiler.getCurrentMemoryUsage();

          // Create and dispose widgets multiple times
          for (int i = 0; i < 10; i++) {
            await tester.pumpWidget(
              ProviderScope(
                child: MaterialApp(
                  home: MemoryIntensiveWidget(key: ValueKey(i)),
                ),
              ),
            );
            await tester.pumpAndSettle();

            await tester.pumpWidget(Container());
            await tester.pumpAndSettle();
          }

          // Force garbage collection
          await memoryProfiler.forceGarbageCollection();

          final finalMemory = await memoryProfiler.getCurrentMemoryUsage();
          final memoryIncrease = finalMemory - initialMemory;

          expect(memoryIncrease, lessThan(10 * 1024 * 1024),
            reason: 'Memory should be cleaned up after widget disposal');
        }, reportKey: 'memory_cleanup');
      });
    });

    group('Network Request Performance', () {
      testWidgets('API request response time', (WidgetTester tester) async {
        final networkMetrics = NetworkMetrics();

        await binding.traceAction(() async {
          // Mock API service calls
          final apiRequests = [
            () => ApiService.getPolls(),
            () => ApiService.getAnnouncements(),
            () => ApiService.getEvents(),
            () => ApiService.getUserProfile(),
          ];

          for (var request in apiRequests) {
            await networkMetrics.measureApiCall(request);
          }

          expect(networkMetrics.averageResponseTime, lessThan(2000),
            reason: 'API calls should complete within 2 seconds');
          expect(networkMetrics.slowRequestCount, lessThan(2),
            reason: 'Most requests should be reasonably fast');
        }, reportKey: 'network_performance');
      });

      testWidgets('Concurrent API requests performance', (WidgetTester tester) async {
        final networkMetrics = NetworkMetrics();

        await binding.traceAction(() async {
          final futures = <Future>[];

          // Fire multiple concurrent requests
          for (int i = 0; i < 5; i++) {
            futures.add(networkMetrics.measureConcurrentApiCall(() => ApiService.getPolls()));
          }

          await Future.wait(futures);

          expect(networkMetrics.concurrentRequestsCompletionTime, lessThan(3000),
            reason: 'Concurrent requests should not significantly slow down the app');
        }, reportKey: 'concurrent_network_performance');
      });
    });

    group('Database Operation Performance', () {
      testWidgets('Local storage read/write performance', (WidgetTester tester) async {
        final storageMetrics = StorageMetrics();

        await binding.traceAction(() async {
          // Test various storage operations
          await storageMetrics.measureStorageOperations([
            () => storageMetrics.writeData('user_profile', {'name': 'Test User'}),
            () => storageMetrics.readData('user_profile'),
            () => storageMetrics.writeData('app_settings', {'theme': 'dark'}),
            () => storageMetrics.readData('app_settings'),
            () => storageMetrics.deleteData('temp_data'),
          ]);

          expect(storageMetrics.averageWriteTime, lessThan(100),
            reason: 'Storage writes should complete within 100ms');
          expect(storageMetrics.averageReadTime, lessThan(50),
            reason: 'Storage reads should complete within 50ms');
        }, reportKey: 'storage_performance');
      });

      testWidgets('Bulk data operations performance', (WidgetTester tester) async {
        final storageMetrics = StorageMetrics();

        await binding.traceAction(() async {
          // Test bulk operations
          final largeDataset = List.generate(1000, (i) => {'id': i, 'data': 'Item $i'});

          await storageMetrics.measureBulkOperations(largeDataset);

          expect(storageMetrics.bulkWriteTime, lessThan(1000),
            reason: 'Bulk writes should complete within 1 second');
          expect(storageMetrics.bulkReadTime, lessThan(500),
            reason: 'Bulk reads should complete within 500ms');
        }, reportKey: 'bulk_storage_performance');
      });
    });

    group('Animation Performance', () {
      testWidgets('Page transition animations', (WidgetTester tester) async {
        final animationMetrics = AnimationMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: MemberDashboardPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // Test various animations
          await animationMetrics.measurePageTransition(tester, 'Polls & Surveys');
          await animationMetrics.measurePageTransition(tester, 'Back');

          expect(animationMetrics.averageAnimationFrameTime, lessThan(16),
            reason: 'Animation should maintain 60fps');
          expect(animationMetrics.droppedAnimationFrames, lessThan(3),
            reason: 'Should drop minimal frames during animations');
        }, reportKey: 'animation_performance');
      });

      testWidgets('Complex animation performance', (WidgetTester tester) async {
        final animationMetrics = AnimationMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: ComplexAnimationWidget(),
              ),
            ),
          );

          await animationMetrics.measureComplexAnimation(tester, duration: Duration(seconds: 2));

          expect(animationMetrics.complexAnimationFrameTime, lessThan(20),
            reason: 'Complex animations should maintain reasonable performance');
        }, reportKey: 'complex_animation_performance');
      });
    });

    group('Overall App Performance', () {
      testWidgets('App startup performance', (WidgetTester tester) async {
        final startupMetrics = StartupMetrics();

        await binding.traceAction(() async {
          await startupMetrics.measureAppStartup(() async {
            app.main();
            await tester.pumpAndSettle();
          });

          expect(startupMetrics.totalStartupTime, lessThan(3000),
            reason: 'App should start within 3 seconds');
          expect(startupMetrics.timeToFirstFrame, lessThan(1000),
            reason: 'First frame should appear within 1 second');
        }, reportKey: 'app_startup');
      });

      testWidgets('App performance under stress', (WidgetTester tester) async {
        final stressMetrics = StressTestMetrics();

        await binding.traceAction(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                home: MemberDashboardPage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // Simulate heavy usage
          await stressMetrics.runStressTest(tester, duration: Duration(seconds: 30));

          expect(stressMetrics.averageResponseTime, lessThan(100),
            reason: 'App should remain responsive under stress');
          expect(stressMetrics.crashCount, equals(0),
            reason: 'App should not crash under stress');
        }, reportKey: 'stress_test');
      });
    });
  });
}

// Helper Classes for Performance Monitoring

class RenderingMetrics {
  int initialRenderTime = 0;
  int averageRebuildTime = 0;
  final List<int> rebuildTimes = [];

  Future<void> measureWidgetRebuilds(WidgetTester tester, int iterations) async {
    for (int i = 0; i < iterations; i++) {
      final stopwatch = Stopwatch()..start();
      await tester.pump();
      stopwatch.stop();
      rebuildTimes.add(stopwatch.elapsedMicroseconds ~/ 1000);
    }

    if (rebuildTimes.isNotEmpty) {
      averageRebuildTime = rebuildTimes.reduce((a, b) => a + b) ~/ rebuildTimes.length;
    }
  }
}

class ScrollPerformanceMetrics {
  double averageFrameTime = 0;
  int droppedFrames = 0;
  final List<double> frameTimes = [];

  Future<void> measureScrollPerformance(
    WidgetTester tester,
    Finder listFinder, {
    required double scrollDistance,
    required Duration duration,
  }) async {
    final frameTimings = <FrameTiming>[];

    // Start frame timing collection
    WidgetsBinding.instance.addTimingsCallback((timings) {
      frameTimings.addAll(timings);
    });

    // Perform scroll
    await tester.fling(listFinder, Offset(0, -scrollDistance), 1000);
    await tester.pumpAndSettle();

    // Analyze frame timings
    if (frameTimings.isNotEmpty) {
      frameTimes.addAll(frameTimings.map((t) => t.totalSpan.inMicroseconds / 1000));
      averageFrameTime = frameTimes.reduce((a, b) => a + b) / frameTimes.length;
      droppedFrames = frameTimes.where((time) => time > 16.67).length;
    }
  }
}

class ImageLoadingMetrics {
  int averageLoadTime = 0;
  double cacheHitRate = 0;
  final List<int> loadTimes = [];
  int cacheHits = 0;
  int totalLoads = 0;

  Future<void> measureImageLoading(WidgetTester tester, List<String> imageUrls) async {
    for (String url in imageUrls) {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Image.network(url),
          ),
        ),
      );

      await tester.pumpAndSettle();
      stopwatch.stop();

      loadTimes.add(stopwatch.elapsedMilliseconds);
      totalLoads++;
    }

    if (loadTimes.isNotEmpty) {
      averageLoadTime = loadTimes.reduce((a, b) => a + b) ~/ loadTimes.length;
    }

    cacheHitRate = totalLoads > 0 ? cacheHits / totalLoads : 0;
  }
}

class NavigationMetrics {
  int averageNavigationTime = 0;
  int maxNavigationTime = 0;
  int averageBackNavigationTime = 0;
  final List<int> navigationTimes = [];
  final List<int> backNavigationTimes = [];

  Future<void> measureNavigation(WidgetTester tester, String destination) async {
    final stopwatch = Stopwatch()..start();

    await tester.tap(find.text(destination));
    await tester.pumpAndSettle();

    stopwatch.stop();
    final time = stopwatch.elapsedMilliseconds;
    navigationTimes.add(time);

    if (time > maxNavigationTime) {
      maxNavigationTime = time;
    }

    averageNavigationTime = navigationTimes.reduce((a, b) => a + b) ~/ navigationTimes.length;
  }

  Future<void> measureBackNavigation(WidgetTester tester) async {
    // Navigate forward first
    await tester.tap(find.text('Polls & Surveys'));
    await tester.pumpAndSettle();

    final stopwatch = Stopwatch()..start();
    await tester.pageBack();
    await tester.pumpAndSettle();
    stopwatch.stop();

    backNavigationTimes.add(stopwatch.elapsedMilliseconds);

    if (backNavigationTimes.isNotEmpty) {
      averageBackNavigationTime = backNavigationTimes.reduce((a, b) => a + b) ~/ backNavigationTimes.length;
    }
  }
}

class MemoryProfiler {
  Future<int> getCurrentMemoryUsage() async {
    // Simulate memory measurement
    return ProcessInfo.currentRss;
  }

  Future<MemorySnapshot> takeSnapshot(String label) async {
    return MemorySnapshot(
      label: label,
      timestamp: DateTime.now(),
      memoryUsage: await getCurrentMemoryUsage(),
    );
  }

  MemoryAnalysis analyzeSnapshots(List<MemorySnapshot> snapshots) {
    if (snapshots.isEmpty) {
      return MemoryAnalysis(
        maxMemoryUsage: 0,
        memoryLeakDetected: false,
        growthRate: 0,
      );
    }

    final maxUsage = snapshots.map((s) => s.memoryUsage).reduce(max);
    final growthRate = snapshots.length > 1
        ? (snapshots.last.memoryUsage - snapshots.first.memoryUsage) / snapshots.length
        : 0;

    return MemoryAnalysis(
      maxMemoryUsage: maxUsage,
      memoryLeakDetected: growthRate > 1024 * 1024, // 1MB growth per snapshot
      growthRate: growthRate,
    );
  }

  Future<void> forceGarbageCollection() async {
    // Force garbage collection
    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  Future<void> dispose() async {
    // Cleanup resources
  }
}

class NetworkMetrics {
  int averageResponseTime = 0;
  int slowRequestCount = 0;
  int concurrentRequestsCompletionTime = 0;
  final List<int> responseTimes = [];

  Future<void> measureApiCall(Future<dynamic> Function() apiCall) async {
    final stopwatch = Stopwatch()..start();

    try {
      await apiCall();
    } catch (e) {
      // Handle API errors
    }

    stopwatch.stop();
    final time = stopwatch.elapsedMilliseconds;
    responseTimes.add(time);

    if (time > 3000) {
      slowRequestCount++;
    }

    if (responseTimes.isNotEmpty) {
      averageResponseTime = responseTimes.reduce((a, b) => a + b) ~/ responseTimes.length;
    }
  }

  Future<void> measureConcurrentApiCall(Future<dynamic> Function() apiCall) async {
    final stopwatch = Stopwatch()..start();

    try {
      await apiCall();
    } catch (e) {
      // Handle API errors
    }

    stopwatch.stop();
    concurrentRequestsCompletionTime = stopwatch.elapsedMilliseconds;
  }
}

class StorageMetrics {
  int averageWriteTime = 0;
  int averageReadTime = 0;
  int bulkWriteTime = 0;
  int bulkReadTime = 0;
  final List<int> writeTimes = [];
  final List<int> readTimes = [];

  Future<void> measureStorageOperations(List<Future<void> Function()> operations) async {
    for (var operation in operations) {
      final stopwatch = Stopwatch()..start();
      await operation();
      stopwatch.stop();
      // Categorize based on operation type (simplified)
      writeTimes.add(stopwatch.elapsedMilliseconds);
    }

    if (writeTimes.isNotEmpty) {
      averageWriteTime = writeTimes.reduce((a, b) => a + b) ~/ writeTimes.length;
    }
    if (readTimes.isNotEmpty) {
      averageReadTime = readTimes.reduce((a, b) => a + b) ~/ readTimes.length;
    }
  }

  Future<void> measureBulkOperations(List<Map<String, dynamic>> data) async {
    final writeStopwatch = Stopwatch()..start();
    await writeBulkData(data);
    writeStopwatch.stop();
    bulkWriteTime = writeStopwatch.elapsedMilliseconds;

    final readStopwatch = Stopwatch()..start();
    await readBulkData();
    readStopwatch.stop();
    bulkReadTime = readStopwatch.elapsedMilliseconds;
  }

  Future<void> writeData(String key, dynamic value) async {
    await Future.delayed(Duration(milliseconds: 10)); // Simulate storage write
  }

  Future<dynamic> readData(String key) async {
    await Future.delayed(Duration(milliseconds: 5)); // Simulate storage read
    return {'mock': 'data'};
  }

  Future<void> deleteData(String key) async {
    await Future.delayed(Duration(milliseconds: 5)); // Simulate storage delete
  }

  Future<void> writeBulkData(List<Map<String, dynamic>> data) async {
    await Future.delayed(Duration(milliseconds: data.length ~/ 10)); // Simulate bulk write
  }

  Future<List<Map<String, dynamic>>> readBulkData() async {
    await Future.delayed(Duration(milliseconds: 50)); // Simulate bulk read
    return [];
  }
}

class AnimationMetrics {
  double averageAnimationFrameTime = 0;
  int droppedAnimationFrames = 0;
  double complexAnimationFrameTime = 0;

  Future<void> measurePageTransition(WidgetTester tester, String action) async {
    final frameTimings = <FrameTiming>[];

    WidgetsBinding.instance.addTimingsCallback((timings) {
      frameTimings.addAll(timings);
    });

    if (action == 'Back') {
      await tester.pageBack();
    } else {
      await tester.tap(find.text(action));
    }

    await tester.pumpAndSettle();

    if (frameTimings.isNotEmpty) {
      final frameTimes = frameTimings.map((t) => t.totalSpan.inMicroseconds / 1000).toList();
      averageAnimationFrameTime = frameTimes.reduce((a, b) => a + b) / frameTimes.length;
      droppedAnimationFrames = frameTimes.where((time) => time > 16.67).length;
    }
  }

  Future<void> measureComplexAnimation(WidgetTester tester, {required Duration duration}) async {
    final frameTimings = <FrameTiming>[];

    WidgetsBinding.instance.addTimingsCallback((timings) {
      frameTimings.addAll(timings);
    });

    // Trigger complex animation
    await tester.tap(find.byKey(Key('complex_animation_trigger')));
    await tester.pump(duration);

    if (frameTimings.isNotEmpty) {
      final frameTimes = frameTimings.map((t) => t.totalSpan.inMicroseconds / 1000).toList();
      complexAnimationFrameTime = frameTimes.reduce((a, b) => a + b) / frameTimes.length;
    }
  }
}

class StartupMetrics {
  int totalStartupTime = 0;
  int timeToFirstFrame = 0;

  Future<void> measureAppStartup(Future<void> Function() startupFunction) async {
    final stopwatch = Stopwatch()..start();

    await startupFunction();

    stopwatch.stop();
    totalStartupTime = stopwatch.elapsedMilliseconds;
    timeToFirstFrame = stopwatch.elapsedMilliseconds; // Simplified
  }
}

class StressTestMetrics {
  int averageResponseTime = 0;
  int crashCount = 0;
  final List<int> responseTimes = [];

  Future<void> runStressTest(WidgetTester tester, {required Duration duration}) async {
    final endTime = DateTime.now().add(duration);

    while (DateTime.now().isBefore(endTime)) {
      try {
        final stopwatch = Stopwatch()..start();

        // Simulate various user interactions
        await tester.tap(find.text('Polls & Surveys'));
        await tester.pumpAndSettle();
        await tester.pageBack();
        await tester.pumpAndSettle();

        stopwatch.stop();
        responseTimes.add(stopwatch.elapsedMilliseconds);
      } catch (e) {
        crashCount++;
      }
    }

    if (responseTimes.isNotEmpty) {
      averageResponseTime = responseTimes.reduce((a, b) => a + b) ~/ responseTimes.length;
    }
  }
}

// Helper Data Classes

class MemorySnapshot {
  final String label;
  final DateTime timestamp;
  final int memoryUsage;

  MemorySnapshot({
    required this.label,
    required this.timestamp,
    required this.memoryUsage,
  });
}

class MemoryAnalysis {
  final int maxMemoryUsage;
  final bool memoryLeakDetected;
  final double growthRate;

  MemoryAnalysis({
    required this.maxMemoryUsage,
    required this.memoryLeakDetected,
    required this.growthRate,
  });
}

// Test Widgets

class ComplexFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complex Form')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: List.generate(20, (index) =>
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Field ${index + 1}',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LargeImageListWidget extends StatelessWidget {
  final int itemCount;

  const LargeImageListWidget({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => ListTile(
        leading: Image.network('https://picsum.photos/50/50?random=$index'),
        title: Text('Item $index'),
        subtitle: Text('Description for item $index'),
      ),
    );
  }
}

class ImageLoadingTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network('https://picsum.photos/200/200?random=1'),
        Image.network('https://picsum.photos/300/300?random=2'),
        Image.network('https://picsum.photos/400/400?random=3'),
      ],
    );
  }
}

class MultipleImageWidget extends StatelessWidget {
  final int count;

  const MultipleImageWidget({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: count,
      itemBuilder: (context, index) => Image.network('https://picsum.photos/100/100?random=$index'),
    );
  }
}

class MemoryIntensiveWidget extends StatelessWidget {
  const MemoryIntensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largeList = List.generate(10000, (index) => 'Item $index');

    return ListView.builder(
      itemCount: largeList.length,
      itemBuilder: (context, index) => ListTile(title: Text(largeList[index])),
    );
  }
}

class ComplexAnimationWidget extends StatefulWidget {
  @override
  _ComplexAnimationWidgetState createState() => _ComplexAnimationWidgetState();
}

class _ComplexAnimationWidgetState extends State<ComplexAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          key: Key('complex_animation_trigger'),
          onPressed: () => _controller.forward(),
          child: Text('Start Animation'),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Color.lerp(Colors.red, Colors.blue, _controller.value),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Mock API Service for testing
class ApiService {
  static Future<List<dynamic>> getPolls() async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.generate(10, (i) => {'id': i, 'title': 'Poll $i'});
  }

  static Future<List<dynamic>> getAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 600));
    return List.generate(15, (i) => {'id': i, 'title': 'Announcement $i'});
  }

  static Future<List<dynamic>> getEvents() async {
    await Future.delayed(Duration(milliseconds: 700));
    return List.generate(8, (i) => {'id': i, 'title': 'Event $i'});
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    await Future.delayed(Duration(milliseconds: 400));
    return {'name': 'Test User', 'email': 'test@example.com'};
  }
}