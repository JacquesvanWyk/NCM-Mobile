import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/visits_provider.dart' show apiServiceProvider;
import '../providers/announcements_provider.dart';
import 'announcement_details_page.dart';

class AnnouncementsPage extends ConsumerStatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  ConsumerState<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends ConsumerState<AnnouncementsPage> {
  final _scrollController = ScrollController();
  String _filterPriority = 'all';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _markAsRead(ApiService apiService, AnnouncementModel announcement) async {
    if (announcement.isRead) return;

    try {
      await apiService.markAnnouncementAsRead(announcement.id);
      ref.invalidate(announcementsProvider);
    } catch (error) {
      debugPrint('Failed to mark announcement as read: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final announcementsAsync = ref.watch(announcementsProvider);
    final apiService = ref.watch(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() => _filterPriority = value);
              final priority = value == 'all' ? null : value;
              ref.read(announcementsProvider.notifier).filterByPriority(priority);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Priorities'),
              ),
              const PopupMenuItem(
                value: 'high',
                child: Text('High Priority'),
              ),
              const PopupMenuItem(
                value: 'medium',
                child: Text('Medium Priority'),
              ),
              const PopupMenuItem(
                value: 'low',
                child: Text('Low Priority'),
              ),
            ],
          ),
        ],
      ),
      body: announcementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const Gap(16),
              Text(
                'Failed to load announcements',
                style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
              ),
              const Gap(8),
              Text(
                error.toString(),
                style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              const Gap(24),
              ElevatedButton(
                onPressed: () => ref.refresh(announcementsProvider),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
        data: (announcements) => _buildAnnouncementsList(apiService, announcements),
      ),
    );
  }

  Widget _buildAnnouncementsList(ApiService apiService, List<AnnouncementModel> announcements) {
    if (announcements.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            Gap(16),
            Text(
              'No announcements available',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(announcementsProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return _AnnouncementCard(
            announcement: announcement,
            onTap: () => _navigateToAnnouncementDetails(apiService, announcement),
          );
        },
      ),
    );
  }

  void _navigateToAnnouncementDetails(ApiService apiService, AnnouncementModel announcement) {
    _markAsRead(apiService, announcement);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnnouncementDetailsPage(announcement: announcement),
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback onTap;

  const _AnnouncementCard({
    required this.announcement,
    required this.onTap,
  });

  Color _getPriorityColor() {
    switch (announcement.priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getPriorityText() {
    return announcement.priority.toUpperCase();
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(announcement.publishedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !announcement.isRead
                ? Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with priority and read status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getPriorityText(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (!announcement.isRead) ...[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(8),
                  ],
                  Text(
                    _getTimeAgo(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),

              const Gap(12),

              // Title
              Text(
                announcement.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: announcement.isRead ? FontWeight.w500 : FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),

              const Gap(8),

              // Content preview
              Text(
                announcement.content,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Gap(12),

              // Read more indicator
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Tap to read more',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(4),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}