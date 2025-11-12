import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/sms_provider.dart';

class SmsHistoryPage extends ConsumerStatefulWidget {
  const SmsHistoryPage({super.key});

  @override
  ConsumerState<SmsHistoryPage> createState() => _SmsHistoryPageState();
}

class _SmsHistoryPageState extends ConsumerState<SmsHistoryPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  String? _statusFilter;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(smsHistoryProvider.notifier).loadMoreHistory();
    }
  }

  Future<void> _refresh() async {
    await ref.read(smsHistoryProvider.notifier).refresh();
  }

  void _filterByStatus(String? status) {
    setState(() => _statusFilter = status);
    ref.read(smsHistoryProvider.notifier).filterByStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(smsHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS History'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter by status',
            onSelected: _filterByStatus,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Messages'),
              ),
              const PopupMenuItem(
                value: 'pending',
                child: Text('Pending'),
              ),
              const PopupMenuItem(
                value: 'sent',
                child: Text('Sent'),
              ),
              const PopupMenuItem(
                value: 'delivered',
                child: Text('Delivered'),
              ),
              const PopupMenuItem(
                value: 'failed',
                child: Text('Failed'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),

          // Content
          Expanded(
            child: historyAsync.when(
              data: (response) {
                final logs = _searchQuery.isEmpty
                    ? response.data
                    : ref.read(smsHistoryProvider.notifier).searchLogs(_searchQuery);

                if (logs.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: logs.length + 1,
                    itemBuilder: (context, index) {
                      if (index == logs.length) {
                        return _buildLoadMoreIndicator(response);
                      }
                      return _SmsLogCard(log: logs[index]);
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => _buildErrorState(error.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by recipient or content...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
      ),
    );
  }

  Widget _buildLoadMoreIndicator(PaginatedResponse<SmsLogModel> response) {
    if (response.currentPage >= response.lastPage) {
      return const SizedBox.shrink();
    }

    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            _searchQuery.isNotEmpty
                ? 'No messages found'
                : _statusFilter != null
                    ? 'No ${_statusFilter} messages'
                    : 'No SMS history',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try a different search term'
                : 'Your sent messages will appear here',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const Gap(16),
          Text(
            'Failed to load SMS history',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(8),
          Text(
            error,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          ElevatedButton(
            onPressed: _refresh,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

class _SmsLogCard extends StatelessWidget {
  final SmsLogModel log;

  const _SmsLogCard({required this.log});

  Color _getStatusColor() {
    switch (log.status) {
      case 'delivered':
        return Colors.green;
      case 'sent':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (log.status) {
      case 'delivered':
        return Icons.done_all;
      case 'sent':
        return Icons.done;
      case 'pending':
        return Icons.schedule;
      case 'failed':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showDetailsDialog(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status and time
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(),
                          size: 16,
                          color: _getStatusColor(),
                        ),
                        const Gap(4),
                        Text(
                          log.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _getTimeAgo(log.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),

              const Gap(12),

              // Recipient
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 18,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      log.recipientName ?? log.recipient,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              if (log.recipientName != null) ...[
                const Gap(4),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    const Gap(8),
                    Text(
                      log.recipient,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],

              const Gap(12),

              // Message preview
              Text(
                log.messageContent,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Error message if failed
              if (log.status == 'failed' && log.errorMessage != null) ...[
                const Gap(8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 16,
                        color: Colors.red,
                      ),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          log.errorMessage!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SMS Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Status', log.status.toUpperCase()),
              _buildDetailRow('Recipient', log.recipient),
              if (log.recipientName != null)
                _buildDetailRow('Name', log.recipientName!),
              _buildDetailRow('Message ID', log.messageId),
              _buildDetailRow('Created', _formatDateTime(log.createdAt)),
              if (log.sentAt != null)
                _buildDetailRow('Sent', _formatDateTime(log.sentAt)),
              if (log.deliveredAt != null)
                _buildDetailRow('Delivered', _formatDateTime(log.deliveredAt)),
              if (log.errorMessage != null)
                _buildDetailRow('Error', log.errorMessage!),
              const Gap(12),
              const Text(
                'Message:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  log.messageContent,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
