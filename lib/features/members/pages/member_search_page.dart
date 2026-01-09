import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/visit_model.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/members_provider.dart';
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
        title: const Text('Members'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
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
                  onChanged: (value) => setState(() {}),
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
    final membersAsync = ref.watch(membersProvider);
    final searchQuery = _searchController.text.trim().toLowerCase();

    return membersAsync.when(
      loading: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Gap(16),
            Text('Loading members...'),
          ],
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const Gap(16),
            Text('Error loading members', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red.shade700)),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(error.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
            ),
            const Gap(16),
            ElevatedButton.icon(
              onPressed: () => ref.read(membersProvider.notifier).loadMembers(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (members) {
        // Apply search filter
        var filteredMembers = members;
        if (searchQuery.isNotEmpty) {
          filteredMembers = members.where((member) {
            return member.displayFirstName.toLowerCase().contains(searchQuery) ||
                   member.displayLastName.toLowerCase().contains(searchQuery) ||
                   member.displayPhone.contains(searchQuery) ||
                   member.displayIdNumber.contains(searchQuery) ||
                   member.displayMembershipNumber.toLowerCase().contains(searchQuery);
          }).toList();
        }

        // Apply status filter
        if (_selectedFilter != 'All') {
          final now = DateTime.now();
          switch (_selectedFilter) {
            case 'Active Members':
              filteredMembers = filteredMembers.where((m) => m.isActive).toList();
              break;
            case 'Inactive Members':
              filteredMembers = filteredMembers.where((m) => !m.isActive).toList();
              break;
            case 'Recent Registrations':
              filteredMembers = filteredMembers.where((m) {
                if (m.createdAt == null) return false;
                return now.difference(m.createdAt!).inDays <= 30;
              }).toList();
              break;
            case 'Pending Verification':
              filteredMembers = filteredMembers.where((m) =>
                m.status?.toLowerCase() == 'pending' ||
                m.status?.toLowerCase() == 'unverified'
              ).toList();
              break;
          }
        }

        // Apply sorting
        switch (_selectedSort) {
          case 'Name A-Z':
            filteredMembers.sort((a, b) => a.displayFullName.compareTo(b.displayFullName));
            break;
          case 'Name Z-A':
            filteredMembers.sort((a, b) => b.displayFullName.compareTo(a.displayFullName));
            break;
          case 'Registration Date (Newest)':
            filteredMembers.sort((a, b) => (b.createdAt ?? DateTime(1970)).compareTo(a.createdAt ?? DateTime(1970)));
            break;
          case 'Registration Date (Oldest)':
            filteredMembers.sort((a, b) => (a.createdAt ?? DateTime(1970)).compareTo(b.createdAt ?? DateTime(1970)));
            break;
          case 'Membership Number':
            filteredMembers.sort((a, b) => a.displayMembershipNumber.compareTo(b.displayMembershipNumber));
            break;
        }

        if (filteredMembers.isEmpty) {
          return _buildNoResultsState();
        }

        return RefreshIndicator(
          onRefresh: () => ref.read(membersProvider.notifier).loadMembers(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredMembers.length,
            itemBuilder: (context, index) {
              return _buildMemberCardFromModel(filteredMembers[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.search,
                size: 48,
                color: AppTheme.primaryColor.withOpacity(0.5),
              ),
            ),
            const Gap(24),
            Text(
              'Search for Members',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(10),
            Text(
              'Enter a name, phone number, ID, or\nmembership number to search',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
                height: 1.4,
              ),
            ),
            const Gap(28),
            _buildQuickActionChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.search_off,
                size: 48,
                color: AppTheme.primaryColor.withOpacity(0.5),
              ),
            ),
            const Gap(24),
            Text(
              'No Members Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(10),
            Text(
              'No members match your search criteria.\nTry adjusting your search terms or filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
                height: 1.4,
              ),
            ),
            const Gap(28),
            ElevatedButton.icon(
              onPressed: () {
                _searchController.clear();
                _clearSearch();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text(
                'Clear Search',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionChips() {
    final quickSearches = [
      ('Active Members', Icons.check_circle_outline, const Color(0xFF2ECC71)),
      ('Recent Registrations', Icons.schedule, const Color(0xFF5B7FFF)),
      ('Pending Verification', Icons.pending_outlined, const Color(0xFFE67E22)),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: quickSearches.map((item) {
        return InkWell(
          onTap: () {
            setState(() {
              _selectedFilter = item.$1;
            });
            _performQuickSearch(item.$1);
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: item.$3.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: item.$3.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.$2, size: 16, color: item.$3),
                const Gap(6),
                Text(
                  item.$1,
                  style: TextStyle(
                    color: item.$3,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
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
                  const Gap(8),
                  _buildStatusBadge(user),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  _buildInfoChip(Icons.card_membership, member?.displayMembershipNumber ?? 'N/A'),
                  const Gap(8),
                  _buildInfoChip(Icons.location_on, member?.displayWard.isNotEmpty == true ? 'Ward ${member!.displayWard}' : 'N/A'),
                ],
              ),
              const Gap(6),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoChip(Icons.business, member?.displayMunicipality ?? 'N/A'),
                  ),
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

  Widget _buildMemberCardFromModel(MemberModel member) {
    final displayName = member.displayFullName;
    final displayPhone = member.displayPhone;
    final displayFirstName = member.displayFirstName;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _viewMemberProfileById(member.id),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.primaryColor.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          displayFirstName.isNotEmpty
                              ? displayFirstName.substring(0, 1).toUpperCase()
                              : 'M',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    const Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (displayPhone.isNotEmpty) ...[
                            const Gap(3),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined, size: 13, color: Colors.grey.shade500),
                                const Gap(4),
                                Text(
                                  displayPhone,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Gap(8),
                    _buildStatusBadgeFromModel(member),
                  ],
                ),
                const Gap(14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildInfoChip(Icons.card_membership_outlined, member.displayMembershipNumber.isNotEmpty ? member.displayMembershipNumber : 'N/A'),
                      const Gap(8),
                      _buildInfoChip(Icons.pin_drop_outlined, member.displayWard.isNotEmpty ? 'Ward ${member.displayWard}' : 'N/A'),
                      const Gap(8),
                      _buildInfoChip(Icons.account_balance_outlined, member.displayMunicipality.isNotEmpty ? member.displayMunicipality : 'N/A'),
                    ],
                  ),
                ),
                const Gap(14),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.visibility_outlined,
                        label: 'View',
                        onPressed: () => _viewMemberProfileById(member.id),
                      ),
                      _buildVerticalDivider(),
                      _buildActionButton(
                        icon: Icons.phone_outlined,
                        label: 'Call',
                        onPressed: () => _callMemberDirect(member),
                      ),
                      _buildVerticalDivider(),
                      _buildActionButton(
                        icon: Icons.add_circle_outline,
                        label: 'Visit',
                        onPressed: () => _viewMemberProfileById(member.id),
                      ),
                      _buildVerticalDivider(),
                      _buildActionButton(
                        icon: Icons.more_horiz,
                        label: 'More',
                        onPressed: () => _showMemberOptionsDirect(member),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 28,
      color: Colors.grey.shade200,
    );
  }

  Widget _buildStatusBadgeFromModel(MemberModel member) {
    final isActive = member.isActive;
    final color = isActive ? const Color(0xFF2ECC71) : const Color(0xFFE67E22);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.pause_circle,
            size: 12,
            color: color,
          ),
          const Gap(4),
          Text(
            isActive ? 'Active' : 'Inactive',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
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

  Widget _buildInfoChip(IconData icon, String label, {Color? color}) {
    final chipColor = color ?? Colors.grey.shade600;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: chipColor),
          const Gap(5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: chipColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppTheme.primaryColor),
            const Gap(4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performQuickSearch(String filterType) {
    setState(() {
      _selectedFilter = filterType;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _selectedFilter = 'All';
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
    final memberId = user.member?.id;

    // Get visits for this member
    final visitsState = ref.read(visitsProvider);
    final allVisits = visitsState.valueOrNull ?? <VisitModel>[];
    final memberVisits = memberId != null
        ? allVisits.where((v) => v.memberId == memberId).toList()
        : <VisitModel>[];

    // Sort by date (most recent first)
    memberVisits.sort((a, b) {
      final dateA = a.visitDate ?? a.scheduledDate ?? a.actualDate ?? DateTime(2000);
      final dateB = b.visitDate ?? b.scheduledDate ?? b.actualDate ?? DateTime(2000);
      return dateB.compareTo(dateA);
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$displayName - History'),
        content: SizedBox(
          width: double.maxFinite,
          child: memberVisits.isEmpty
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.history, size: 48, color: Colors.grey),
                    Gap(12),
                    Text('No visit history found for this member.'),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: memberVisits.length > 5 ? 5 : memberVisits.length,
                  itemBuilder: (context, index) {
                    final visit = memberVisits[index];
                    final visitDate = visit.visitDate ?? visit.scheduledDate ?? visit.actualDate;
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        _getVisitStatusIcon(visit.status),
                        color: _getVisitStatusColor(visit.status),
                        size: 20,
                      ),
                      title: Text(
                        visit.visitType,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        visitDate != null
                            ? '${visitDate.day}/${visitDate.month}/${visitDate.year}'
                            : 'No date',
                        style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getVisitStatusColor(visit.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          visit.status,
                          style: TextStyle(
                            fontSize: 10,
                            color: _getVisitStatusColor(visit.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          if (memberVisits.length > 5)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Navigate to full history page
              },
              child: Text('View all ${memberVisits.length} visits'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  IconData _getVisitStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'scheduled':
        return Icons.schedule;
      case 'in_progress':
        return Icons.play_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.circle;
    }
  }

  Color _getVisitStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'scheduled':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
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

  void _viewMemberProfileById(int memberId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberProfileViewPage(memberId: memberId),
      ),
    );
  }

  void _callMemberDirect(MemberModel member) {
    final displayPhone = member.displayPhone;
    final displayName = member.displayFullName;

    if (displayPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No phone number available for this member'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

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

  void _showMemberOptionsDirect(MemberModel member) {
    final displayName = member.displayFullName;

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
                _viewMemberProfileById(member.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Call Member'),
              onTap: () {
                Navigator.pop(context);
                _callMemberDirect(member);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Contact'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sharing: $displayName - ${member.displayPhone}')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}