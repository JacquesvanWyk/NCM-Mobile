import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../data/models/announcement_model.dart';
import '../../../data/models/user_model.dart';

final announcementsProvider = StateNotifierProvider<AnnouncementsNotifier, AsyncValue<List<Announcement>>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return AnnouncementsNotifier(apiService, auth);
});

final announcementDetailProvider = StateNotifierProvider.family<AnnouncementDetailNotifier, AsyncValue<Announcement?>, int>((ref, announcementId) {
  final apiService = ref.watch(apiServiceProvider);
  return AnnouncementDetailNotifier(apiService, announcementId);
});

final announcementFilterProvider = StateProvider<String?>((ref) => null);

class AnnouncementsNotifier extends StateNotifier<AsyncValue<List<Announcement>>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  AnnouncementsNotifier(this._apiService, this._auth) : super(const AsyncValue.loading()) {
    loadAnnouncements();
  }

  Future<void> loadAnnouncements({String? priority}) async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user == null) {
        state = AsyncValue.error('Not authenticated', StackTrace.current);
        return;
      }

      final response = await _apiService.getAnnouncements(
        1, // page
        priority,
      );

      // Get announcements from response
      final announcements = response.data;

      // Sort by priority (urgent first) then by date
      announcements.sort((a, b) {
        final priorityOrder = {'urgent': 0, 'high': 1, 'medium': 2, 'low': 3};
        final priorityCompare = (priorityOrder[a.priority] ?? 4).compareTo(priorityOrder[b.priority] ?? 4);

        if (priorityCompare != 0) return priorityCompare;
        return b.publishedAt.compareTo(a.publishedAt);
      });

      state = AsyncValue.data(announcements);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadAnnouncements();
  }

  Future<void> filterByPriority(String? priority) async {
    await loadAnnouncements(priority: priority);
  }
}

class AnnouncementDetailNotifier extends StateNotifier<AsyncValue<Announcement?>> {
  final ApiService _apiService;
  final int _announcementId;

  AnnouncementDetailNotifier(this._apiService, this._announcementId) : super(const AsyncValue.loading()) {
    loadAnnouncementDetail();
  }

  Future<void> loadAnnouncementDetail() async {
    try {
      state = const AsyncValue.loading();
      // Implementation would fetch announcement detail from API
      state = const AsyncValue.data(null); // Simplified for now
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Helper provider for offline caching
final cachedAnnouncementsProvider = StateNotifierProvider<CachedAnnouncementsNotifier, List<Announcement>>((ref) {
  return CachedAnnouncementsNotifier();
});

class CachedAnnouncementsNotifier extends StateNotifier<List<Announcement>> {
  CachedAnnouncementsNotifier() : super([]);

  void updateCache(List<Announcement> announcements) {
    state = announcements;
  }

  void clearCache() {
    state = [];
  }

  List<Announcement> getCachedAnnouncements() {
    return state;
  }
}