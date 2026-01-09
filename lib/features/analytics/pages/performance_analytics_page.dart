import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/analytics_provider.dart';

class PerformanceAnalyticsPage extends ConsumerStatefulWidget {
  const PerformanceAnalyticsPage({super.key});

  @override
  ConsumerState<PerformanceAnalyticsPage> createState() => _PerformanceAnalyticsPageState();
}

class _PerformanceAnalyticsPageState extends ConsumerState<PerformanceAnalyticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 0, bottom: 60),
              centerTitle: true,
              title: const Text(
                'Reports',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => ref.invalidate(analyticsProvider),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Members'),
                Tab(text: 'Supporters'),
              ],
            ),
          ),
        ],
        body: ref.watch(analyticsProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
                const Gap(16),
                Text('Failed to load analytics', style: TextStyle(color: AppTheme.textSecondary)),
                const Gap(8),
                TextButton(
                  onPressed: () => ref.invalidate(analyticsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (data) => TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(data),
              _buildMembersTab(data),
              _buildSupportersTab(data),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(AnalyticsData data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics Grid
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Total Visits',
                  value: data.totalVisits.toString(),
                  icon: Icons.location_on_rounded,
                  color: Colors.blue,
                  subtitle: '${data.completedVisits} completed',
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildMetricCard(
                  title: 'Members',
                  value: data.totalMembers.toString(),
                  icon: Icons.people_rounded,
                  color: Colors.green,
                  subtitle: '${data.activeMembers} active',
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Supporters',
                  value: data.totalSupporters.toString(),
                  icon: Icons.favorite_rounded,
                  color: Colors.orange,
                  subtitle: '${data.registeredVoters} voters',
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildMetricCard(
                  title: 'Satisfaction',
                  value: '${data.satisfactionScore.toStringAsFixed(0)}%',
                  icon: Icons.sentiment_satisfied_rounded,
                  color: Colors.purple,
                  subtitle: 'Member rating',
                ),
              ),
            ],
          ),

          const Gap(28),

          // Weekly Activity
          _buildSectionHeader('Weekly Activity', Icons.show_chart_rounded),
          const Gap(16),
          _buildWeeklyActivityChart(data.weeklyActivity),

          const Gap(28),

          // Visit Status Breakdown
          _buildSectionHeader('Visit Status', Icons.pie_chart_rounded),
          const Gap(16),
          _buildVisitStatusCard(data),

          const Gap(28),

          // Quick Stats
          _buildSectionHeader('Quick Stats', Icons.speed_rounded),
          const Gap(16),
          _buildQuickStatsCard(data),

          const Gap(100),
        ],
      ),
    );
  }

  Widget _buildMembersTab(AnalyticsData data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Member Stats Cards
          Row(
            children: [
              Expanded(child: _buildStatPill('Total', data.totalMembers, Colors.blue)),
              const Gap(8),
              Expanded(child: _buildStatPill('Active', data.activeMembers, Colors.green)),
              const Gap(8),
              Expanded(child: _buildStatPill('Pending', data.pendingMembers, Colors.orange)),
            ],
          ),

          const Gap(28),

          // Member Activity
          _buildSectionHeader('Member Status', Icons.person_rounded),
          const Gap(16),
          _buildMemberStatusCard(data),

          const Gap(28),

          // Satisfaction Breakdown
          if (data.satisfactionDistribution != null && data.satisfactionDistribution!.isNotEmpty) ...[
            _buildSectionHeader('Satisfaction Breakdown', Icons.sentiment_satisfied_alt_rounded),
            const Gap(16),
            _buildSatisfactionCard(data),
          ],

          const Gap(100),
        ],
      ),
    );
  }

  Widget _buildSupportersTab(AnalyticsData data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Supporter Stats
          Row(
            children: [
              Expanded(child: _buildStatPill('Total', data.totalSupporters, Colors.purple)),
              const Gap(8),
              Expanded(child: _buildStatPill('Approved', data.approvedSupporters, Colors.green)),
              const Gap(8),
              Expanded(child: _buildStatPill('Voters', data.registeredVoters, Colors.blue)),
            ],
          ),

          const Gap(28),

          // Voting Statistics
          _buildSectionHeader('Voting Statistics', Icons.how_to_vote_rounded),
          const Gap(16),
          _buildVotingStatsCard(data),

          const Gap(28),

          // Ward Distribution
          if (data.wardDistribution.isNotEmpty) ...[
            _buildSectionHeader('Ward Distribution', Icons.map_rounded),
            const Gap(16),
            _buildWardDistributionCard(data),
          ],

          const Gap(100),
        ],
      ),
    );
  }

  // Widget Builders

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Gap(16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: -1,
            ),
          ),
          const Gap(4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: AppTheme.primaryColor),
        ),
        const Gap(12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyActivityChart(Map<String, int> activity) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxValue = activity.values.isEmpty ? 1 : activity.values.reduce((a, b) => a > b ? a : b);
    final effectiveMax = maxValue == 0 ? 1 : maxValue;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: days.map((day) {
                final value = activity[day] ?? 0;
                final height = (value / effectiveMax) * 120;
                final isToday = DateTime.now().weekday == days.indexOf(day) + 1;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isToday ? AppTheme.primaryColor : AppTheme.textSecondary,
                      ),
                    ),
                    const Gap(6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 32,
                      height: height < 8 ? 8 : height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isToday
                              ? [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.7)]
                              : [Colors.blue.shade300, Colors.blue.shade100],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                        color: isToday ? AppTheme.primaryColor : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitStatusCard(AnalyticsData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatusRow('Completed', data.completedVisits, data.totalVisits, Colors.green),
          const Gap(16),
          _buildStatusRow('Scheduled', data.scheduledVisits, data.totalVisits, Colors.blue),
          const Gap(16),
          _buildStatusRow('Cancelled', data.cancelledVisits, data.totalVisits, Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, int count, int total, Color color) {
    final percentage = total > 0 ? count / total : 0.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const Gap(10),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            Text(
              '$count (${(percentage * 100).toStringAsFixed(0)}%)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        const Gap(8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatsCard(AnalyticsData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildQuickStatRow(
            Icons.check_circle_rounded,
            'Completion Rate',
            '${(data.completionRate * 100).toStringAsFixed(1)}%',
            Colors.green,
          ),
          const Divider(height: 24),
          _buildQuickStatRow(
            Icons.how_to_vote_rounded,
            'Voter Registration',
            '${(data.voterRegistrationRate * 100).toStringAsFixed(1)}%',
            Colors.blue,
          ),
          const Divider(height: 24),
          _buildQuickStatRow(
            Icons.thumb_up_rounded,
            'Will Vote',
            data.willVote.toString(),
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const Gap(14),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStatPill(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberStatusCard(AnalyticsData data) {
    final total = data.totalMembers;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: total > 0 ? data.activeMembers / total : 0,
                            strokeWidth: 10,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '${total > 0 ? ((data.activeMembers / total) * 100).toStringAsFixed(0) : 0}%',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildMiniStatRow('Active Members', data.activeMembers, Colors.green),
                    const Gap(12),
                    _buildMiniStatRow('Pending Approval', data.pendingMembers, Colors.orange),
                    const Gap(12),
                    _buildMiniStatRow('Total Registered', data.totalMembers, Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatRow(String label, int value, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSatisfactionCard(AnalyticsData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: data.satisfactionDistribution!.map((item) {
          final color = _getSatisfactionColor(item.memberSatisfaction);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildMiniStatRow(item.memberSatisfaction, item.count, color),
          );
        }).toList(),
      ),
    );
  }

  Color _getSatisfactionColor(String satisfaction) {
    final lower = satisfaction.toLowerCase();
    if (lower.contains('very satisfied') || lower.contains('excellent')) return Colors.green;
    if (lower.contains('satisfied') || lower.contains('good')) return Colors.lightGreen;
    if (lower.contains('neutral') || lower.contains('average')) return Colors.orange;
    if (lower.contains('dissatisfied') || lower.contains('poor')) return Colors.red;
    return Colors.grey;
  }

  Widget _buildVotingStatsCard(AnalyticsData data) {
    final total = data.totalSupporters;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: total > 0 ? data.registeredVoters / total : 0,
                        strokeWidth: 10,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${total > 0 ? ((data.registeredVoters / total) * 100).toStringAsFixed(0) : 0}%',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Registered',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildMiniStatRow('Registered Voters', data.registeredVoters, Colors.green),
                    const Gap(12),
                    _buildMiniStatRow('Will Vote', data.willVote, Colors.blue),
                    const Gap(12),
                    _buildMiniStatRow('Special Vote', data.specialVote, Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWardDistributionCard(AnalyticsData data) {
    final sortedWards = data.wardDistribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final total = data.totalSupporters;
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.red, Colors.teal];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: sortedWards.asMap().entries.map((entry) {
          final index = entry.key;
          final ward = entry.value;
          final color = colors[index % colors.length];
          final percentage = total > 0 ? ward.value / total : 0.0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ward.key,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      '${ward.value} (${(percentage * 100).toStringAsFixed(0)}%)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
