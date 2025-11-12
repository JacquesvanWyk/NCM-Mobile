import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/visits_provider.dart';
import 'member_profile_view_page.dart';

class MemberSearchPage extends ConsumerStatefulWidget {
  const MemberSearchPage({super.key});

  @override
  ConsumerState<MemberSearchPage> createState() => _MemberSearchPageState();
}

class _MemberSearchPageState extends ConsumerState<MemberSearchPage> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  List<UserModel> _searchResults = [];
  bool _isSearching = false;
  String _selectedFilter = 'All';
  String _selectedSort = 'Name A-Z';

  final List<String> _filterOptions = [
    'All',
    'Active Members',
    'Inactive Members',
    'Recent Registrations',
    'Pending Verification',
  ];

  final List<String> _sortOptions = [
    'Name A-Z',
    'Name Z-A',
    'Registration Date (Newest)',
    'Registration Date (Oldest)',
    'Last Visit (Recent)',
    'Membership Number',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Search'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search by name, ID, phone, or membership number...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _clearSearch();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: _performSearch,
                  onSubmitted: (_) => _performSearch(_searchController.text),
                ),

                const Gap(12),

                // Filter and Sort Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.filter_alt, size: 16, color: AppTheme.textSecondary),
                            const Gap(6),
                            Expanded(
                              child: Text(
                                _selectedFilter,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sort, size: 16, color: AppTheme.textSecondary),
                            const Gap(6),
                            Expanded(
                              child: Text(
                                _selectedSort,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.isEmpty) {
      return _buildEmptyState();
    }

    if (_isSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Gap(16),
            Text('Searching members...'),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return _buildNoResultsState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return _buildMemberCard(_searchResults[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const Gap(16),
          Text(
            'Search for Members',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const Gap(8),
          Text(
            'Enter a name, phone number, ID, or\nmembership number to search',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const Gap(32),
          _buildQuickActionChips(),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const Gap(16),
          Text(
            'No Members Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const Gap(8),
          Text(
            'No members match your search criteria.\nTry adjusting your search terms or filters.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const Gap(24),
          ElevatedButton.icon(
            onPressed: () {
              _searchController.clear();
              _clearSearch();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionChips() {
    final quickSearches = [
      'Active Members',
      'Recent Registrations',
      'Pending Verification',
    ];

    return Wrap(
      spacing: 8,
      children: quickSearches.map((search) {
        return ActionChip(
          label: Text(search),
          onPressed: () {
            setState(() {
              _selectedFilter = search;
            });
            _performQuickSearch(search);
          },
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          labelStyle: const TextStyle(color: AppTheme.primaryColor),
        );
      }).toList(),
    );
  }

  Widget _buildMemberCard(UserModel user) {
    final member = user.member;
    final displayName = member?.displayFullName ?? user.name;
    final displayPhone = member?.displayPhone ?? '';
    final displayFirstName = member?.displayFirstName ?? user.name.split(' ').first;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _viewMemberProfile(user),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Text(
                      displayFirstName.isNotEmpty
                          ? displayFirstName.substring(0, 1).toUpperCase()
                          : 'M',
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
                          displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (displayPhone.isNotEmpty) ...[
                          const Gap(2),
                          Text(
                            displayPhone,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _buildStatusBadge(user),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  _buildInfoChip(Icons.card_membership, member?.displayMembershipNumber ?? 'N/A'),
                  const Gap(8),
                  _buildInfoChip(Icons.location_on, member?.displayWard.isNotEmpty == true ? 'Ward ${member!.displayWard}' : 'N/A'),
                  const Gap(8),
                  _buildInfoChip(Icons.business, member?.displayMunicipality ?? 'N/A'),
                ],
              ),
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.visibility,
                    label: 'View',
                    onPressed: () => _viewMemberProfile(user),
                  ),
                  _buildActionButton(
                    icon: Icons.phone,
                    label: 'Call',
                    onPressed: () => _callMember(user),
                  ),
                  _buildActionButton(
                    icon: Icons.note_add,
                    label: 'Visit',
                    onPressed: () => _scheduleVisit(user),
                  ),
                  _buildActionButton(
                    icon: Icons.more_horiz,
                    label: 'More',
                    onPressed: () => _showMemberOptions(user),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(UserModel user) {
    final member = user.member;
    final isActive = member?.isActive ?? false;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.green.withOpacity(0.3) : Colors.orange.withOpacity(0.3),
        ),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isActive ? Colors.green.shade700 : Colors.orange.shade700,
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppTheme.textSecondary),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: AppTheme.textSecondary,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      _clearSearch();
      return;
    }

    setState(() => _isSearching = true);

    try {
      final apiService = ref.read(apiServiceProvider);
      final members = await apiService.searchMembers(query);

      // Convert members to UserModel format (members have embedded user data)
      final userResults = members.map((member) {
        return UserModel(
          id: member.userId ?? member.id,
          name: member.displayFullName,
          email: member.email ?? '',
          member: member,
        );
      }).toList();

      setState(() {
        _searchResults = userResults;
        _isSearching = false;
      });
    } catch (e) {
      setState(() => _isSearching = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Search failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _performQuickSearch(String filterType) {
    // TODO: Implement actual filtering when backend supports it
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filtering feature coming soon'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearSearch() {
    setState(() {
      _searchResults.clear();
      _isSearching = false;
    });
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter & Sort Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),

            const Text(
              'Filter by Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            Wrap(
              spacing: 8,
              children: _filterOptions.map((filter) {
                final isSelected = filter == _selectedFilter;
                return FilterChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedFilter = filter);
                    Navigator.pop(context);
                    if (filter != 'All') {
                      _performQuickSearch(filter);
                    }
                  },
                );
              }).toList(),
            ),

            const Gap(16),

            const Text(
              'Sort by',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            ..._sortOptions.map((sort) {
              final isSelected = sort == _selectedSort;
              return RadioListTile<String>(
                value: sort,
                groupValue: _selectedSort,
                onChanged: (value) {
                  setState(() => _selectedSort = value!);
                  Navigator.pop(context);
                  // Apply sorting logic here
                },
                title: Text(sort),
                dense: true,
              );
            }),
          ],
        ),
      ),
    );
  }

  void _viewMemberProfile(UserModel user) {
    final member = user.member;
    if (member == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Member data not available')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberProfileViewPage(
          memberId: member.id,
        ),
      ),
    );
  }

  void _callMember(UserModel user) {
    final member = user.member;
    final displayPhone = member?.displayPhone ?? '';
    final displayName = member?.displayFullName ?? user.name;

    if (displayPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No phone number available for this member'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Show confirmation dialog before calling
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Call Member'),
        content: Text('Call $displayName at $displayPhone?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual phone call using url_launcher
              // Example: launch('tel:$displayPhone')
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling $displayPhone...')),
              );
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _scheduleVisit(UserModel user) {
    // Navigate to member profile where they can record a visit
    _viewMemberProfile(user);
  }

  void _showMemberOptions(UserModel user) {
    final member = user.member;
    final displayName = member?.displayFullName ?? user.name;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Full Profile'),
              onTap: () {
                Navigator.pop(context);
                _viewMemberProfile(user);
              },
            ),

            ListTile(
              leading: const Icon(Icons.report_problem),
              title: const Text('Log Complaint'),
              onTap: () {
                Navigator.pop(context);
                _showLogComplaint(user);
              },
            ),

            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Update Contact Info'),
              onTap: () {
                Navigator.pop(context);
                _updateContactInfo(user);
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('View History'),
              onTap: () {
                Navigator.pop(context);
                _viewMemberHistory(user);
              },
            ),

            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Contact'),
              onTap: () {
                Navigator.pop(context);
                _shareContact(user);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogComplaint(UserModel user) {
    final member = user.member;
    final displayName = member?.displayFullName ?? user.name;
    final complaintController = TextEditingController();
    String selectedCategory = 'Service Delivery';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Log Complaint'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Member: $displayName',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                const Text('Category:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const Gap(8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    'Service Delivery',
                    'Infrastructure',
                    'Safety',
                    'Other',
                  ].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                const Gap(16),
                const Text('Description:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const Gap(8),
                TextField(
                  controller: complaintController,
                  decoration: const InputDecoration(
                    hintText: 'Enter complaint details...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                complaintController.dispose();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (complaintController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter complaint details'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                // TODO: Submit complaint to API
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Complaint logged: $selectedCategory'),
                    backgroundColor: Colors.green,
                  ),
                );
                complaintController.dispose();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateContactInfo(UserModel user) {
    final member = user.member;
    final phoneController = TextEditingController(text: member?.phoneNumber ?? member?.telNumber);
    final addressController = TextEditingController(text: member?.address);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Contact Information'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const Gap(16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              phoneController.dispose();
              addressController.dispose();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Update member contact info via API
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contact information updated'),
                  backgroundColor: Colors.green,
                ),
              );
              phoneController.dispose();
              addressController.dispose();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _viewMemberHistory(UserModel user) {
    final displayName = user.member?.displayFullName ?? user.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$displayName - History'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Visit and interaction history will be displayed here.'),
            const Gap(16),
            const Text('Coming soon...'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _shareContact(UserModel user) {
    final member = user.member;
    final displayName = member?.displayFullName ?? user.name;
    final displayPhone = member?.displayPhone ?? '';

    // TODO: Implement actual share functionality using share_plus package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing contact: $displayName - $displayPhone'),
      ),
    );
  }
}