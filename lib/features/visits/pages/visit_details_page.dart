import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/visit_model.dart';
import '../../../providers/api_provider.dart';

class VisitDetailsPage extends ConsumerStatefulWidget {
  final VisitModel visit;

  const VisitDetailsPage({
    super.key,
    required this.visit,
  });

  @override
  ConsumerState<VisitDetailsPage> createState() => _VisitDetailsPageState();
}

class _VisitDetailsPageState extends ConsumerState<VisitDetailsPage> {
  VisitModel? _fullVisit;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVisitDetails();
  }

  Future<void> _loadVisitDetails() async {
    try {
      final apiService = ref.read(apiServiceProvider);
      final fullVisit = await apiService.getVisit(widget.visit.id);
      if (mounted) {
        setState(() {
          _fullVisit = fullVisit;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _fullVisit = widget.visit; // Fall back to passed visit
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visit = _fullVisit ?? widget.visit;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Visit Details'),
        actions: [
          if (visit.status == 'scheduled')
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit visit feature coming soon')),
                );
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getStatusColor(visit.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getStatusColor(visit.status)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(visit.status),
                    color: _getStatusColor(visit.status),
                  ),
                  const Gap(8),
                  Text(
                    _getStatusText(visit.status),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(visit.status),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(20),

            // Visit Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Visit Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(16),
                    _buildDetailRow('Visit Type', visit.visitType),
                    _buildDetailRow('Date', _formatDate(visit.visitDate ?? visit.scheduledDate ?? visit.actualDate ?? DateTime.now())),
                    _buildDetailRow('Time', _formatTime(visit.visitDate ?? visit.scheduledDate ?? visit.actualDate ?? DateTime.now())),
                    _buildDetailRow('Priority', visit.priority),
                    if (visit.locationAddress != null)
                      _buildDetailRow('Address', visit.locationAddress!),
                  ],
                ),
              ),
            ),

            const Gap(16),

            // Member Information
            if (visit.member != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Member Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                            child: Text(
                              (visit.member!.name?.isNotEmpty == true)
                                ? visit.member!.name!.substring(0, 1).toUpperCase()
                                : 'M',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${visit.member!.name} ${visit.member!.surname}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (visit.member!.displayPhone.isNotEmpty)
                                  Text(
                                    visit.member!.displayPhone,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const Gap(16),

            // Leader Information
            if (visit.leader != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Assigned Leader',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green.withOpacity(0.1),
                            child: const Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${visit.leader!.name} ${visit.leader!.surname}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (visit.leader!.telNumber != null)
                                  Text(
                                    visit.leader!.telNumber!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const Gap(16),

            // Visit Summary/Notes
            if (visit.summary != null && visit.summary!.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          visit.summary!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const Gap(16),

            // Visit Notes
            if (visit.visitNotes != null && visit.visitNotes!.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Visit Notes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${visit.visitNotes!.length} note${visit.visitNotes!.length > 1 ? 's' : ''}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(12),
                      ...visit.visitNotes!.map((note) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getNoteTypeColor(note.noteType).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _getNoteTypeColor(note.noteType).withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getNoteTypeColor(note.noteType),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    note.noteType,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (note.isPrivate) ...[
                                  const Gap(8),
                                  Icon(Icons.lock, size: 14, color: Colors.grey.shade600),
                                ],
                                const Spacer(),
                                if (note.createdAt != null)
                                  Text(
                                    _formatDateTime(note.createdAt!),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              note.content,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),

            const Gap(16),

            // Visit Stats (for completed visits)
            if (visit.status == 'completed')
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Visit Results',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(12),
                      if (visit.sentimentScore != null)
                        _buildDetailRow('Sentiment Score', '${visit.sentimentScore}/10'),
                      if (visit.memberSatisfaction != null)
                        _buildDetailRow('Member Satisfaction', visit.memberSatisfaction!),
                      if (visit.durationMinutes != null)
                        _buildDetailRow('Duration', '${visit.durationMinutes} minutes'),
                      if (visit.followUpRequired)
                        _buildDetailRow('Follow-up Required', 'Yes'),
                      if (visit.followUpDate != null)
                        _buildDetailRow('Follow-up Date', _formatDate(visit.followUpDate!)),
                    ],
                  ),
                ),
              ),

            const Gap(20),
          ],
        ),
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
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Icons.schedule;
      case 'in_progress':
        return Icons.play_circle;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return 'Visit Scheduled';
      case 'in_progress':
        return 'Visit In Progress';
      case 'completed':
        return 'Visit Completed';
      case 'cancelled':
        return 'Visit Cancelled';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    return '${_getDayName(date.weekday)}, ${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }

  Color _getNoteTypeColor(String noteType) {
    switch (noteType.toLowerCase()) {
      case 'general':
        return Colors.blue;
      case 'member feedback':
        return Colors.green;
      case 'issue reported':
        return Colors.orange;
      case 'service request':
        return Colors.purple;
      case 'complaint':
        return Colors.red;
      case 'follow-up':
        return Colors.teal;
      case 'registration':
        return Colors.indigo;
      case 'payment':
        return Colors.amber.shade700;
      case 'contact update':
        return Colors.cyan;
      case 'address change':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}