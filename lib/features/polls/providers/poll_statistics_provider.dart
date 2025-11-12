import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart' hide OptionStatistic, PollStatisticsResponse;
import '../../../providers/visits_provider.dart';
import '../../../data/models/poll_statistics_response.dart';

/// Provider for poll statistics functionality
final pollStatisticsProvider = StateNotifierProvider.family<PollStatisticsNotifier, AsyncValue<PollStatisticsResponse?>, int>((ref, pollId) {
  final apiService = ref.watch(apiServiceProvider);
  return PollStatisticsNotifier(apiService, pollId);
});

/// Provider for automatic statistics refresh
final statisticsRefreshProvider = StreamProvider.family<PollStatisticsResponse?, int>((ref, pollId) {
  final notifier = ref.watch(pollStatisticsProvider(pollId).notifier);

  // Auto-refresh statistics every 30 seconds when poll is active
  return Stream.periodic(const Duration(seconds: 30), (count) {
    notifier.refreshStatistics();
    return ref.watch(pollStatisticsProvider(pollId)).valueOrNull;
  }).asyncMap((stats) => stats);
});

/// Notifier for managing poll statistics state
class PollStatisticsNotifier extends StateNotifier<AsyncValue<PollStatisticsResponse?>> {
  final ApiService _apiService;
  final int _pollId;
  Timer? _refreshTimer;

  PollStatisticsNotifier(this._apiService, this._pollId) : super(const AsyncValue.loading()) {
    loadStatistics();
    _setupAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  /// Load poll statistics from API
  /// Constitutional requirement: Real-time statistics display (FR-003)
  Future<void> loadStatistics() async {
    try {
      state = const AsyncValue.loading();

      final statisticsWrapper = await _apiService.getPollStatistics(_pollId);
      state = AsyncValue.data(statisticsWrapper.data);

    } catch (e, stack) {
      // Handle common API errors gracefully
      String errorMessage = 'Failed to load poll statistics';

      if (e.toString().contains('404')) {
        errorMessage = 'Poll not found';
      } else if (e.toString().contains('403') || e.toString().contains('401')) {
        errorMessage = 'Access denied to poll statistics';
      } else if (e.toString().contains('500')) {
        errorMessage = 'Server error. Please try again.';
      }

      state = AsyncValue.error(errorMessage, stack);
    }
  }

  /// Manually refresh statistics from API
  Future<void> refreshStatistics() async {
    await loadStatistics();
  }

  /// Force refresh statistics after vote submission
  /// This ensures statistics update immediately after user votes
  Future<void> refreshAfterVote() async {
    // Add a small delay to allow server processing
    await Future.delayed(const Duration(milliseconds: 1500));
    await loadStatistics();
  }

  /// Setup automatic refresh timer for real-time updates
  void _setupAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      // Only auto-refresh if we're not in error state
      if (!state.hasError) {
        loadStatistics();
      }
    });
  }

  /// Get formatted participation rate as percentage string
  String get participationRateFormatted {
    final stats = state.valueOrNull;
    if (stats == null) return '0%';
    return '${(stats.participationRate).toStringAsFixed(1)}%';
  }

  /// Get total votes count
  int get totalVotes {
    return state.valueOrNull?.totalVotes ?? 0;
  }

  /// Get total eligible voters
  int get totalEligibleVoters {
    return state.valueOrNull?.totalEligibleVoters ?? 0;
  }

  /// Check if statistics are currently loading
  bool get isLoading => state.isLoading;

  /// Check if statistics failed to load
  bool get hasError => state.hasError;

  /// Get error message if any
  String? get errorMessage => state.when(
    data: (stats) => null,
    loading: () => null,
    error: (error, stack) => error.toString(),
  );

  /// Get option statistics sorted by vote count (descending)
  List<OptionStatistic> get sortedOptionStatistics {
    final stats = state.valueOrNull;
    if (stats == null) return [];

    final options = List<OptionStatistic>.from(stats.optionStatistics);
    options.sort((a, b) => b.voteCount.compareTo(a.voteCount));
    return options;
  }

  /// Get the leading option (most voted)
  OptionStatistic? get leadingOption {
    final sorted = sortedOptionStatistics;
    return sorted.isNotEmpty ? sorted.first : null;
  }

  /// Check if statistics are available and valid
  bool get hasValidStatistics {
    return state.valueOrNull != null && !state.hasError;
  }

  /// Get last update timestamp
  DateTime? get lastUpdated {
    return state.valueOrNull?.lastUpdatedAt;
  }

  /// Get formatted last update time
  String get lastUpdatedFormatted {
    final lastUpdate = lastUpdated;
    if (lastUpdate == null) return 'Never';

    final now = DateTime.now();
    final difference = now.difference(lastUpdate);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  /// Legacy methods for backward compatibility
  Future<void> refresh() async => await refreshStatistics();
  void reset() => state = const AsyncValue.data(null);
}

/// Extension to provide additional statistics utilities
extension PollStatisticsUtils on PollStatisticsResponse {
  /// Check if poll has significant participation (>10%)
  bool get hasSignificantParticipation => participationRate > 0.1;

  /// Check if there's a clear winner (>50% votes)
  bool get hasClearWinner {
    return optionStatistics.any((option) => option.percentage > 50.0);
  }

  /// Get the winning option if there's a clear winner
  OptionStatistic? get winningOption {
    if (!hasClearWinner) return null;

    return optionStatistics
        .where((option) => option.percentage > 50.0)
        .reduce((a, b) => a.voteCount > b.voteCount ? a : b);
  }

  /// Check if voting is close (top two options within 10%)
  bool get isCloseVoting {
    if (optionStatistics.length < 2) return false;

    final sorted = List<OptionStatistic>.from(optionStatistics)
      ..sort((a, b) => b.voteCount.compareTo(a.voteCount));

    final diff = sorted[0].percentage - sorted[1].percentage;
    return diff <= 10.0;
  }
}