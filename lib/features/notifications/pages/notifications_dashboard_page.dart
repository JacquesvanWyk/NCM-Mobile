import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/notification_provider.dart';
import 'send_notification_page.dart';

class NotificationsDashboardPage extends ConsumerWidget {
  const NotificationsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(pushNotificationStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(pushNotificationStatsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildQuickActions(context),
            const Gap(24),
            statsAsync.when(
              data: (stats) => _buildStatistics(stats),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => _buildErrorState(error.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        _ActionCard(
          title: 'Send Push Notification',
          icon: Icons.notifications_active,
          color: AppTheme.primaryColor,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SendNotificationPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatistics(PushNotificationStats stats) {
    final deliveryRate = stats.total > 0
        ? (stats.successfulDeliveries / stats.totalRecipients * 100)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _StatRow(
                  label: 'Total Notifications',
                  value: stats.total.toString(),
                  icon: Icons.notifications,
                  color: Colors.blue,
                ),
                const Divider(),
                _StatRow(
                  label: 'Sent',
                  value: stats.sent.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                const Divider(),
                _StatRow(
                  label: 'Pending',
                  value: stats.pending.toString(),
                  icon: Icons.pending,
                  color: Colors.orange,
                ),
                const Divider(),
                _StatRow(
                  label: 'Failed',
                  value: stats.failed.toString(),
                  icon: Icons.error,
                  color: Colors.red,
                ),
                const Divider(),
                _StatRow(
                  label: 'Delivery Rate',
                  value: '${deliveryRate.toStringAsFixed(1)}%',
                  icon: Icons.analytics,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String error) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const Gap(16),
            Text(
              'Failed to load statistics',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const Gap(12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const Gap(12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
