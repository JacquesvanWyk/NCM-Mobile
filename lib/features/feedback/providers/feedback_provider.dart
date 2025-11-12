import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../data/models/feedback_model.dart';

final feedbackProvider = StateNotifierProvider<FeedbackNotifier, AsyncValue<bool>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return FeedbackNotifier(apiService, auth);
});

final feedbackHistoryProvider = StateNotifierProvider<FeedbackHistoryNotifier, AsyncValue<List<FeedbackItem>>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return FeedbackHistoryNotifier(apiService);
});

final feedbackFormProvider = StateNotifierProvider<FeedbackFormNotifier, FeedbackFormState>((ref) {
  return FeedbackFormNotifier();
});

final queuedFeedbackProvider = StateNotifierProvider<QueuedFeedbackNotifier, List<FeedbackItem>>((ref) {
  return QueuedFeedbackNotifier();
});

class FeedbackNotifier extends StateNotifier<AsyncValue<bool>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  FeedbackNotifier(this._apiService, this._auth) : super(const AsyncValue.data(false));

  Future<void> submitFeedback({
    required String category,
    required String message,
    File? photo,
  }) async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user?.member?.municipalityId == null) {
        state = AsyncValue.error('No municipality access', StackTrace.current);
        return;
      }

      await _apiService.submitFeedback(
        municipalityId: user!.member!.municipalityId,
        category: category,
        message: message,
        photo: photo,
      );

      state = const AsyncValue.data(true);

      // Reset state after showing success
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = const AsyncValue.data(false);
        }
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> submitOfflineFeedback({
    required String category,
    required String message,
    File? photo,
  }) async {
    try {
      // Add to offline queue
      final feedback = FeedbackItem(
        id: DateTime.now().millisecondsSinceEpoch,
        category: category,
        message: message,
        status: 'queued',
        createdAt: DateTime.now(),
        isOffline: true,
      );

      // Store in local queue (implementation would use local storage)
      state = const AsyncValue.data(true);

      // Show queued message
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = const AsyncValue.data(false);
        }
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class FeedbackHistoryNotifier extends StateNotifier<AsyncValue<List<FeedbackItem>>> {
  final ApiService _apiService;

  FeedbackHistoryNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadFeedbackHistory();
  }

  Future<void> loadFeedbackHistory() async {
    try {
      state = const AsyncValue.loading();

      final history = await _apiService.getFeedbackHistory();

      // Sort by date (newest first)
      history.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      state = AsyncValue.data(history);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadFeedbackHistory();
  }
}

class FeedbackFormNotifier extends StateNotifier<FeedbackFormState> {
  FeedbackFormNotifier() : super(const FeedbackFormState());

  void updateCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void updateMessage(String message) {
    state = state.copyWith(message: message);
  }

  void updatePhoto(File? photo) {
    state = state.copyWith(photo: photo);
  }

  void clearForm() {
    state = const FeedbackFormState();
  }

  bool get isValid {
    return state.category != null &&
           state.category!.isNotEmpty &&
           state.message.isNotEmpty;
  }

  String? validateCategory() {
    if (state.category == null || state.category!.isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  String? validateMessage() {
    if (state.message.isEmpty) {
      return 'Please enter your feedback message';
    }
    return null;
  }
}

class QueuedFeedbackNotifier extends StateNotifier<List<FeedbackItem>> {
  QueuedFeedbackNotifier() : super([]);

  void addToQueue(FeedbackItem feedback) {
    state = [...state, feedback];
  }

  void removeFromQueue(int feedbackId) {
    state = state.where((item) => item.id != feedbackId).toList();
  }

  void clearQueue() {
    state = [];
  }

  Future<void> syncQueuedFeedback() async {
    // Implementation would sync queued feedback when online
    for (final feedback in state) {
      try {
        // Submit feedback to API
        // On success, remove from queue
      } catch (e) {
        // Keep in queue for next sync attempt
      }
    }
  }
}

// Feedback form state management
class FeedbackFormState {
  final String? category;
  final String message;
  final File? photo;

  const FeedbackFormState({
    this.category,
    this.message = '',
    this.photo,
  });

  FeedbackFormState copyWith({
    String? category,
    String? message,
    File? photo,
  }) {
    return FeedbackFormState(
      category: category ?? this.category,
      message: message ?? this.message,
      photo: photo ?? this.photo,
    );
  }
}

// Feedback categories provider
final feedbackCategoriesProvider = Provider<List<String>>((ref) {
  return [
    'Service Delivery',
    'Infrastructure',
    'Water & Sanitation',
    'Electricity',
    'Roads & Transport',
    'Waste Management',
    'General',
  ];
});