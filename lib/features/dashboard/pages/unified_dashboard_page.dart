import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/dashboard_mode_provider.dart';
import 'member_dashboard_page.dart';
import 'field_worker_dashboard_page.dart';

class UnifiedDashboardPage extends ConsumerWidget {
  const UnifiedDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardMode = ref.watch(dashboardModeProvider);

    // Animate transition between dashboards
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: dashboardMode == DashboardMode.member
          ? const MemberDashboardPage(key: ValueKey('member-dashboard'))
          : const FieldWorkerDashboardPage(key: ValueKey('leader-dashboard')),
    );
  }
}
