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

class FieldWorkerDashboardPage extends ConsumerStatefulWidget {
  const FieldWorkerDashboardPage({super.key});

  @override
  ConsumerState<FieldWorkerDashboardPage> createState() => _FieldWorkerDashboardPageState();
}

class _FieldWorkerDashboardPageState extends ConsumerState<FieldWorkerDashboardPage> {
  int _selectedIndex = 0;

  Future<void> _handleLogout() async {
    // Navigate to login FIRST before clearing state
    // This prevents the dashboard from switching to member mode
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }

    // Then clear auth and reset dashboard mode
    await ref.read(authProvider.notifier).logout();
    await ref.read(dashboardModeProvider.notifier).reset();
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
            // Profile Section with Role-based Information
            FutureBuilder<String?>(
              future: AuthService.getUserType(),
              builder: (context, userTypeSnapshot) {
                return FutureBuilder<String?>(
                  future: AuthService.getLeaderLevel(),
                  builder: (context, leaderLevelSnapshot) {
                    final userType = userTypeSnapshot.data ?? 'Unknown';
                    final leaderLevel = leaderLevelSnapshot.data ?? 'Unknown';

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue.shade100,
                                child: const Icon(
                                  Icons.admin_panel_settings,
                                  size: 28,
                                  color: Colors.blue,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<String>(
                                      future: AuthService.getUser().then((user) {
                                        // For leaders, show leader name; for regular users, show user name
                                        return user?.leader?.name ?? user?.name ?? 'Unknown User';
                                      }),
                                      builder: (context, snapshot) {
                                        return Text(
                                          snapshot.data ?? 'Loading...',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textPrimary,
                                          ),
                                        );
                                      },
                                    ),
                                    Text(
                                      'Leader Level: $leaderLevel',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Role: ${userType.replaceAll('_', ' ').toUpperCase()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          // Role-specific permissions display
                          _buildRoleSpecificContent(leaderLevel),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const Gap(20),

            // Today's Overview
            const Text(
              'Today\'s Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),

            const Gap(12),

            Row(
              children: [
                Expanded(
                  child: _OverviewCard(
                    title: 'Planned',
                    value: '12',
                    color: Colors.blue.shade100,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _OverviewCard(
                    title: 'Completed',
                    value: '8',
                    color: Colors.green.shade100,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _OverviewCard(
                    title: 'Complaints',
                    value: '2',
                    color: Colors.orange.shade100,
                  ),
                ),
              ],
            ),

            const Gap(24),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),

            const Gap(12),

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

            const Gap(24),

            // Performance Metrics
            const Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),

            const Gap(12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Registrations',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          'This Month',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    const Text(
                      '150',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const Gap(16),
                    // Simple chart placeholder
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text(
                                  'Wk 1',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text(
                                  'Wk 2',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text(
                                  'Wk 3',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text(
                                  'Wk 4',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _handleLogout,
          ),
        ],
      ),
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryColor,
                        backgroundImage: leader.picture != null && leader.picture!.isNotEmpty
                            ? NetworkImage(leader.picture!)
                            : null,
                        child: leader.picture == null || leader.picture!.isEmpty
                            ? (leader.name.isNotEmpty || leader.surname.isNotEmpty
                                ? Text(
                                    '${leader.name.isNotEmpty ? leader.name[0] : ''}${leader.surname.isNotEmpty ? leader.surname[0] : ''}'.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ))
                            : null,
                      ),
                      const Gap(16),
                      Text(
                        '${leader.name} ${leader.surname}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          leader.level,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: leader.status.toLowerCase() == 'approved'
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          leader.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: leader.status.toLowerCase() == 'approved'
                                ? Colors.green.shade700
                                : Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(32),

                // Personal Information
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Gap(12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (leader.idNumber != null && leader.idNumber!.isNotEmpty)
                          _buildProfileInfoRow(Icons.badge, 'ID Number', leader.idNumber!),
                        if (leader.idNumber != null && leader.idNumber!.isNotEmpty)
                          const Divider(),
                        if (leader.nationality != null && leader.nationality!.isNotEmpty)
                          _buildProfileInfoRow(Icons.flag, 'Nationality', leader.nationality!),
                        if (leader.nationality != null && leader.nationality!.isNotEmpty)
                          const Divider(),
                        if (leader.gender != null && leader.gender!.isNotEmpty)
                          _buildProfileInfoRow(Icons.person_outline, 'Gender', leader.gender!),
                        if (leader.gender != null && leader.gender!.isNotEmpty)
                          const Divider(),
                        if (user?.email != null)
                          _buildProfileInfoRow(Icons.email, 'Email', user!.email),
                      ],
                    ),
                  ),
                ),

                const Gap(24),

                // Contact Information
                const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Gap(12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildProfileInfoRow(
                          Icons.phone,
                          'Phone Number',
                          leader.telNumber ?? 'Not provided'
                        ),
                        const Divider(),
                        _buildProfileInfoRow(
                          Icons.home,
                          'Address',
                          leader.address ?? 'Not provided'
                        ),
                        const Divider(),
                        _buildProfileInfoRow(
                          Icons.location_city,
                          'Town',
                          leader.town ?? 'Not provided'
                        ),
                        const Divider(),
                        _buildProfileInfoRow(
                          Icons.location_on,
                          'Ward',
                          leader.ward ?? 'Not provided'
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(24),

                // Additional Information
                if (leader.education != null && leader.education!.isNotEmpty ||
                    leader.record != null && leader.record!.isNotEmpty ||
                    leader.contribution != null && leader.contribution!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Gap(12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (leader.education != null && leader.education!.isNotEmpty) ...[
                                const Text(
                                  'Education',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const Gap(8),
                                ...leader.education!.map((edu) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('• ', style: TextStyle(fontSize: 14)),
                                      Expanded(
                                        child: Text(
                                          edu,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                const Gap(12),
                              ],
                              if (leader.record != null && leader.record!.isNotEmpty) ...[
                                const Text(
                                  'Record',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  leader.record!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                const Gap(12),
                              ],
                              if (leader.contribution != null && leader.contribution!.isNotEmpty) ...[
                                const Text(
                                  'Contribution',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  leader.contribution!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const Gap(24),
                    ],
                  ),

                // Account Information
                const Text(
                  'Account Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Gap(12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildProfileInfoRow(
                          Icons.person_outline,
                          'User ID',
                          leader.userId.toString(),
                        ),
                        const Divider(),
                        _buildProfileInfoRow(
                          Icons.business,
                          'Municipality ID',
                          leader.municipalityId.toString(),
                        ),
                        const Divider(),
                        _buildProfileInfoRow(
                          Icons.check_circle_outline,
                          'Payment Status',
                          leader.paid == true ? 'Paid' : 'Unpaid',
                        ),
                        if (leader.createdAt != null) ...[
                          const Divider(),
                          _buildProfileInfoRow(
                            Icons.calendar_today,
                            'Member Since',
                            '${leader.createdAt!.day}/${leader.createdAt!.month}/${leader.createdAt!.year}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const Gap(100),
              ],
            ),
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

  Widget _buildRoleSpecificContent(String leaderLevel) {
    switch (leaderLevel) {
      case 'Admin':
        return _buildPermissionCard(
          'ADMIN PERMISSIONS',
          [
            '✅ Full System Access',
            '✅ Manage All Municipalities',
            '✅ Create/Delete Users',
            '✅ System Configuration',
            '✅ Advanced Reports',
            '✅ Notifications',
          ],
          Colors.red.shade50,
          Colors.red.shade700,
        );
      case 'Chairperson':
        return _buildPermissionCard(
          'CHAIRPERSON PERMISSIONS',
          [
            '✅ Municipality Leadership',
            '✅ Assign Lower Leaders',
            '✅ Policy Decisions',
            '✅ Budget Oversight',
            '✅ Strategic Planning',
            '✅ Notifications',
          ],
          Colors.purple.shade50,
          Colors.purple.shade700,
        );
      case 'Secretary':
        return _buildPermissionCard(
          'SECRETARY PERMISSIONS',
          [
            '✅ Meeting Management',
            '✅ Document Control',
            '✅ Communication Hub',
            '✅ Record Keeping',
            '✅ Schedule Coordination',
            '✅ Notifications',
          ],
          Colors.green.shade50,
          Colors.green.shade700,
        );
      case 'Treasurer':
        return _buildPermissionCard(
          'TREASURER PERMISSIONS',
          [
            '✅ Financial Oversight',
            '✅ Budget Management',
            '✅ Expense Tracking',
            '✅ Financial Reports',
            '✅ Payment Authorization',
            '✅ Notifications',
          ],
          Colors.orange.shade50,
          Colors.orange.shade700,
        );
      case 'Ward Convenor':
        return _buildPermissionCard(
          'WARD CONVENOR PERMISSIONS',
          [
            '✅ Ward Management',
            '✅ Visit Scheduling',
            '✅ Member Registration',
            '✅ Local Issue Resolution',
            '✅ Community Liaison',
            '✅ Notifications',
          ],
          Colors.blue.shade50,
          Colors.blue.shade700,
        );
      case 'Sub District Leaders':
        return _buildPermissionCard(
          'SUB DISTRICT PERMISSIONS',
          [
            '✅ District Coordination',
            '✅ Multi-Ward Oversight',
            '✅ Resource Allocation',
            '✅ Regional Planning',
            '✅ Cross-Ward Projects',
            '✅ Notifications',
          ],
          Colors.teal.shade50,
          Colors.teal.shade700,
        );
      case 'Executive members':
        return _buildPermissionCard(
          'EXECUTIVE PERMISSIONS',
          [
            '✅ Executive Decisions',
            '✅ Committee Leadership',
            '✅ Policy Implementation',
            '✅ Strategic Oversight',
            '✅ Departmental Management',
            '✅ Notifications',
          ],
          Colors.indigo.shade50,
          Colors.indigo.shade700,
        );
      case 'Top':
        return _buildPermissionCard(
          'TOP LEADER PERMISSIONS',
          [
            '✅ Senior Leadership Role',
            '✅ Strategic Decision Making',
            '✅ Resource Allocation',
            '✅ Community Oversight',
            '✅ Notifications',
          ],
          Colors.amber.shade50,
          Colors.amber.shade700,
        );
      default:
        return _buildPermissionCard(
          'BASIC LEADER PERMISSIONS',
          [
            '✅ Basic Visit Management',
            '✅ Member Interaction',
            '✅ Issue Reporting',
            '✅ Community Engagement',
            '✅ Notifications',
            '🔒 Limited Administrative Access',
          ],
          Colors.grey.shade50,
          Colors.grey.shade700,
        );
    }
  }

  Widget _buildPermissionCard(String title, List<String> permissions, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const Gap(8),
          ...permissions.map((permission) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              permission,
              style: TextStyle(
                fontSize: 11,
                color: textColor.withOpacity(0.8),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.textSecondary),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
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
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: AppTheme.primaryColor,
              ),
              const Gap(8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}