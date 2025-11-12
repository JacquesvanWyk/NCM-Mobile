import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/members_provider.dart';
import '../../../data/models/user_model.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<UserModel?>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return ProfileNotifier(apiService, auth);
});

final profileUpdateProvider = StateNotifierProvider<ProfileUpdateNotifier, AsyncValue<bool>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProfileUpdateNotifier(apiService);
});

final photoUploadProvider = StateNotifierProvider<PhotoUploadNotifier, PhotoUploadState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PhotoUploadNotifier(apiService);
});

final passwordChangeProvider = StateNotifierProvider<PasswordChangeNotifier, AsyncValue<bool>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PasswordChangeNotifier(apiService);
});

final notificationPreferencesProvider = StateNotifierProvider<NotificationPreferencesNotifier, NotificationPreferences>((ref) {
  final auth = ref.watch(authProvider);
  return NotificationPreferencesNotifier(auth);
});

class ProfileNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  ProfileNotifier(this._apiService, this._auth) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user == null) {
        state = const AsyncValue.data(null);
        return;
      }

      // Fetch latest profile data
      final profile = await _apiService.getProfile();

      state = AsyncValue.data(profile);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadProfile();
  }
}

class ProfileUpdateNotifier extends StateNotifier<AsyncValue<bool>> {
  final ApiService _apiService;

  ProfileUpdateNotifier(this._apiService) : super(const AsyncValue.data(false));

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? alternativePhone,
    String? address,
    String? town,
    Map<String, bool>? notificationPreferences,
  }) async {
    try {
      state = const AsyncValue.loading();

      final updateData = <String, dynamic>{};

      if (firstName != null) updateData['first_name'] = firstName;
      if (lastName != null) updateData['last_name'] = lastName;
      if (email != null) updateData['email'] = email;
      if (phone != null) updateData['phone'] = phone;
      if (alternativePhone != null) updateData['alternative_phone'] = alternativePhone;
      if (address != null) updateData['address'] = address;
      if (town != null) updateData['town'] = town;
      if (notificationPreferences != null) {
        updateData['notification_preferences'] = notificationPreferences;
      }

      await _apiService.updateProfile(updateData);

      state = const AsyncValue.data(true);

      // Reset state after showing success
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = const AsyncValue.data(false);
        }
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class PhotoUploadNotifier extends StateNotifier<PhotoUploadState> {
  final ApiService _apiService;

  PhotoUploadNotifier(this._apiService) : super(const PhotoUploadState());

  Future<void> uploadPhoto(File photo) async {
    try {
      state = state.copyWith(isUploading: true, error: null);

      final response = await _apiService.uploadProfilePhoto(photo);

      state = state.copyWith(
        isUploading: false,
        photoUrl: response['photo_url'],
        isSuccess: true,
      );

      // Reset success state after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = state.copyWith(isSuccess: false);
        }
      });
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> deletePhoto() async {
    try {
      state = state.copyWith(isUploading: true, error: null);

      await _apiService.deleteProfilePhoto();

      state = state.copyWith(
        isUploading: false,
        photoUrl: null,
        isSuccess: true,
      );

      // Reset success state after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = state.copyWith(isSuccess: false);
        }
      });
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: e.toString(),
      );
    }
  }

  void clearState() {
    state = const PhotoUploadState();
  }
}

class PasswordChangeNotifier extends StateNotifier<AsyncValue<bool>> {
  final ApiService _apiService;

  PasswordChangeNotifier(this._apiService) : super(const AsyncValue.data(false));

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      state = const AsyncValue.loading();

      await _apiService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      state = const AsyncValue.data(true);

      // Reset state after showing success
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = const AsyncValue.data(false);
        }
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class NotificationPreferencesNotifier extends StateNotifier<NotificationPreferences> {
  final AsyncValue<UserModel?> _auth;

  NotificationPreferencesNotifier(this._auth) : super(const NotificationPreferences()) {
    _loadPreferences();
  }

  void _loadPreferences() {
    final user = _auth.valueOrNull;
    if (user?.member != null) {
      final prefs = user!.member!.notificationPreferences ?? {};

      state = NotificationPreferences(
        pushNotifications: prefs['push_notifications'] ?? true,
        emailNotifications: prefs['email_notifications'] ?? true,
        announcementNotifications: prefs['announcement_notifications'] ?? true,
        eventNotifications: prefs['event_notifications'] ?? true,
        pollNotifications: prefs['poll_notifications'] ?? true,
      );
    }
  }

  Future<void> updatePreference(String key, bool value) async {
    try {
      // Update local state immediately
      switch (key) {
        case 'push_notifications':
          state = state.copyWith(pushNotifications: value);
          break;
        case 'email_notifications':
          state = state.copyWith(emailNotifications: value);
          break;
        case 'announcement_notifications':
          state = state.copyWith(announcementNotifications: value);
          break;
        case 'event_notifications':
          state = state.copyWith(eventNotifications: value);
          break;
        case 'poll_notifications':
          state = state.copyWith(pollNotifications: value);
          break;
      }

      // Sync with API (implementation would update preferences on server)
      // await _apiService.updateNotificationPreferences({key: value});
    } catch (e) {
      // Revert local state on error
      _loadPreferences();
    }
  }
}

// Photo upload state management
class PhotoUploadState {
  final bool isUploading;
  final String? photoUrl;
  final bool isSuccess;
  final String? error;

  const PhotoUploadState({
    this.isUploading = false,
    this.photoUrl,
    this.isSuccess = false,
    this.error,
  });

  PhotoUploadState copyWith({
    bool? isUploading,
    String? photoUrl,
    bool? isSuccess,
    String? error,
  }) {
    return PhotoUploadState(
      isUploading: isUploading ?? this.isUploading,
      photoUrl: photoUrl ?? this.photoUrl,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}

// Notification preferences model
class NotificationPreferences {
  final bool pushNotifications;
  final bool emailNotifications;
  final bool announcementNotifications;
  final bool eventNotifications;
  final bool pollNotifications;

  const NotificationPreferences({
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.announcementNotifications = true,
    this.eventNotifications = true,
    this.pollNotifications = true,
  });

  NotificationPreferences copyWith({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? announcementNotifications,
    bool? eventNotifications,
    bool? pollNotifications,
  }) {
    return NotificationPreferences(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      announcementNotifications: announcementNotifications ?? this.announcementNotifications,
      eventNotifications: eventNotifications ?? this.eventNotifications,
      pollNotifications: pollNotifications ?? this.pollNotifications,
    );
  }
}