import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../data/models/supporter_model.dart';
import '../../../providers/supporters_provider.dart';

class SupportersListPage extends ConsumerStatefulWidget {
  const SupportersListPage({super.key});

  @override
  ConsumerState<SupportersListPage> createState() => _SupportersListPageState();
}

class _SupportersListPageState extends ConsumerState<SupportersListPage> {
  final _searchController = TextEditingController();
  String? _selectedWard;
  String? _selectedVoterFilter;

  final List<String> _voterFilterOptions = [
    'All',
    'Registered Voters',
    'Will Vote',
    'Special Vote Required',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supportersAsync = ref.watch(supportersProvider);
    final statsAsync = ref.watch(supporterStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supporters'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Section
          statsAsync.when(
            data: (stats) => _buildStatsSection(stats),
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Search Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name, phone, or email...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (_) => setState(() {}),
                ),

                // Active Filters
                if (_selectedWard != null || _selectedVoterFilter != null) ...[
                  const Gap(12),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (_selectedWard != null)
                        Chip(
                          label: Text('Ward $_selectedWard'),
                          onDeleted: () => setState(() => _selectedWard = null),
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                      if (_selectedVoterFilter != null)
                        Chip(
                          label: Text(_selectedVoterFilter!),
                          onDeleted: () => setState(() => _selectedVoterFilter = null),
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Supporters List
          Expanded(
            child: supportersAsync.when(
              data: (supporters) => _buildSupportersList(supporters),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const Gap(16),
                    Text('Error loading supporters: $error'),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(supportersProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/supporter-registration'),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Supporter'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildStatsSection(SupporterStatsResponse stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Supporters',
                  stats.total.toString(),
                  Icons.people,
                  Colors.blue,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard(
                  'Registered Voters',
                  stats.registeredVoters.toString(),
                  Icons.how_to_reg,
                  Colors.green,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Will Vote',
                  stats.willVote.toString(),
                  Icons.check_box,
                  Colors.orange,
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard(
                  'Special Vote',
                  stats.specialVote.toString(),
                  Icons.accessible,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportersList(List<SupporterModel> allSupporters) {
    // Apply search and filters
    var filteredSupporters = allSupporters;

    // Search filter
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredSupporters = filteredSupporters.where((supporter) {
        return supporter.displayFullName.toLowerCase().contains(query) ||
               supporter.displayPhone.contains(query) ||
               supporter.displayEmail.toLowerCase().contains(query);
      }).toList();
    }

    // Ward filter
    if (_selectedWard != null) {
      filteredSupporters = filteredSupporters.where((s) => s.ward == _selectedWard).toList();
    }

    // Voter status filter
    if (_selectedVoterFilter != null) {
      switch (_selectedVoterFilter) {
        case 'Registered Voters':
          filteredSupporters = filteredSupporters.where((s) => s.isRegisteredVoter).toList();
          break;
        case 'Will Vote':
          filteredSupporters = filteredSupporters.where((s) => s.willVote).toList();
          break;
        case 'Special Vote Required':
          filteredSupporters = filteredSupporters.where((s) => s.needsSpecialVote).toList();
          break;
      }
    }

    if (filteredSupporters.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredSupporters.length,
      itemBuilder: (context, index) {
        return _buildSupporterCard(filteredSupporters[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const Gap(16),
          Text(
            _searchController.text.isNotEmpty ? 'No Supporters Found' : 'No Supporters Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const Gap(8),
          Text(
            _searchController.text.isNotEmpty
                ? 'Try adjusting your search or filters'
                : 'Start registering supporters to track voter sentiment',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupporterCard(SupporterModel supporter) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showSupporterDetails(supporter),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Text(
                      supporter.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supporter.displayFullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          supporter.displayPhone,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (supporter.isApproved)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Approved',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInfoChip(Icons.location_on, 'Ward ${supporter.displayWard}'),
                  _buildInfoChip(Icons.badge, supporter.displaySupporterId),
                  if (supporter.isRegisteredVoter)
                    _buildInfoChip(Icons.how_to_reg, 'Voter', color: Colors.green),
                  if (supporter.willVote)
                    _buildInfoChip(Icons.check_box, 'Will Vote', color: Colors.blue),
                  if (supporter.needsSpecialVote)
                    _buildInfoChip(Icons.accessible, 'Special', color: Colors.purple),
                ],
              ),
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.visibility,
                    label: 'View',
                    onPressed: () => _showSupporterDetails(supporter),
                  ),
                  _buildActionButton(
                    icon: Icons.phone,
                    label: 'Call',
                    onPressed: () => _callSupporter(supporter),
                  ),
                  _buildActionButton(
                    icon: Icons.message,
                    label: 'SMS',
                    onPressed: () => _smsSupporter(supporter),
                  ),
                  _buildActionButton(
                    icon: Icons.more_horiz,
                    label: 'More',
                    onPressed: () => _showSupporterOptions(supporter),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color ?? AppTheme.textSecondary),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color ?? AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppTheme.primaryColor),
            const Gap(4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    final supportersNotifier = ref.read(supportersProvider.notifier);
    final availableWards = supportersNotifier.getAvailableWards();

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),

            const Text(
              'Filter by Ward',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            if (availableWards.isNotEmpty)
              Wrap(
                spacing: 8,
                children: availableWards.map((ward) {
                  final isSelected = ward == _selectedWard;
                  return FilterChip(
                    label: Text('Ward $ward'),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedWard = selected ? ward : null);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              )
            else
              const Text('No wards available'),

            const Gap(16),

            const Text(
              'Filter by Voter Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            ..._voterFilterOptions.map((filter) {
              final isSelected = filter == _selectedVoterFilter;
              return RadioListTile<String>(
                value: filter,
                groupValue: _selectedVoterFilter ?? 'All',
                onChanged: (value) {
                  setState(() {
                    _selectedVoterFilter = value == 'All' ? null : value;
                  });
                  Navigator.pop(context);
                },
                title: Text(filter),
                dense: true,
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showSupporterDetails(SupporterModel supporter) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            controller: scrollController,
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
                const Gap(20),

                // Header
                Text(
                  supporter.displayFullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  supporter.displaySupporterId,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),

                const Gap(24),

                // Contact Info
                _buildDetailRow(Icons.phone, 'Phone', supporter.displayPhone),
                _buildDetailRow(Icons.email, 'Email', supporter.displayEmail),
                if (supporter.address != null)
                  _buildDetailRow(Icons.location_on, 'Address', supporter.address!),
                _buildDetailRow(Icons.pin_drop, 'Ward', supporter.displayWard),
                _buildDetailRow(Icons.business, 'Municipality', supporter.displayMunicipality),

                const Gap(24),

                // Voter Status
                const Text(
                  'Voter Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(12),
                _buildDetailRow(
                  Icons.how_to_reg,
                  'Registered Voter',
                  supporter.isRegisteredVoter ? 'Yes' : 'No',
                  color: supporter.isRegisteredVoter ? Colors.green : Colors.grey,
                ),
                _buildDetailRow(
                  Icons.check_box,
                  'Will Vote',
                  supporter.willVote ? 'Yes' : 'No',
                  color: supporter.willVote ? Colors.blue : Colors.grey,
                ),
                _buildDetailRow(
                  Icons.accessible,
                  'Special Vote',
                  supporter.needsSpecialVote ? 'Required' : 'Not Required',
                  color: supporter.needsSpecialVote ? Colors.purple : Colors.grey,
                ),

                const Gap(24),

                // Actions
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _callSupporter(supporter);
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Call Supporter'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? AppTheme.primaryColor),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _callSupporter(SupporterModel supporter) async {
    final phoneNumber = supporter.telephone;
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot call $phoneNumber')),
        );
      }
    }
  }

  void _smsSupporter(SupporterModel supporter) async {
    final phoneNumber = supporter.telephone;
    final uri = Uri.parse('sms:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot send SMS to $phoneNumber')),
        );
      }
    }
  }

  void _showSupporterOptions(SupporterModel supporter) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              supporter.displayFullName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Details'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit supporter coming soon')),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Contact'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact sharing coming soon')),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove Supporter', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmRemoveSupporter(supporter);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRemoveSupporter(SupporterModel supporter) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Supporter?'),
        content: Text('Are you sure you want to remove ${supporter.displayFullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Remove supporter functionality coming soon')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
