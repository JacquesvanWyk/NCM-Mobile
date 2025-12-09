import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/visits_provider.dart';
import '../../../data/models/poll_model.dart' as poll;
import '../../../data/models/user_model.dart';
import '../../../data/models/vote_submission_request.dart';
import '../../../data/models/vote_submission_response.dart';
import '../../../data/models/poll_statistics_response.dart';

final pollsProvider = StateNotifierProvider<PollsNotifier, AsyncValue<List<poll.PollModel>>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return PollsNotifier(apiService, auth);
});

final pollDetailProvider = StateNotifierProvider.family<PollDetailNotifier, AsyncValue<poll.PollModel?>, int>((ref, pollId) {
  final apiService = ref.watch(apiServiceProvider);
  return PollDetailNotifier(apiService, pollId);
});

final pollVoteProvider = StateNotifierProvider<PollVoteNotifier, AsyncValue<VoteSubmissionResponse?>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PollVoteNotifier(apiService);
});

class PollsNotifier extends StateNotifier<AsyncValue<List<poll.PollModel>>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  PollsNotifier(this._apiService, this._auth) : super(const AsyncValue.loading()) {
    loadPolls();
  }

  Future<void> loadPolls() async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user?.member?.municipalityId == null) {
        state = AsyncValue.error('No municipality access', StackTrace.current);
        return;
      }

      final polls = await _apiService.getPolls(1, 'active'); // Get active polls, page 1

      // Convert API service PollModel to our Freezed PollModel
      final pollsWithStatus = <poll.PollModel>[];
      for (final apiPoll in polls) {
        final hasVoted = await _checkUserHasVoted(apiPoll.id, user?.member?.municipalityId ?? 0);

        // Convert options from API service PollOptionModel list to JSON string
        final optionsJson = jsonEncode(apiPoll.options.map((option) => {
          'id': option.id,
          'text': option.text,
          'vote_count': option.voteCount,
        }).toList());

        // Convert from API service PollModel to our Freezed PollModel
        final convertedPoll = poll.PollModel(
          id: apiPoll.id,
          title: apiPoll.title,
          description: apiPoll.description,
          pollType: 'single_choice', // Default since API service doesn't have pollType
          options: optionsJson,
          status: apiPoll.status,
          startsAt: apiPoll.startDate,
          endsAt: apiPoll.endDate,
          isPublic: true, // Default since API service doesn't have isPublic
          createdAt: DateTime.now(), // Default since API service doesn't have createdAt
          updatedAt: DateTime.now(), // Default since API service doesn't have updatedAt
          hasVoted: apiPoll.hasVoted,
          municipality: null, // Default since API service doesn't have municipality
        );
        pollsWithStatus.add(convertedPoll);
      }

      state = AsyncValue.data(pollsWithStatus);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<bool> _checkUserHasVoted(int pollId, int municipalityId) async {
    try {
      // Get poll details which include hasVoted status from the API
      final pollDetails = await _apiService.getPollDetails(pollId);
      return pollDetails.hasVoted;
    } catch (e) {
      // If we can't determine vote status, assume not voted for safety
      return false;
    }
  }

  Future<void> refresh() async {
    await loadPolls();
  }
}

class PollDetailNotifier extends StateNotifier<AsyncValue<poll.PollModel?>> {
  final ApiService _apiService;
  final int _pollId;

  PollDetailNotifier(this._apiService, this._pollId) : super(const AsyncValue.loading()) {
    loadPollDetail();
  }

  /// Load detailed poll information including vote status
  Future<void> loadPollDetail() async {
    try {
      state = const AsyncValue.loading();

      // Fetch poll details from API
      final apiPoll = await _apiService.getPollDetails(_pollId);

      // Convert options from API service PollOptionModel list to JSON string
      final optionsJson = jsonEncode(apiPoll.options.map((option) => {
        'id': option.id,
        'text': option.text,
        'vote_count': option.voteCount,
      }).toList());

      // Convert from API service PollModel to our Freezed PollModel
      final convertedPoll = poll.PollModel(
        id: apiPoll.id,
        title: apiPoll.title,
        description: apiPoll.description,
        pollType: 'single_choice', // Default since API service doesn't have pollType
        options: optionsJson,
        status: apiPoll.status,
        startsAt: apiPoll.startDate,
        endsAt: apiPoll.endDate,
        isPublic: true, // Default since API service doesn't have isPublic
        createdAt: DateTime.now(), // Default since API service doesn't have createdAt
        updatedAt: DateTime.now(), // Default since API service doesn't have updatedAt
        hasVoted: apiPoll.hasVoted,
        municipality: null, // Default since API service doesn't have municipality
      );

      state = AsyncValue.data(convertedPoll);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Refresh poll details from API
  Future<void> refresh() async {
    await loadPollDetail();
  }

  /// Update hasVoted status after successful vote submission
  void markAsVoted() {
    final currentPoll = state.valueOrNull;
    if (currentPoll != null) {
      final updatedPoll = currentPoll.copyWith(hasVoted: true);
      state = AsyncValue.data(updatedPoll);
    }
  }
}

class PollVoteNotifier extends StateNotifier<AsyncValue<VoteSubmissionResponse?>> {
  final ApiService _apiService;

  PollVoteNotifier(this._apiService) : super(const AsyncValue.data(null));

  /// Submit a vote for the specified poll option with enhanced error handling
  /// Constitutional requirement: Single vote per member per poll (FR-002)
  Future<void> submitVote(int pollId, int pollOptionId, {Map<String, dynamic>? responseData}) async {
    try {
      print('🗳️ VOTE: Starting vote submission for poll $pollId, option $pollOptionId');
      state = const AsyncValue.loading();

      final request = VoteSubmissionRequest(
        pollOptionId: pollOptionId,
        responseData: responseData,
      );
      print('🗳️ VOTE: Request created - pollOptionId: ${request.pollOptionId}');

      print('🗳️ VOTE: Calling API service submitVote...');
      final response = await _apiService.submitVote(pollId, request);
      print('🗳️ VOTE: API call successful! Response: ${response.toString()}');
      state = AsyncValue.data(response);

      // Auto-reset state after successful submission
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = const AsyncValue.data(null);
        }
      });
    } catch (e, stack) {
      // Enhanced error handling for specific vote submission scenarios
      print('❌ VOTE ERROR: Exception caught during vote submission');
      print('❌ VOTE ERROR: Error type: ${e.runtimeType}');
      print('❌ VOTE ERROR: Error message: $e');
      print('❌ VOTE ERROR: Stack trace: $stack');

      String errorMessage = 'Failed to submit vote';

      if (e.toString().contains('already voted') || e.toString().contains('409')) {
        errorMessage = 'You have already voted on this poll';
      } else if (e.toString().contains('404')) {
        errorMessage = 'Poll not found or not active';
      } else if (e.toString().contains('401') || e.toString().contains('403')) {
        errorMessage = 'You are not authorized to vote on this poll';
      } else if (e.toString().contains('422')) {
        errorMessage = 'Invalid vote option selected';
      } else if (e.toString().contains('500')) {
        errorMessage = 'Server error occurred. Please try again.';
      }

      print('❌ VOTE ERROR: Processed error message: $errorMessage');
      state = AsyncValue.error(errorMessage, stack);
    }
  }

  /// Reset vote submission state
  void reset() {
    state = const AsyncValue.data(null);
  }

  /// Check if vote submission is currently in progress
  bool get isSubmitting => state.isLoading;

  /// Get current vote submission status
  String? get submissionStatus => state.when(
    data: (response) => response != null ? 'success' : null,
    loading: () => 'submitting',
    error: (error, stack) => 'error',
  );

  /// Get human-readable error message
  String? get errorMessage => state.when(
    data: (response) => null,
    loading: () => null,
    error: (error, stack) => error.toString(),
  );
}

