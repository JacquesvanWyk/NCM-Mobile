import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/visit_model.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/visits_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../dashboard/pages/dashboard_page.dart';
import '../../dashboard/pages/field_worker_dashboard_page.dart';
import 'visit_assignment_page.dart';
import 'visit_execution_page.dart';
import 'quick_add_visit_page.dart';
import 'visit_details_page.dart';

class VisitsPage extends ConsumerStatefulWidget {
  const VisitsPage({super.key});

  @override
  ConsumerState<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends ConsumerState<VisitsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to correct dashboard based on user type
            if (authNotifier.isLeader) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const FieldWorkerDashboardPage()),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const DashboardPage()),
                (route) => false,
              );
            }
          },
        ),
        title: const Text(
          'Visits',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment),
            onPressed: _navigateToVisitAssignment,
            tooltip: 'Visit Assignment',
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _showDatePicker,
            tooltip: 'Select Date',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddVisitDialog,
            tooltip: 'Add Visit',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Today'),
            Tab(text: 'Scheduled'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayVisits(),
          _buildScheduledVisits(),
          _buildCompletedVisits(),
        ],
      ),
    );
  }

  Widget _buildTodayVisits() {
    final visitsAsyncValue = ref.watch(visitsProvider);

    return visitsAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const Gap(16),
            Text('Error loading visits: $error'),
            const Gap(16),
            ElevatedButton(
              onPressed: () => ref.refresh(visitsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (visits) {
        // Filter visits by selected date
        final todayVisits = visits.where((visit) {
          final visitDate = visit.visitDate ?? visit.scheduledDate ?? visit.actualDate;
          if (visitDate == null) return false;
          return visitDate.year == _selectedDate.year &&
                 visitDate.month == _selectedDate.month &&
                 visitDate.day == _selectedDate.day;
        }).toList();

        return Column(
      children: [
        // Date Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatDate(_selectedDate),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '${todayVisits.length} visits scheduled',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Visits List
        Expanded(
          child: todayVisits.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const Gap(16),
                      Text(
                        'No visits scheduled for today',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: todayVisits.length,
                  itemBuilder: (context, index) {
                    return _buildVisitCard(todayVisits[index]);
                  },
                ),
        ),
      ],
    );
      },
    );
  }

  Widget _buildScheduledVisits() {
    final scheduledVisits = ref.read(visitsProvider.notifier).getScheduledVisits();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: scheduledVisits.length,
      itemBuilder: (context, index) {
        return _buildVisitCard(scheduledVisits[index]);
      },
    );
  }

  Widget _buildCompletedVisits() {
    final completedVisits = ref.read(visitsProvider.notifier).getCompletedVisits();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedVisits.length,
      itemBuilder: (context, index) {
        return _buildVisitCard(completedVisits[index], isCompleted: true);
      },
    );
  }

  Widget _buildVisitCard(VisitModel visit, {bool isCompleted = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with time and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    const Gap(4),
                    Text(
                      _formatTime(visit.visitDate ?? visit.scheduledDate ?? visit.actualDate ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                _buildStatusChip(visit.status),
              ],
            ),
            const Gap(12),
            // Member info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  child: Text(
                    visit.member?.displayFirstName.isNotEmpty == true ? visit.member!.displayFirstName.substring(0, 1).toUpperCase() : 'M',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${visit.member?.name ?? 'Unknown'} ${visit.member?.surname ?? 'Member'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        visit.visitType,
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
            const Gap(12),
            // Location
            if (visit.locationAddress != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      visit.locationAddress!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
            ],
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isCompleted) ...[
                  TextButton.icon(
                    onPressed: () => _startVisit(visit),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                  ),
                  const Gap(8),
                ],
                TextButton.icon(
                  onPressed: () => _viewVisitDetails(visit),
                  icon: const Icon(Icons.visibility),
                  label: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status.toLowerCase()) {
      case 'scheduled':
        color = Colors.blue;
        label = 'Scheduled';
        break;
      case 'in_progress':
        color = Colors.orange;
        label = 'In Progress';
        break;
      case 'completed':
        color = Colors.green;
        label = 'Completed';
        break;
      case 'cancelled':
        color = Colors.red;
        label = 'Cancelled';
        break;
      default:
        color = Colors.grey;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
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

  void _showDatePicker() async {
    final now = DateTime.now();
    final initialDate = _selectedDate.isAfter(DateTime(2026, 12, 31)) ? now : _selectedDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      // Show feedback to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Showing visits for ${_formatDate(picked)}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showAddVisitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Visit'),
        content: const Text(
          'Choose how you would like to add a visit:',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToVisitAssignment();
            },
            child: const Text('Manage Assignments'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showQuickAddVisit();
            },
            child: const Text('Quick Add'),
          ),
        ],
      ),
    );
  }

  void _showQuickAddVisit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QuickAddVisitPage(),
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Visit scheduled successfully'),
          backgroundColor: Colors.green,
        ),
      );
      // Refresh the visits
      ref.refresh(visitsProvider);
    }
  }

  void _startVisit(VisitModel visit) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisitExecutionPage(visit: visit),
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Visit completed successfully'),
          backgroundColor: Colors.green,
        ),
      );
      // Refresh the visits from API
      ref.refresh(visitsProvider);
    }
  }

  void _viewVisitDetails(VisitModel visit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisitDetailsPage(visit: visit),
      ),
    );
  }

  void _navigateToVisitAssignment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VisitAssignmentPage(),
      ),
    );
  }
}