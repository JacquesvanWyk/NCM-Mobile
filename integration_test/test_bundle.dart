// GENERATED CODE - DO NOT MODIFY BY HAND AND DO NOT COMMIT TO VERSION CONTROL
// ignore_for_file: type=lint, invalid_use_of_internal_member

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol/src/native/contracts/contracts.dart';
import 'package:test_api/src/backend/invoker.dart';

// START: GENERATED TEST IMPORTS
import 'announcement_test.dart' as announcement_test;
import 'auth_flow_test.dart' as auth_flow_test;
import 'dashboard_test.dart' as dashboard_test;
import 'debug_ui_test.dart' as debug_ui_test;
import 'event_test.dart' as event_test;
import 'feedback_test.dart' as feedback_test;
import 'full_flow_test.dart' as full_flow_test;
import 'login_test.dart' as login_test;
import 'payment_test.dart' as payment_test;
import 'poll_test.dart' as poll_test;
import 'polls_patrol_test.dart' as polls_patrol_test;
import 'profile_test.dart' as profile_test;
import 'simple_dashboard_test.dart' as simple_dashboard_test;
import 'simple_login_test.dart' as simple_login_test;
// END: GENERATED TEST IMPORTS

Future<void> main() async {
  // This is the entrypoint of the bundled Dart test.
  //
  // Its responsibilities are:
  //  * Running a special Dart test that runs before all the other tests and
  //    explores the hierarchy of groups and tests.
  //  * Hosting a PatrolAppService, which the native side of Patrol uses to get
  //    the Dart tests, and to request execution of a specific Dart test.
  //
  // When running on Android, the Android Test Orchestrator, before running the
  // tests, makes an initial run to gather the tests that it will later run. The
  // native side of Patrol (specifically: PatrolJUnitRunner class) is hooked
  // into the Android Test Orchestrator lifecycle and knows when that initial
  // run happens. When it does, PatrolJUnitRunner makes an RPC call to
  // PatrolAppService and asks it for Dart tests.
  //
  // When running on iOS, the native side of Patrol (specifically: the
  // PATROL_INTEGRATION_TEST_IOS_RUNNER macro) makes an initial run to gather
  // the tests that it will later run (same as the Android). During that initial
  // run, it makes an RPC call to PatrolAppService and asks it for Dart tests.
  //
  // Once the native runner has the list of Dart tests, it dynamically creates
  // native test cases from them. On Android, this is done using the
  // Parametrized JUnit runner. On iOS, new test case methods are swizzled into
  // the RunnerUITests class, taking advantage of the very dynamic nature of
  // Objective-C runtime.
  //
  // Execution of these dynamically created native test cases is then fully
  // managed by the underlying native test framework (JUnit on Android, XCTest
  // on iOS). The native test cases do only one thing - request execution of the
  // Dart test (out of which they had been created) and wait for it to complete.
  // The result of running the Dart test is the result of the native test case.

  final nativeAutomator = NativeAutomator(config: NativeAutomatorConfig());
  await nativeAutomator.initialize();
  final binding = PatrolBinding.ensureInitialized(NativeAutomatorConfig());
  final testExplorationCompleter = Completer<DartGroupEntry>();

  // A special test to explore the hierarchy of groups and tests. This is a hack
  // around https://github.com/dart-lang/test/issues/1998.
  //
  // This test must be the first to run. If not, the native side likely won't
  // receive any tests, and everything will fall apart.
  test('patrol_test_explorer', () {
    // Maybe somewhat counterintuitively, this callback runs *after* the calls
    // to group() below.
    final topLevelGroup = Invoker.current!.liveTest.groups.first;
    final dartTestGroup = createDartTestGroup(topLevelGroup,
      tags: null,
      excludeTags: null,
    );
    testExplorationCompleter.complete(dartTestGroup);
    print('patrol_test_explorer: obtained Dart-side test hierarchy:');
    reportGroupStructure(dartTestGroup);
  });

  // START: GENERATED TEST GROUPS
  group('announcement_test', announcement_test.main);
  group('auth_flow_test', auth_flow_test.main);
  group('dashboard_test', dashboard_test.main);
  group('debug_ui_test', debug_ui_test.main);
  group('event_test', event_test.main);
  group('feedback_test', feedback_test.main);
  group('full_flow_test', full_flow_test.main);
  group('login_test', login_test.main);
  group('payment_test', payment_test.main);
  group('poll_test', poll_test.main);
  group('polls_patrol_test', polls_patrol_test.main);
  group('profile_test', profile_test.main);
  group('simple_dashboard_test', simple_dashboard_test.main);
  group('simple_login_test', simple_login_test.main);
  // END: GENERATED TEST GROUPS

  final dartTestGroup = await testExplorationCompleter.future;
  final appService = PatrolAppService(topLevelDartTestGroup: dartTestGroup);
  binding.patrolAppService = appService;
  await runAppService(appService);

  // Until now, the native test runner was waiting for us, the Dart side, to
  // come alive. Now that we did, let's tell it that we're ready to be asked
  // about Dart tests.
  await nativeAutomator.markPatrolAppServiceReady();

  await appService.testExecutionCompleted;
}
