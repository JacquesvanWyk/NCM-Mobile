import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/api_service.dart';
import '../data/models/user_model.dart';
import '../data/models/visit_model.dart';
import '../data/models/supporter_model.dart';
import 'api_provider.dart';
import 'members_provider.dart';
import 'supporters_provider.dart';
import 'visits_provider.dart';

// Combined analytics data model
class AnalyticsData {
  // Visit stats
  final int totalVisits;
  final int completedVisits;
  final int scheduledVisits;
  final int cancelledVisits;
  final double? averageSentiment;
  final List<SatisfactionDistribution>? satisfactionDistribution;

  // Member stats
  final int totalMembers;
  final int activeMembers;
  final int pendingMembers;

  // Supporter stats
  final int totalSupporters;
  final int registeredVoters;
  final int willVote;
  final int specialVote;
  final int approvedSupporters;
  final Map<String, int> wardDistribution;

  // Weekly activity (visits per day)
  final Map<String, int> weeklyActivity;

  AnalyticsData({
    required this.totalVisits,
    required this.completedVisits,
    required this.scheduledVisits,
    required this.cancelledVisits,
    this.averageSentiment,
    this.satisfactionDistribution,
    required this.totalMembers,
    required this.activeMembers,
    required this.pendingMembers,
    required this.totalSupporters,
    required this.registeredVoters,
    required this.willVote,
    required this.specialVote,
    required this.approvedSupporters,
    required this.wardDistribution,
    required this.weeklyActivity,
  });

  // Computed properties
  double get completionRate => totalVisits > 0 ? completedVisits / totalVisits : 0;
  double get voterRegistrationRate => totalSupporters > 0 ? registeredVoters / totalSupporters : 0;
  double get satisfactionScore {
    if (satisfactionDistribution == null || satisfactionDistribution!.isEmpty) return 0;
    final satisfied = satisfactionDistribution!
        .where((s) => s.memberSatisfaction.toLowerCase().contains('satisfied'))
        .fold<int>(0, (sum, s) => sum + s.count);
    final total = satisfactionDistribution!.fold<int>(0, (sum, s) => sum + s.count);
    return total > 0 ? (satisfied / total) * 100 : 0;
  }
}

// Analytics provider
final analyticsProvider = FutureProvider<AnalyticsData>((ref) async {
  final apiService = ref.read(apiServiceProvider);

  // Fetch stats from API
  final visitStats = await _fetchVisitStats(apiService);
  final supporterStats = await _fetchSupporterStats(apiService);

  // Get data from state notifier providers
  final membersState = ref.read(membersProvider);
  final supportersState = ref.read(supportersProvider);
  final visitsState = ref.read(visitsProvider);

  // Extract lists from AsyncValue states
  final members = membersState.valueOrNull ?? <MemberModel>[];
  final supporters = supportersState.valueOrNull ?? <SupporterModel>[];
  final visits = visitsState.valueOrNull ?? <VisitModel>[];

  // Calculate visit counts by status
  final completedVisits = visits.where((v) => v.status.toLowerCase() == 'completed').length;
  final scheduledVisits = visits.where((v) => v.status.toLowerCase() == 'scheduled').length;
  final cancelledVisits = visits.where((v) => v.status.toLowerCase() == 'cancelled').length;

  // Calculate member counts by status
  final activeMembers = members.where((m) => m.isActive).length;
  final pendingMembers = members.where((m) => m.status?.toLowerCase() == 'pending').length;

  // Calculate ward distribution from supporters
  final wardDistribution = <String, int>{};
  for (final supporter in supporters) {
    final ward = supporter.ward ?? 'Unknown';
    wardDistribution[ward] = (wardDistribution[ward] ?? 0) + 1;
  }

  // Calculate weekly activity from visits
  final weeklyActivity = _calculateWeeklyActivity(visits);

  return AnalyticsData(
    totalVisits: visitStats?.totalVisits ?? visits.length,
    completedVisits: completedVisits,
    scheduledVisits: scheduledVisits,
    cancelledVisits: cancelledVisits,
    averageSentiment: visitStats?.averageSentiment,
    satisfactionDistribution: visitStats?.satisfactionDistribution,
    totalMembers: members.length,
    activeMembers: activeMembers,
    pendingMembers: pendingMembers,
    totalSupporters: supporterStats?.total ?? supporters.length,
    registeredVoters: supporterStats?.registeredVoters ?? 0,
    willVote: supporterStats?.willVote ?? 0,
    specialVote: supporterStats?.needsSpecialVote ?? 0,
    approvedSupporters: supporterStats?.approved ?? 0,
    wardDistribution: wardDistribution,
    weeklyActivity: weeklyActivity,
  );
});

Future<VisitStatsModel?> _fetchVisitStats(ApiService apiService) async {
  try {
    return await apiService.getSentimentStats(null, null, null, null);
  } catch (e) {
    return null;
  }
}

Future<SupporterStatsResponse?> _fetchSupporterStats(ApiService apiService) async {
  try {
    return await apiService.getSupporterStats();
  } catch (e) {
    return null;
  }
}

Map<String, int> _calculateWeeklyActivity(List<VisitModel> visits) {
  final now = DateTime.now();
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final activity = <String, int>{};

  // Initialize all days with 0
  for (final day in weekDays) {
    activity[day] = 0;
  }

  // Count visits for the last 7 days
  for (final visit in visits) {
    final visitDate = visit.visitDate ?? visit.actualDate ?? visit.scheduledDate;
    if (visitDate != null) {
      final daysDiff = now.difference(visitDate).inDays;
      if (daysDiff >= 0 && daysDiff < 7) {
        final dayIndex = (visitDate.weekday - 1) % 7;
        final dayName = weekDays[dayIndex];
        activity[dayName] = (activity[dayName] ?? 0) + 1;
      }
    }
  }

  return activity;
}
