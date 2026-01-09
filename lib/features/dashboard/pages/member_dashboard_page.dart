import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../../providers/auth_provider.dart';
import '../../auth/pages/login_page.dart';
import '../../members/pages/digital_membership_card_page.dart';
import '../../members/pages/member_profile_page.dart';
import '../../members/pages/qr_scanner_simple.dart';
import '../../members/pages/member_search_page.dart';
import '../../complaints/pages/complaint_logging_page.dart';
import '../../analytics/pages/performance_analytics_page.dart';
import '../../polls/pages/polls_page.dart';
import '../../announcements/pages/announcements_page.dart';
import '../../events/pages/events_page.dart';
import '../../payments/pages/payments_page.dart';
import '../../emergency/pages/emergency_page.dart';
import '../../notifications/pages/notifications_inbox_page.dart';
import '../../../providers/notification_provider.dart';

class MemberDashboardPage extends ConsumerStatefulWidget {
  const MemberDashboardPage({super.key});

  @override
  ConsumerState<MemberDashboardPage> createState() => _MemberDashboardPageState();
}

class _MemberDashboardPageState extends ConsumerState<MemberDashboardPage> {
  int _selectedIndex = 0;

  Future<void> _handleLogout() async {
    await AuthService.logout();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      return _buildHomeTab();
    } else if (_selectedIndex == 1) {
      return _buildEventsTab();
    } else if (_selectedIndex == 2) {
      return _buildReportTab();
    } else if (_selectedIndex == 3) {
      return MemberProfilePage(
        onBackToHome: () => setState(() => _selectedIndex = 0),
      );
    } else {
      return _buildPlaceholderTab();
    }
  }

  Widget _buildHomeTab() {
    final userAsync = ref.watch(authProvider);
    final user = userAsync.valueOrNull;
    final member = user?.member;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Profile and Actions
              Row(
                children: [
                  // Profile Picture and Info
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.orange.shade100,
                          backgroundImage: member?.displayPicture.isNotEmpty == true
                              ? NetworkImage(member!.displayPicture)
                              : null,
                          child: member?.displayPicture.isEmpty == true
                              ? const Icon(
                                  Icons.person,
                                  size: 28,
                                  color: Colors.orange,
                                )
                              : null,
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member?.displayFullName ?? user?.name ?? 'Member',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                'Municipality: ${member?.displayMunicipality ?? 'Unknown'} | Ward: ${member?.displayWard ?? 'Unknown'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Icons - Notification Bell with dynamic badge
                  Consumer(
                    builder: (context, ref, child) {
                      final unreadCountAsync = ref.watch(unreadNotificationCountProvider);
                      final unreadCount = unreadCountAsync.valueOrNull ?? 0;

                      return Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NotificationsInboxPage(),
                                ),
                              );
                            },
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  // TODO: Emergency services - enable when ready
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.emergency,
                  //     color: Colors.red[700],
                  //   ),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const EmergencyPage(),
                  //       ),
                  //     );
                  //   },
                  //   tooltip: 'Emergency Services',
                  // ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () => setState(() => _selectedIndex = 3),
                  ),
                ],
              ),

              const Gap(24),

              // Membership Status Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Membership Status',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            member?.isActive == true ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: member?.isActive == true ? AppTheme.primaryColor : Colors.grey,
                            ),
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const DigitalMembershipCardPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text('Digital Card'),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => _navigateToPayments(),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text('Payments'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(12),
                        image: member?.displayPicture.isNotEmpty == true
                            ? DecorationImage(
                                image: NetworkImage(member!.displayPicture),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: member?.displayPicture.isEmpty == true
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.orange,
                            )
                          : null,
                    ),
                  ],
                ),
              ),

              const Gap(32),

              // Civic Engagement Section
              const Text(
                'Civic Engagement',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),

              const Gap(16),

              // Civic Engagement Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _CivicEngagementCard(
                    icon: Icons.bar_chart,
                    title: 'Polls & Surveys',
                    onTap: () => _navigateToPolls(),
                  ),
                  _CivicEngagementCard(
                    icon: Icons.event,
                    title: 'Events',
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                  _CivicEngagementCard(
                    icon: Icons.campaign,
                    title: 'Announcements',
                    onTap: () => _navigateToAnnouncements(),
                  ),
                  _CivicEngagementCard(
                    icon: Icons.report_problem,
                    title: 'Report Issue',
                    onTap: () => setState(() => _selectedIndex = 2),
                  ),
                ],
              ),

              const Gap(100), // Bottom padding for navigation
            ],
          ),
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
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem_outlined),
            activeIcon: Icon(Icons.report_problem),
            label: 'Report',
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

  Widget _buildEventsTab() {
    return Scaffold(
      body: EventsPage(onBackPressed: () => setState(() => _selectedIndex = 0)),
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
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem_outlined),
            activeIcon: Icon(Icons.report_problem),
            label: 'Report',
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

  Widget _buildReportTab() {
    return Scaffold(
      body: ComplaintLoggingPage(onBackPressed: () => setState(() => _selectedIndex = 0)),
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
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem_outlined),
            activeIcon: Icon(Icons.report_problem),
            label: 'Report',
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

  Widget _buildPlaceholderTab() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coming Soon'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            Gap(16),
            Text(
              'This feature is coming soon!',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
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
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem_outlined),
            activeIcon: Icon(Icons.report_problem),
            label: 'Report',
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

  void _navigateToPolls() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PollsPage(),
      ),
    );
  }

  void _navigateToAnnouncements() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AnnouncementsPage(),
      ),
    );
  }

  void _navigateToEvents() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EventsPage(),
      ),
    );
  }

  void _navigateToReportIssue() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ComplaintLoggingPage(),
      ),
    );
    if (result != null && result is int && mounted) {
      setState(() => _selectedIndex = result);
    }
  }

  void _navigateToPayments() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PaymentsPage(),
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature feature coming soon')),
    );
  }
}

class _CivicEngagementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _CivicEngagementCard({
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
              const Gap(12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
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