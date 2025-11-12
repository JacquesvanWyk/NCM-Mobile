import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/services/offline_sync_service.dart';
import '../../../core/theme/app_theme.dart';

class SyncStatusWidget extends ConsumerWidget {
  const SyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityAsync = ref.watch(connectivityProvider);
    final syncStatus = ref.watch(syncStatusProvider);
    final offlineSyncService = ref.watch(offlineSyncServiceProvider);

    return connectivityAsync.when(
      data: (connectivity) {
        final status = offlineSyncService.getSyncStatus();
        final isOnline = status['isOnline'] as bool;
        final pendingSync = status['pendingSync'] as int;

        if (pendingSync == 0 && isOnline) {
          return const SizedBox.shrink(); // Don't show if everything is synced and online
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _getStatusColor(isOnline, pendingSync, syncStatus),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              _getStatusIcon(isOnline, pendingSync, syncStatus),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _getStatusTitle(isOnline, pendingSync, syncStatus),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (_getStatusSubtitle(isOnline, pendingSync, syncStatus).isNotEmpty)
                      Text(
                        _getStatusSubtitle(isOnline, pendingSync, syncStatus),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              ),
              if (syncStatus == SyncStatus.syncing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else if (pendingSync > 0 && isOnline)
                IconButton(
                  onPressed: () => _manualSync(ref),
                  icon: const Icon(Icons.sync, color: Colors.white, size: 20),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Color _getStatusColor(bool isOnline, int pendingSync, SyncStatus syncStatus) {
    if (syncStatus == SyncStatus.error) {
      return Colors.red[700]!;
    } else if (!isOnline) {
      return Colors.orange[700]!;
    } else if (pendingSync > 0) {
      return Colors.blue[700]!;
    } else if (syncStatus == SyncStatus.syncing) {
      return Colors.green[700]!;
    }
    return Colors.grey[600]!;
  }

  Icon _getStatusIcon(bool isOnline, int pendingSync, SyncStatus syncStatus) {
    if (syncStatus == SyncStatus.error) {
      return const Icon(Icons.error, color: Colors.white, size: 20);
    } else if (!isOnline) {
      return const Icon(Icons.cloud_off, color: Colors.white, size: 20);
    } else if (pendingSync > 0) {
      return const Icon(Icons.cloud_sync, color: Colors.white, size: 20);
    } else if (syncStatus == SyncStatus.syncing) {
      return const Icon(Icons.sync, color: Colors.white, size: 20);
    }
    return const Icon(Icons.cloud_done, color: Colors.white, size: 20);
  }

  String _getStatusTitle(bool isOnline, int pendingSync, SyncStatus syncStatus) {
    if (syncStatus == SyncStatus.error) {
      return 'Sync Error';
    } else if (!isOnline) {
      return 'Offline Mode';
    } else if (syncStatus == SyncStatus.syncing) {
      return 'Syncing...';
    } else if (pendingSync > 0) {
      return 'Pending Sync';
    }
    return 'All Synced';
  }

  String _getStatusSubtitle(bool isOnline, int pendingSync, SyncStatus syncStatus) {
    if (syncStatus == SyncStatus.error) {
      return 'Failed to sync data. Tap to retry.';
    } else if (!isOnline) {
      return pendingSync > 0
          ? '$pendingSync items will sync when online'
          : 'Data will be saved locally';
    } else if (syncStatus == SyncStatus.syncing) {
      return 'Uploading offline data...';
    } else if (pendingSync > 0) {
      return '$pendingSync items ready to sync';
    }
    return '';
  }

  Future<void> _manualSync(WidgetRef ref) async {
    final syncStatusNotifier = ref.read(syncStatusProvider.notifier);
    final offlineSyncService = ref.read(offlineSyncServiceProvider);

    try {
      syncStatusNotifier.setSyncing();
      await offlineSyncService.forcSync();
      syncStatusNotifier.setSuccess();
      await Future.delayed(const Duration(seconds: 2));
      syncStatusNotifier.setIdle();
    } catch (e) {
      syncStatusNotifier.setError();
      await Future.delayed(const Duration(seconds: 3));
      syncStatusNotifier.setIdle();
    }
  }
}

class SyncStatusPage extends ConsumerWidget {
  const SyncStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offlineSyncService = ref.watch(offlineSyncServiceProvider);
    final status = offlineSyncService.getSyncStatus();
    final pendingItems = offlineSyncService.getPendingItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Status'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sync Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        status['isOnline'] ? Icons.cloud_done : Icons.cloud_off,
                        color: status['isOnline'] ? Colors.green : Colors.orange,
                      ),
                      const Gap(8),
                      Text(
                        status['isOnline'] ? 'Online' : 'Offline',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  _buildStatusItem(
                    'Pending Items',
                    '${status['pendingSync']}',
                    Icons.pending,
                    Colors.orange,
                  ),
                  _buildStatusItem(
                    'Total Queued',
                    '${status['totalQueued']}',
                    Icons.queue,
                    Colors.blue,
                  ),
                  if (status['lastSync'] != null)
                    _buildStatusItem(
                      'Last Sync',
                      _formatDateTime(status['lastSync']),
                      Icons.access_time,
                      Colors.green,
                    ),
                ],
              ),
            ),

            const Gap(24),

            // Pending Items List
            if (pendingItems.isNotEmpty) ...[
              const Text(
                'Pending Sync Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const Gap(12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pendingItems.length,
                separatorBuilder: (context, index) => const Gap(8),
                itemBuilder: (context, index) {
                  final item = pendingItems[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(_getTypeIcon(item.type), size: 16),
                              const Gap(8),
                              Text(
                                '${item.type.toUpperCase()} - ${item.action.toUpperCase()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _formatDateTime(item.timestamp),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Gap(4),
                          Text(
                            item.data['title'] ??
                            item.data['description'] ??
                            'Data item',
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ] else ...[
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_done,
                      size: 64,
                      color: Colors.green,
                    ),
                    Gap(16),
                    Text(
                      'All data is synced!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Gap(8),
                    Text(
                      'No pending items to sync.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],

            const Gap(32),

            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: status['isOnline']
                        ? () => _manualSync(ref)
                        : null,
                    icon: const Icon(Icons.sync),
                    label: const Text('Force Sync'),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _clearQueue(ref),
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Clear Queue'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const Gap(8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'complaint':
        return Icons.report_problem;
      case 'feedback':
        return Icons.feedback;
      case 'visit':
        return Icons.location_on;
      default:
        return Icons.data_object;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _manualSync(WidgetRef ref) async {
    final offlineSyncService = ref.read(offlineSyncServiceProvider);
    try {
      await offlineSyncService.forcSync();
      // Show success message
    } catch (e) {
      // Show error message
    }
  }

  Future<void> _clearQueue(WidgetRef ref) async {
    final offlineSyncService = ref.read(offlineSyncServiceProvider);
    await offlineSyncService.clearSyncQueue();
  }
}