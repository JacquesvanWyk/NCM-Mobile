import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';

class PerformanceAnalyticsPage extends ConsumerStatefulWidget {
  const PerformanceAnalyticsPage({super.key});

  @override
  ConsumerState<PerformanceAnalyticsPage> createState() => _PerformanceAnalyticsPageState();
}

class _PerformanceAnalyticsPageState extends ConsumerState<PerformanceAnalyticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Month';

  final List<String> _periodOptions = [
    'This Week',
    'This Month',
    'Last 3 Months',
    'This Year',
  ];

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
      appBar: AppBar(
        title: const Text('Performance Analytics'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.date_range),
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
              _refreshData();
            },
            itemBuilder: (context) => _periodOptions.map((period) {
              return PopupMenuItem(
                value: period,
                child: Row(
                  children: [
                    Icon(
                      _selectedPeriod == period ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      size: 16,
                      color: _selectedPeriod == period ? AppTheme.primaryColor : Colors.grey,
                    ),
                    const Gap(8),
                    Text(period),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Members'),
            Tab(text: 'Supporters'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildMembersTab(),
          _buildSupportersTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Header
          Row(
            children: [
              Text(
                _selectedPeriod,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, size: 16, color: Colors.green.shade600),
                    const Gap(4),
                    Text(
                      '↑ 12.5%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(20),

          // Key Metrics Cards
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Visits Completed',
                  '156',
                  Icons.location_on,
                  Colors.blue.shade100,
                  Colors.blue.shade600,
                  '+23 from last period',
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildMetricCard(
                  'New Members',
                  '43',
                  Icons.person_add,
                  Colors.green.shade100,
                  Colors.green.shade600,
                  '+8 from last period',
                ),
              ),
            ],
          ),

          const Gap(12),

          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Issues Resolved',
                  '29',
                  Icons.check_circle,
                  Colors.orange.shade100,
                  Colors.orange.shade600,
                  '+12 from last period',
                ),
              ),
              const Gap(12),
              Expanded(
                child: _buildMetricCard(
                  'Avg Visit Time',
                  '24m',
                  Icons.timer,
                  Colors.purple.shade100,
                  Colors.purple.shade600,
                  '-3m improvement',
                ),
              ),
            ],
          ),

          const Gap(24),

          // Performance Score
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Score',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '89/100',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            Text(
                              'Excellent Performance',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _buildScoreBar('Visit Completion', 0.95, Colors.blue),
                            const Gap(8),
                            _buildScoreBar('Member Satisfaction', 0.87, Colors.green),
                            const Gap(8),
                            _buildScoreBar('Response Time', 0.82, Colors.orange),
                            const Gap(8),
                            _buildScoreBar('Goal Achievement', 0.91, Colors.purple),
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

          // Activity Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weekly Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  SizedBox(
                    height: 200,
                    child: _buildActivityChart(),
                  ),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Recent Achievements
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Achievements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildAchievementItem(
                    'Top Performer',
                    'Highest visit completion rate this month',
                    Icons.star,
                    Colors.amber,
                  ),
                  const Gap(12),
                  _buildAchievementItem(
                    'Member Favorite',
                    '95% satisfaction rating from members',
                    Icons.favorite,
                    Colors.red,
                  ),
                  const Gap(12),
                  _buildAchievementItem(
                    'Problem Solver',
                    'Resolved 50+ community issues',
                    Icons.lightbulb,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Member Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Registered', '43', Colors.green),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard('Updated', '67', Colors.blue),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard('Verified', '38', Colors.purple),
              ),
            ],
          ),

          const Gap(20),

          // Registration Methods
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registration Methods',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildMethodItem('Manual Entry', 25, Colors.blue),
                  const Gap(12),
                  _buildMethodItem('OCR Scanning', 18, Colors.purple),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Member Demographics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Member Demographics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildDemographicItem('18-30 years', 28, Colors.green),
                  const Gap(8),
                  _buildDemographicItem('31-45 years', 35, Colors.blue),
                  const Gap(8),
                  _buildDemographicItem('46-60 years', 23, Colors.orange),
                  const Gap(8),
                  _buildDemographicItem('60+ years', 14, Colors.red),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Member Satisfaction
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Member Satisfaction',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300, width: 8),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: 0.87,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                  ),
                                  const Center(
                                    child: Text(
                                      '87%',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(8),
                            const Text('Average Score'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSatisfactionItem('Very Satisfied', 52, Colors.green),
                            const Gap(8),
                            _buildSatisfactionItem('Satisfied', 35, Colors.lightGreen),
                            const Gap(8),
                            _buildSatisfactionItem('Neutral', 10, Colors.orange),
                            const Gap(8),
                            _buildSatisfactionItem('Unsatisfied', 3, Colors.red),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Supporter Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total', '287', Colors.purple),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard('Active', '245', Colors.green),
              ),
              const Gap(12),
              Expanded(
                child: _buildStatCard('New', '42', Colors.blue),
              ),
            ],
          ),

          const Gap(20),

          // Voting Statistics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voting Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300, width: 8),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: 0.78,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                                  ),
                                  const Center(
                                    child: Text(
                                      '78%',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(8),
                            const Text('Registered Voters'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildVotingStatItem('Registered Voters', 224, Colors.green),
                            const Gap(8),
                            _buildVotingStatItem('Active Voters', 198, Colors.blue),
                            const Gap(8),
                            _buildVotingStatItem('Special Vote', 45, Colors.orange),
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

          // Supporter Status Breakdown
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status Breakdown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildStatusItem('Active', 245, Colors.green),
                  const Gap(12),
                  _buildStatusItem('Pending', 28, Colors.orange),
                  const Gap(12),
                  _buildStatusItem('Inactive', 14, Colors.red),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Ward Distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ward Distribution',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildWardItem('Ward 1', 68, Colors.blue),
                  const Gap(8),
                  _buildWardItem('Ward 2', 52, Colors.green),
                  const Gap(8),
                  _buildWardItem('Ward 3', 71, Colors.orange),
                  const Gap(8),
                  _buildWardItem('Ward 4', 45, Colors.purple),
                  const Gap(8),
                  _buildWardItem('Ward 5', 51, Colors.red),
                ],
              ),
            ),
          ),

          const Gap(16),

          // Recent Registrations
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Registrations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildRegistrationTrend('This Week', 42, Colors.green),
                  const Gap(8),
                  _buildRegistrationTrend('Last Week', 38, Colors.blue),
                  const Gap(8),
                  _buildRegistrationTrend('Two Weeks Ago', 29, Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Goal Progress
          const Text(
            'Monthly Goals Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),

          _buildGoalCard(
            'Visits Completed',
            156,
            180,
            Icons.location_on,
            Colors.blue,
          ),
          const Gap(16),

          _buildGoalCard(
            'New Registrations',
            43,
            50,
            Icons.person_add,
            Colors.green,
          ),
          const Gap(16),

          _buildGoalCard(
            'Issues Resolved',
            29,
            35,
            Icons.check_circle,
            Colors.orange,
          ),
          const Gap(16),

          _buildGoalCard(
            'Member Satisfaction',
            87,
            90,
            Icons.star,
            Colors.purple,
          ),

          const Gap(24),

          // Upcoming Targets
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upcoming Targets',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _buildTargetItem(
                    'Complete 200 visits',
                    'Next Month',
                    Icons.flag,
                    Colors.blue,
                  ),
                  const Gap(12),
                  _buildTargetItem(
                    'Register 60 new members',
                    'Next Month',
                    Icons.group_add,
                    Colors.green,
                  ),
                  const Gap(12),
                  _buildTargetItem(
                    'Achieve 95% satisfaction',
                    'Quarter Goal',
                    Icons.sentiment_very_satisfied,
                    Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color bgColor, Color iconColor, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const Spacer(),
              ],
            ),
            const Gap(12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const Gap(4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
            const Gap(8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBar(String label, double progress, Color color) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const Gap(8),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildActivityChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [20, 35, 28, 42, 38, 15, 25];
    final maxValue = values.reduce((a, b) => a > b ? a : b);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(days.length, (index) {
        final height = (values[index] / maxValue) * 150;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 30,
              height: height,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Gap(8),
            Text(
              days[index],
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAchievementItem(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Gap(4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitTypeItem(String type, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(12),
        Expanded(child: Text(type)),
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildOutcomeItem(String outcome, int percentage, Color color) {
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
        const Gap(8),
        Expanded(child: Text(outcome, style: const TextStyle(fontSize: 12))),
        Text('$percentage%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildMethodItem(String method, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(12),
        Expanded(child: Text(method)),
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildDemographicItem(String ageGroup, int percentage, Color color) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(ageGroup, style: const TextStyle(fontSize: 12)),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const Gap(8),
        Text('$percentage%', style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildSatisfactionItem(String level, int percentage, Color color) {
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
        const Gap(8),
        Expanded(child: Text(level, style: const TextStyle(fontSize: 12))),
        Text('$percentage%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildGoalCard(String title, int current, int target, IconData icon, Color color) {
    final progress = current / target;
    final isCompleted = current >= target;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 12, color: Colors.green.shade600),
                        const Gap(4),
                        Text(
                          'Complete',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                Text(
                  '$current',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  ' / $target',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Gap(8),
            LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetItem(String target, String timeframe, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                target,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                timeframe,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVotingStatItem(String label, int count, Color color) {
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
        const Gap(8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        Text(count.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStatusItem(String status, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(12),
        Expanded(child: Text(status)),
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildWardItem(String ward, int count, Color color) {
    final total = 287;
    final percentage = (count / total * 100).toInt();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(ward, style: const TextStyle(fontSize: 12)),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: count / total,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const Gap(8),
        Text('$count ($percentage%)', style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildRegistrationTrend(String period, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(12),
        Expanded(child: Text(period)),
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Gap(8),
        Icon(
          count > 30 ? Icons.trending_up : Icons.trending_flat,
          size: 16,
          color: count > 30 ? Colors.green : Colors.orange,
        ),
      ],
    );
  }

  void _refreshData() {
    // Simulate data refresh
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Analytics updated for $_selectedPeriod'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}