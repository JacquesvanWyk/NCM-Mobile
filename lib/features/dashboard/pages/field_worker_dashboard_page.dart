import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../auth/pages/login_page.dart';
import '../../visits/pages/visits_page.dart';
import '../../members/pages/qr_scanner_camera_page.dart';
import '../../members/pages/quick_registration_page.dart';
// import '../../members/pages/ocr_registration_page.dart'; // Disabled for now
import '../../members/pages/member_search_page.dart';
import '../../analytics/pages/performance_analytics_page.dart';
import '../../complaints/pages/complaint_logging_simple.dart';
import '../../visits/pages/visit_notes_page.dart';
import '../../supporters/pages/supporters_list_page.dart';
import '../../notifications/pages/notifications_hub_page.dart';
import '../../notifications/pages/notifications_inbox_page.dart';
import '../../../data/models/visit_model.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/dashboard_mode_provider.dart';
import '../../../providers/visits_provider.dart';
import '../../../providers/members_provider.dart';
import '../../../providers/supporters_provider.dart';

class FieldWorkerDashboardPage extends ConsumerStatefulWidget {
  const FieldWorkerDashboardPage({super.key});

  @override
  ConsumerState<FieldWorkerDashboardPage> createState() => _FieldWorkerDashboardPageState();
}

class _FieldWorkerDashboardPageState extends ConsumerState<FieldWorkerDashboardPage> {
  int _selectedIndex = 0;

  Future<void> _handleLogout() async {
    // Clear auth and reset dashboard mode BEFORE navigating
    final authNotifier = ref.read(authProvider.notifier);
    final dashboardNotifier = ref.read(dashboardModeProvider.notifier);

    await authNotifier.logout();
    await dashboardNotifier.reset();

    // Then navigate to login
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const VisitsPage();
      case 2:
        return _buildMembersTab();
      case 3:
        return _buildReportsTab();
      case 4:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    final visitsState = ref.watch(visitsProvider);
    final membersState = ref.watch(membersProvider);
    final supportersState = ref.watch(supportersProvider);

    // Calculate stats from providers
    final visits = visitsState.valueOrNull ?? [];
    final members = membersState.valueOrNull ?? [];
    final supporters = supportersState.valueOrNull ?? [];

    // Today's date for filtering
    final today = DateTime.now();

    // Today's visits
    final todaysVisits = visits.where((v) {
      final visitDate = v.visitDate ?? v.scheduledDate ?? v.actualDate;
      if (visitDate == null) return false;
      return visitDate.year == today.year && visitDate.month == today.month && visitDate.day == today.day;
    }).toList();

    final plannedToday = todaysVisits.where((v) => v.status.toLowerCase() == 'scheduled').length;
    final completedToday = todaysVisits.where((v) => v.status.toLowerCase() == 'completed').length;

    // This month stats
    final thisMonthStart = DateTime(today.year, today.month, 1);

    final totalRegistrationsThisMonth = members.where((m) {
      final createdAt = m.createdAt;
      if (createdAt == null) return false;
      return createdAt.isAfter(thisMonthStart.subtract(const Duration(days: 1)));
    }).length + supporters.where((s) {
      final createdAt = s.createdAt;
      if (createdAt == null) return false;
      return createdAt.isAfter(thisMonthStart.subtract(const Duration(days: 1)));
    }).length;

    // Weekly progress (4 weeks of data)
    final weeklyProgress = _calculateWeeklyProgress(visits, members, supporters);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Leader Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsInboxPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section - Clean modern design
            FutureBuilder<String?>(
              future: AuthService.getLeaderLevel(),
              builder: (context, leaderLevelSnapshot) {
                final leaderLevel = leaderLevelSnapshot.data ?? 'Leader';

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.1),
                        AppTheme.primaryColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      FutureBuilder<UserModel?>(
                        future: AuthService.getUser(),
                        builder: (context, snapshot) {
                          final user = snapshot.data;
                          final leader = user?.leader;
                          final initials = leader != null
                              ? '${leader.name.isNotEmpty ? leader.name[0] : ''}${leader.surname.isNotEmpty ? leader.surname[0] : ''}'.toUpperCase()
                              : 'U';

                          return Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                initials,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String>(
                              future: AuthService.getUser().then((user) {
                                final leader = user?.leader;
                                if (leader != null && (leader.name.isNotEmpty || leader.surname.isNotEmpty)) {
                                  return '${leader.name} ${leader.surname}'.trim();
                                }
                                return user?.name ?? 'Welcome';
                              }),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data ?? 'Loading...',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textPrimary,
                                    letterSpacing: -0.5,
                                  ),
                                );
                              },
                            ),
                            const Gap(4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getRoleBadgeColor(leaderLevel),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                leaderLevel,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getRoleBadgeTextColor(leaderLevel),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.verified,
                          color: Colors.green.shade600,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const Gap(24),

            // Today's Overview
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  _formatDate(DateTime.now()),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),

            const Gap(16),

            Row(
              children: [
                Expanded(
                  child: _OverviewCard(
                    title: 'Planned',
                    value: '$plannedToday',
                    color: Colors.blue.shade50,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _OverviewCard(
                    title: 'Completed',
                    value: '$completedToday',
                    color: Colors.green.shade50,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _OverviewCard(
                    title: 'Total',
                    value: '${todaysVisits.length}',
                    color: Colors.orange.shade50,
                  ),
                ),
              ],
            ),

            const Gap(28),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                letterSpacing: -0.3,
              ),
            ),

            const Gap(16),

            FutureBuilder<bool>(
              future: AuthService.isTopLeader(),
              builder: (context, snapshot) {
                final isTopLeader = snapshot.data ?? false;
                final actions = [
                  _QuickActionCard(
                    icon: Icons.add_circle_outline,
                    title: 'Member Registration',
                    onTap: _navigateToQuickRegistration,
                  ),
                  _QuickActionCard(
                    icon: Icons.qr_code_scanner,
                    title: 'Scan Member Code',
                    onTap: _navigateToQrScanner,
                  ),
                  _QuickActionCard(
                    icon: Icons.people_alt_outlined,
                    title: 'Manage Supporters',
                    onTap: _navigateToSupporters,
                  ),
                  _QuickActionCard(
                    icon: Icons.report_problem_outlined,
                    title: 'Log Complaint',
                    onTap: _navigateToComplaintLogging,
                  ),
                  _QuickActionCard(
                    icon: Icons.note_add_outlined,
                    title: 'Record Notes',
                    onTap: _navigateToVisitNotes,
                  ),
                  if (isTopLeader)
                    _QuickActionCard(
                      icon: Icons.notifications_active,
                      title: 'Notifications',
                      onTap: _navigateToNotifications,
                    ),
                ];

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: actions,
                );
              },
            ),

            const Gap(28),

            // Performance Metrics
            const Text(
              'This Month',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                letterSpacing: -0.3,
              ),
            ),

            const Gap(16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Registrations',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            '$totalRegistrationsThisMonth',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.people, size: 16, color: Colors.blue.shade700),
                            const Gap(4),
                            Text(
                              '${members.length + supporters.length} total',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  // Progress bars
                  _buildProgressRow('Week 1', weeklyProgress[0], Colors.blue.shade400),
                  const Gap(10),
                  _buildProgressRow('Week 2', weeklyProgress[1], Colors.blue.shade500),
                  const Gap(10),
                  _buildProgressRow('Week 3', weeklyProgress[2], Colors.blue.shade600),
                  const Gap(10),
                  _buildProgressRow('Week 4', weeklyProgress[3], AppTheme.primaryColor),
                ],
              ),
            ),

            const Gap(100), // Bottom padding for navigation
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Visits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return Scaffold(
      body: const MemberSearchPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Visits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return Scaffold(
      body: const PerformanceAnalyticsPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Visits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder<UserModel?>(
        future: AuthService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          final leader = user?.leader;

          if (leader == null) {
            return const Center(
              child: Text('No leader profile found'),
            );
          }

          return CustomScrollView(
            slivers: [
              // Modern Header with gradient
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withOpacity(0.85),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        // App bar row
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 48),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.logout, color: Colors.white),
                                onPressed: _handleLogout,
                                tooltip: 'Logout',
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        // Avatar
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: leader.picture != null && leader.picture!.isNotEmpty
                                ? NetworkImage(leader.picture!)
                                : null,
                            child: leader.picture == null || leader.picture!.isEmpty
                                ? Text(
                                    '${leader.name.isNotEmpty ? leader.name[0] : ''}${leader.surname.isNotEmpty ? leader.surname[0] : ''}'.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          '${leader.name} ${leader.surname}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const Gap(8),
                        // Role and status badges
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                leader.level,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: leader.status.toLowerCase() == 'approved' || leader.status.toLowerCase() == 'active'
                                    ? Colors.green.shade400
                                    : Colors.orange.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    leader.status.toLowerCase() == 'approved' || leader.status.toLowerCase() == 'active'
                                        ? Icons.check_circle
                                        : Icons.pending,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const Gap(4),
                                  Text(
                                    leader.status.toLowerCase() == 'approved' || leader.status.toLowerCase() == 'active'
                                        ? 'Active'
                                        : 'Pending',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(24),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick stats row
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.calendar_today,
                              label: 'Member Since',
                              value: leader.createdAt != null
                                  ? '${_getMonthName(leader.createdAt!.month)} ${leader.createdAt!.year}'
                                  : 'N/A',
                              color: Colors.blue,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.payments_outlined,
                              label: 'Payment',
                              value: leader.paid == true ? 'Paid' : 'Unpaid',
                              color: leader.paid == true ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),

                      const Gap(24),

                      // Personal Information
                      _buildSectionHeader('Personal Information', Icons.person_outline),
                      const Gap(12),
                      _buildModernCard([
                        if (leader.idNumber != null && leader.idNumber!.isNotEmpty)
                          _buildModernInfoRow(Icons.badge_outlined, 'ID Number', leader.idNumber!),
                        if (leader.nationality != null && leader.nationality!.isNotEmpty)
                          _buildModernInfoRow(Icons.flag_outlined, 'Nationality', leader.nationality!),
                        if (leader.gender != null && leader.gender!.isNotEmpty)
                          _buildModernInfoRow(Icons.person_outline, 'Gender', leader.gender!),
                        if (user?.email != null)
                          _buildModernInfoRow(Icons.email_outlined, 'Email', user!.email),
                      ]),

                      const Gap(24),

                      // Contact Information
                      _buildSectionHeader('Contact Information', Icons.contact_phone_outlined),
                      const Gap(12),
                      _buildModernCard([
                        _buildModernInfoRow(Icons.phone_outlined, 'Phone', leader.telNumber ?? 'Not provided'),
                        _buildModernInfoRow(Icons.home_outlined, 'Address', leader.address ?? 'Not provided'),
                        _buildModernInfoRow(Icons.location_city_outlined, 'Town', leader.town ?? 'Not provided'),
                        _buildModernInfoRow(Icons.pin_drop_outlined, 'Ward', leader.ward ?? 'Not provided'),
                      ]),

                      const Gap(32),

                      // Logout button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _handleLogout,
                          icon: const Icon(Icons.logout, size: 20),
                          label: const Text('Sign Out'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red.shade600,
                            side: BorderSide(color: Colors.red.shade200),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const Gap(100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Visits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature feature coming soon')),
    );
  }

  // COMMENTED OUT - Modal registration options disabled, now goes directly to manual registration
  // TODO: Re-enable when OCR registration is ready and we want to offer multiple registration methods
  // void _showRegistrationOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             'Choose Registration Method',
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const Gap(8),
  //           const Text(
  //             'Select how you want to register the new member:',
  //             style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
  //           ),
  //           const Gap(24),
  //
  //           // OCR Registration Option - COMMENTED OUT FOR NOW
  //           // TODO: Re-enable when OCR is fully implemented with offline support
  //           // ListTile(
  //           //   onTap: () {
  //           //     Navigator.pop(context);
  //           //     _navigateToOcrRegistration();
  //           //   },
  //           //   leading: Container(
  //           //     padding: const EdgeInsets.all(8),
  //           //     decoration: BoxDecoration(
  //           //       color: Colors.purple.shade50,
  //           //       borderRadius: BorderRadius.circular(8),
  //           //     ),
  //           //     child: Icon(
  //           //       Icons.document_scanner,
  //           //       color: Colors.purple.shade600,
  //           //     ),
  //           //   ),
  //           //   title: const Text(
  //           //     'Scan ID Document (OCR)',
  //           //     style: TextStyle(fontWeight: FontWeight.w600),
  //           //   ),
  //           //   subtitle: const Text(
  //           //     'Automatically extract info from ID/passport',
  //           //   ),
  //           //   trailing: const Icon(Icons.arrow_forward_ios),
  //           // ),
  //           //
  //           // const Gap(8),
  //
  //           // Manual Registration Option
  //           ListTile(
  //             onTap: () {
  //               Navigator.pop(context);
  //               _navigateToQuickRegistration();
  //             },
  //             leading: Container(
  //               padding: const EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                 color: Colors.blue.shade50,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Icon(
  //                 Icons.edit,
  //                 color: Colors.blue.shade600,
  //               ),
  //             ),
  //             title: const Text(
  //               'Manual Registration',
  //               style: TextStyle(fontWeight: FontWeight.w600),
  //             ),
  //             subtitle: const Text(
  //               'Enter member details manually',
  //             ),
  //             trailing: const Icon(Icons.arrow_forward_ios),
  //           ),
  //
  //           const Gap(16),
  //
  //           SizedBox(
  //             width: double.infinity,
  //             child: OutlinedButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('Cancel'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _navigateToQuickRegistration() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QuickRegistrationPage(),
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New member registered successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // COMMENTED OUT - OCR registration disabled for now
  // void _navigateToOcrRegistration() async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => const OcrRegistrationPage(),
  //     ),
  //   );
  //
  //   if (result == true) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Member registered successfully using OCR'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   }
  // }

  void _navigateToQrScanner() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QrScannerCameraPage(),
      ),
    );
  }

  void _navigateToComplaintLogging() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ComplaintLoggingPage(),
      ),
    );
  }

  void _navigateToVisitNotes() {
    // Create a mock visit for note taking
    final mockVisit = VisitModel(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      memberId: 1,
      municipalityId: 1,
      visitDate: DateTime.now(),
      visitType: 'General Visit',
      status: 'in_progress',
      member: const MemberModel(
        id: 1,
        name: 'Unknown',
        surname: 'Member',
      ),
      locationAddress: 'Current Location',
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VisitNotesPage(visit: mockVisit),
      ),
    );
  }

  void _navigateToSupporters() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SupportersListPage(),
      ),
    );
  }

  void _navigateToNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NotificationsHubPage(),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]}';
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const Gap(12),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryColor),
        const Gap(8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildModernCard(List<Widget> children) {
    final filteredChildren = children.where((w) => w is! SizedBox).toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: filteredChildren.asMap().entries.map((entry) {
          final isLast = entry.key == filteredChildren.length - 1;
          return Column(
            children: [
              entry.value,
              if (!isLast)
                Divider(height: 1, color: Colors.grey.shade100, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppTheme.primaryColor),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, double progress, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Color _getRoleBadgeColor(String leaderLevel) {
    switch (leaderLevel) {
      case 'Admin':
        return Colors.red.shade100;
      case 'Chairperson':
        return Colors.purple.shade100;
      case 'Secretary':
        return Colors.green.shade100;
      case 'Treasurer':
        return Colors.orange.shade100;
      case 'Ward Convenor':
        return Colors.blue.shade100;
      case 'Sub District Leaders':
        return Colors.teal.shade100;
      case 'Executive members':
        return Colors.indigo.shade100;
      case 'Top':
        return Colors.amber.shade100;
      default:
        return AppTheme.primaryColor.withOpacity(0.15);
    }
  }

  Color _getRoleBadgeTextColor(String leaderLevel) {
    switch (leaderLevel) {
      case 'Admin':
        return Colors.red.shade800;
      case 'Chairperson':
        return Colors.purple.shade800;
      case 'Secretary':
        return Colors.green.shade800;
      case 'Treasurer':
        return Colors.orange.shade800;
      case 'Ward Convenor':
        return Colors.blue.shade800;
      case 'Sub District Leaders':
        return Colors.teal.shade800;
      case 'Executive members':
        return Colors.indigo.shade800;
      case 'Top':
        return Colors.amber.shade800;
      default:
        return AppTheme.primaryColor;
    }
  }

  List<double> _calculateWeeklyProgress(List<VisitModel> visits, List<dynamic> members, List<dynamic> supporters) {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    // Calculate 4 weeks of activity
    final weeklyData = <double>[0, 0, 0, 0];

    for (var i = 0; i < 4; i++) {
      final weekStart = monthStart.add(Duration(days: i * 7));
      final weekEnd = monthStart.add(Duration(days: (i + 1) * 7));

      // Count visits in this week
      final weekVisits = visits.where((v) {
        final visitDate = v.visitDate ?? v.scheduledDate ?? v.actualDate;
        if (visitDate == null) return false;
        return visitDate.isAfter(weekStart.subtract(const Duration(days: 1))) &&
               visitDate.isBefore(weekEnd);
      }).length;

      // Count members registered this week
      final weekMembers = members.where((m) {
        final createdAt = m.createdAt;
        if (createdAt == null) return false;
        return createdAt.isAfter(weekStart.subtract(const Duration(days: 1))) &&
               createdAt.isBefore(weekEnd);
      }).length;

      // Count supporters registered this week
      final weekSupporters = supporters.where((s) {
        final createdAt = s.createdAt;
        if (createdAt == null) return false;
        return createdAt.isAfter(weekStart.subtract(const Duration(days: 1))) &&
               createdAt.isBefore(weekEnd);
      }).length;

      // Total activity for this week
      weeklyData[i] = (weekVisits + weekMembers + weekSupporters).toDouble();
    }

    // Normalize to percentages (0-1)
    final maxActivity = weeklyData.reduce((a, b) => a > b ? a : b);
    if (maxActivity == 0) {
      return [0.0, 0.0, 0.0, 0.0];
    }

    return weeklyData.map((v) => (v / maxActivity).clamp(0.0, 1.0)).toList();
  }

}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData? icon;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary.withOpacity(0.7),
            ),
          ),
          const Gap(8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 26,
                  color: AppTheme.primaryColor,
                ),
              ),
              const Gap(10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}