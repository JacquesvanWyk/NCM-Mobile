import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_service_factory.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/user_model.dart';
import 'auth_provider.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<MemberModel?>>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<AsyncValue<MemberModel?>> {
  final Ref _ref;

  ProfileNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = await AuthService.getUser();
      state = AsyncValue.data(user?.member);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    final currentMember = state.valueOrNull;
    state = const AsyncValue.loading();

    try {
      final api = ApiServiceFactory.instance;
      final response = await api.updateProfile(request);

      // Update local cached user data
      final currentUser = await AuthService.getUser();
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(member: response.member);
        await AuthService.saveUser(updatedUser);
      }

      state = AsyncValue.data(response.member);

      // Refresh auth provider to sync state
      _ref.invalidate(authProvider);
    } catch (e, stack) {
      // Restore previous state on error
      state = currentMember != null
          ? AsyncValue.data(currentMember)
          : AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<String> uploadPhoto(File photo) async {
    try {
      final api = ApiServiceFactory.instance;
      final response = await api.uploadProfilePhoto(photo);

      // Refresh profile to get updated photo URL
      await _loadProfile();
      _ref.invalidate(authProvider);

      return response.photoUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePhoto() async {
    try {
      final api = ApiServiceFactory.instance;
      await api.deleteProfilePhoto();

      await _loadProfile();
      _ref.invalidate(authProvider);
    } catch (e) {
      rethrow;
    }
  }

  void refresh() {
    _loadProfile();
  }
}
