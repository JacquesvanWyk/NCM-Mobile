import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../../providers/dashboard_mode_provider.dart';

class DashboardSwitcher extends ConsumerWidget {
  const DashboardSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: AuthService.isLeader(),
      builder: (context, snapshot) {
        // Only show switcher if user is a leader
        if (!snapshot.hasData || !snapshot.data!) {
          return const SizedBox.shrink();
        }

        final currentMode = ref.watch(dashboardModeProvider);
        final isLeaderMode = currentMode == DashboardMode.leader;

        return IconButton(
          icon: Icon(
            isLeaderMode ? Icons.person_outline : Icons.work_outline,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            final notifier = ref.read(dashboardModeProvider.notifier);
            notifier.toggle();

            // Show snackbar to indicate switch
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isLeaderMode
                      ? 'Switched to Member Dashboard'
                      : 'Switched to Leader Dashboard',
                ),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          tooltip: isLeaderMode ? 'Switch to Member View' : 'Switch to Leader View',
        );
      },
    );
  }
}

class DashboardSwitcherButton extends ConsumerWidget {
  const DashboardSwitcherButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: AuthService.isLeader(),
      builder: (context, snapshot) {
        // Only show switcher if user is a leader
        if (!snapshot.hasData || !snapshot.data!) {
          return const SizedBox.shrink();
        }

        final currentMode = ref.watch(dashboardModeProvider);
        final isLeaderMode = currentMode == DashboardMode.leader;

        return ElevatedButton.icon(
          onPressed: () {
            final notifier = ref.read(dashboardModeProvider.notifier);
            notifier.toggle();
          },
          icon: Icon(isLeaderMode ? Icons.person_outline : Icons.work_outline),
          label: Text(
            isLeaderMode ? 'Member View' : 'Leader View',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        );
      },
    );
  }
}
