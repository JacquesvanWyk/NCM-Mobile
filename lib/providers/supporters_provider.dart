import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/supporter_model.dart';
import 'visits_provider.dart';

// Supporters provider
final supportersProvider = StateNotifierProvider<SupportersNotifier, AsyncValue<List<SupporterModel>>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SupportersNotifier(apiService);
});

class SupportersNotifier extends StateNotifier<AsyncValue<List<SupporterModel>>> {
  final ApiService _apiService;

  SupportersNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadSupporters();
  }

  Future<void> loadSupporters({
    String? ward,
    String? registeredVoter,
    String? search,
    int page = 1,
  }) async {
    try {
      state = const AsyncValue.loading();

      final response = await _apiService.getSupporters(
        page,
        ward,
        registeredVoter,
        search,
      );

      state = AsyncValue.data(response.data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<SupporterModel> createSupporter({
    required String name,
    required String surname,
    required String telephone,
    required String ward,
    String? email,
    String? address,
    String? registeredVoter,
    String? voter,
    String? specialVote,
    String? picture,
  }) async {
    try {
      final request = CreateSupporterRequest(
        name: name,
        surname: surname,
        email: email,
        telephone: telephone,
        address: address,
        ward: ward,
        registeredVoter: registeredVoter == 'yes',
        voter: voter,
        specialVote: specialVote,
        picture: picture,
      );

      final response = await _apiService.createSupporter(request);
      final newSupporter = response.supporter;

      // Add to state
      state.whenData((supporters) {
        state = AsyncValue.data([newSupporter, ...supporters]);
      });

      return newSupporter;
    } catch (e) {
      rethrow;
    }
  }

  Future<SupporterModel> getSupporter(int id) async {
    try {
      final response = await _apiService.getSupporter(id);
      return response.supporter;
    } catch (e) {
      rethrow;
    }
  }

  // Helper methods to filter supporters
  List<SupporterModel> searchSupporters(String query) {
    return state.whenData((supporters) {
      if (query.isEmpty) return supporters;

      final lowerQuery = query.toLowerCase();
      return supporters.where((supporter) {
        return supporter.displayFullName.toLowerCase().contains(lowerQuery) ||
               supporter.displayPhone.contains(query) ||
               supporter.displayEmail.toLowerCase().contains(lowerQuery);
      }).toList();
    }).valueOrNull ?? [];
  }

  List<SupporterModel> filterByWard(String ward) {
    return state.whenData((supporters) {
      return supporters.where((supporter) => supporter.ward == ward).toList();
    }).valueOrNull ?? [];
  }

  List<SupporterModel> getRegisteredVoters() {
    return state.whenData((supporters) {
      return supporters.where((supporter) => supporter.isRegisteredVoter).toList();
    }).valueOrNull ?? [];
  }

  List<SupporterModel> getWillVoteList() {
    return state.whenData((supporters) {
      return supporters.where((supporter) => supporter.willVote).toList();
    }).valueOrNull ?? [];
  }

  List<SupporterModel> getSpecialVoteList() {
    return state.whenData((supporters) {
      return supporters.where((supporter) => supporter.needsSpecialVote).toList();
    }).valueOrNull ?? [];
  }

  List<SupporterModel> getApprovedSupporters() {
    return state.whenData((supporters) {
      return supporters.where((supporter) => supporter.isApproved).toList();
    }).valueOrNull ?? [];
  }

  // Get unique wards from supporters list
  List<String> getAvailableWards() {
    return state.whenData((supporters) {
      return supporters
          .map((s) => s.ward)
          .where((ward) => ward != null)
          .map((ward) => ward!)
          .toSet()
          .toList()
        ..sort();
    }).valueOrNull ?? [];
  }
}

// Provider for supporter statistics
final supporterStatsProvider = FutureProvider<SupporterStatsResponse>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getSupporterStats();
});

// Provider to check if user can manage supporters (leader/field_worker only)
final canManageSupportersProvider = FutureProvider<bool>((ref) async {
  final user = await AuthService.getUser();
  final userType = user?.userType;
  return userType == 'leader' || userType == 'field_worker';
});
