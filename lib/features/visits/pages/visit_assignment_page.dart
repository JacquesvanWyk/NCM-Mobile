import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/visit_model.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/visits_provider.dart';

class VisitAssignmentPage extends ConsumerStatefulWidget {
  const VisitAssignmentPage({super.key});

  @override
  ConsumerState<VisitAssignmentPage> createState() => _VisitAssignmentPageState();
}

class _VisitAssignmentPageState extends ConsumerState<VisitAssignmentPage> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';
  List<String> _selectedLeaders = [];

  final List<String> _filterOptions = [
    'All',
    'Unassigned',
    'Assigned',
    'Door-to-Door',
    'Follow-up',
    'Community Outreach'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visitsAsyncValue = ref.watch(visitsProvider);
    final leadersAsyncValue = ref.watch(leadersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Assignment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_add),
            onPressed: _showBulkAssignDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search visits or members...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const Gap(12),
                // Filter Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filterOptions.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = selected ? filter : 'All';
                            });
                          },
                          backgroundColor: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null,
                          selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          // Visits List
          Expanded(
            child: visitsAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (visits) {
                final filteredVisits = _filterVisits(visits);
                return leadersAsyncValue.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                  data: (leaders) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredVisits.length,
                    itemBuilder: (context, index) {
                      return _buildVisitAssignmentCard(filteredVisits[index], leaders);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'visitAssignmentCreate',
        onPressed: _showCreateVisitDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildVisitAssignmentCard(VisitModel visit, List<LeaderModel> leaders) {
    final isAssigned = visit.leaderId != null;
    final assignedLeader = isAssigned
        ? leaders.firstWhere((leader) => leader.id == visit.leaderId, orElse: () => leaders.first)
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with visit type and priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    visit.visitType,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                _buildPriorityChip(visit.priority),
              ],
            ),
            const Gap(12),
            // Member Information
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  child: Text(
                    (visit.member?.name?.isNotEmpty == true)
                      ? visit.member!.name!.substring(0, 1).toUpperCase()
                      : 'M',
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
                      if (visit.member?.displayPhone.isNotEmpty == true)
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
            const Gap(12),
            // Location and Date
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
                    visit.locationAddress ?? 'Address not specified',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
                const Gap(4),
                Text(
                  _formatDateTime(visit.visitDate ?? visit.scheduledDate ?? visit.actualDate ?? DateTime.now()),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const Gap(16),
            // Assignment Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAssigned ? Colors.green.shade50 : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isAssigned ? Colors.green.shade200 : Colors.orange.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isAssigned ? Icons.person : Icons.person_outline,
                        size: 16,
                        color: isAssigned ? Colors.green.shade700 : Colors.orange.shade700,
                      ),
                      const Gap(4),
                      Text(
                        isAssigned ? 'Assigned to:' : 'Unassigned',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isAssigned ? Colors.green.shade700 : Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                  if (isAssigned && assignedLeader != null) ...[
                    const Gap(8),
                    Text(
                      '${assignedLeader.name} ${assignedLeader.surname}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      assignedLeader.level,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Gap(16),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isAssigned)
                  TextButton.icon(
                    onPressed: () => _reassignVisit(visit, leaders),
                    icon: const Icon(Icons.swap_horiz, size: 16),
                    label: const Text('Reassign'),
                  )
                else
                  TextButton.icon(
                    onPressed: () => _assignVisit(visit, leaders),
                    icon: const Icon(Icons.person_add, size: 16),
                    label: const Text('Assign'),
                  ),
                const Gap(8),
                TextButton.icon(
                  onPressed: () => _editVisit(visit),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  List<VisitModel> _filterVisits(List<VisitModel> visits) {
    List<VisitModel> filtered = visits;

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((visit) {
        final memberName = '${visit.member?.name ?? ''} ${visit.member?.surname ?? ''}'.toLowerCase();
        final address = (visit.locationAddress ?? '').toLowerCase();
        return memberName.contains(query) || address.contains(query);
      }).toList();
    }

    // Apply status filter
    switch (_selectedFilter) {
      case 'Unassigned':
        filtered = filtered.where((visit) => visit.leaderId == null).toList();
        break;
      case 'Assigned':
        filtered = filtered.where((visit) => visit.leaderId != null).toList();
        break;
      case 'Door-to-Door':
      case 'Follow-up':
      case 'Community Outreach':
        filtered = filtered.where((visit) => visit.visitType == _selectedFilter).toList();
        break;
      // 'All' shows everything, no additional filtering needed
    }

    return filtered;
  }

  void _assignVisit(VisitModel visit, List<LeaderModel> leaders) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(16),
              Text(
                'Assign Visit',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(16),
              Text(
                'Select a leader to assign this visit to:',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                ),
              ),
              const Gap(16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: leaders.length,
                  itemBuilder: (context, index) {
                    final leader = leaders[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        child: Text(
                          leader.name.isNotEmpty
                            ? leader.name.substring(0, 1).toUpperCase()
                            : 'L',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      title: Text(
                        '${leader.name} ${leader.surname}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(leader.level),
                      trailing: Text(
                        '${_getLeaderActiveVisits(leader.id)} active',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _confirmAssignment(visit, leader);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reassignVisit(VisitModel visit, List<LeaderModel> leaders) {
    _assignVisit(visit, leaders);
  }

  void _confirmAssignment(VisitModel visit, LeaderModel leader) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Assignment'),
        content: Text(
          'Assign visit to ${leader.name} ${leader.surname}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performAssignment(visit, leader);
            },
            child: const Text('Assign'),
          ),
        ],
      ),
    );
  }

  void _performAssignment(VisitModel visit, LeaderModel leader) {
    setState(() {
      // Update visit assignment - this would be done through API in real app
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Visit assigned to ${leader.name} ${leader.surname}',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _editVisit(VisitModel visit) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit visit feature coming soon')),
    );
  }

  void _showBulkAssignDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bulk assignment feature coming soon')),
    );
  }

  void _showCreateVisitDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create visit feature coming soon')),
    );
  }

  // Mock data methods
  List<VisitModel> _getPendingVisits() {
    return [
      VisitModel(
        id: 1,
        memberId: 1,
        leaderId: null,
        municipalityId: 1,
        visitType: 'Door-to-Door',
        visitDate: DateTime.now().add(const Duration(hours: 2)),
        locationAddress: '123 Main Street, Springfield',
        status: 'scheduled',
        priority: 'high',
        member: MemberModel(
          id: 1,
          userId: 1,
          municipalityId: 1,
          membershipNumber: 'NCM001',
          idNumber: '8001011234567',
          name: 'Sarah',
          surname: 'Johnson',
          dateOfBirth: '1980-01-01',
          gender: 'Female',
          phoneNumber: '0821234567',
          address: '123 Main Street',
          town: 'Cape Town',
          ward: '12',
        ),
      ),
      VisitModel(
        id: 2,
        memberId: 2,
        leaderId: 2,
        municipalityId: 1,
        visitType: 'Follow-up',
        visitDate: DateTime.now().add(const Duration(hours: 4)),
        locationAddress: '456 Oak Avenue, Springfield',
        status: 'scheduled',
        priority: 'medium',
        member: MemberModel(
          id: 2,
          userId: 2,
          municipalityId: 1,
          membershipNumber: 'NCM002',
          idNumber: '7505155432198',
          name: 'Michael',
          surname: 'Brown',
          dateOfBirth: '1975-05-15',
          gender: 'Male',
          phoneNumber: '0837654321',
          address: '456 Oak Avenue',
          town: 'Cape Town',
          ward: '12',
        ),
      ),
    ];
  }

  List<LeaderModel> _getAvailableLeaders() {
    return [
      LeaderModel(
        id: 1,
        userId: 3,
        municipalityId: 1,
        name: 'Ethan',
        surname: 'Carter',
        level: 'Ward Convenor',
        telNumber: '0821112222',
        status: 'active',
        createdAt: DateTime(2020, 1, 1),
      ),
      LeaderModel(
        id: 2,
        userId: 4,
        municipalityId: 1,
        name: 'Jane',
        surname: 'Smith',
        level: 'Secretary',
        telNumber: '0823334444',
        status: 'active',
        createdAt: DateTime(2021, 6, 1),
      ),
    ];
  }

  int _getLeaderActiveVisits(int leaderId) {
    return 3; // Mock data - would be calculated from actual visits
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}