import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../data/models/event_model.dart';

final eventsProvider = StateNotifierProvider<EventsNotifier, AsyncValue<List<Event>>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return EventsNotifier(apiService, auth);
});

final eventDetailProvider = StateNotifierProvider.family<EventDetailNotifier, AsyncValue<Event?>, int>((ref, eventId) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return EventDetailNotifier(apiService, auth, eventId);
});

final eventRsvpProvider = StateNotifierProvider<EventRsvpNotifier, AsyncValue<bool>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return EventRsvpNotifier(apiService);
});

class EventsNotifier extends StateNotifier<AsyncValue<List<Event>>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  EventsNotifier(this._apiService, this._auth) : super(const AsyncValue.loading()) {
    loadEvents();
  }

  Future<void> loadEvents({bool upcomingOnly = true, DateTime? dateFrom, DateTime? dateTo}) async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user?.member?.municipalityId == null) {
        state = AsyncValue.error('No municipality access', StackTrace.current);
        return;
      }

      final events = await _apiService.getEvents(
        user!.member!.municipalityId,
        upcomingOnly: upcomingOnly,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      // Add RSVP status to each event
      final eventsWithRsvpStatus = <Event>[];
      for (final event in events) {
        final rsvpStatus = await _getUserRsvpStatus(event.id, user.member!.municipalityId);
        eventsWithRsvpStatus.add(event.copyWith(
          userRsvpStatus: rsvpStatus['status'],
          userGuestsCount: rsvpStatus['guests_count'] ?? 0,
        ));
      }

      state = AsyncValue.data(eventsWithRsvpStatus);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<Map<String, dynamic>> _getUserRsvpStatus(int eventId, int municipalityId) async {
    try {
      // This would be implemented based on API response
      return {'status': null, 'guests_count': 0}; // Simplified for now
    } catch (e) {
      return {'status': null, 'guests_count': 0};
    }
  }

  Future<void> refresh() async {
    await loadEvents();
  }
}

class EventDetailNotifier extends StateNotifier<AsyncValue<Event?>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;
  final int _eventId;

  EventDetailNotifier(this._apiService, this._auth, this._eventId) : super(const AsyncValue.loading()) {
    loadEventDetail();
  }

  Future<void> loadEventDetail() async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user?.member?.municipalityId == null) {
        state = AsyncValue.error('No municipality access', StackTrace.current);
        return;
      }

      final event = await _apiService.getEventDetail(user!.member!.municipalityId, _eventId);

      // Add RSVP status and attendance statistics
      final rsvpStatus = await _getUserRsvpStatus(_eventId, user.member!.municipalityId);
      final stats = await _getEventStats(_eventId, user.member!.municipalityId);

      final eventWithDetails = event.copyWith(
        userRsvpStatus: rsvpStatus['status'],
        userGuestsCount: rsvpStatus['guests_count'] ?? 0,
        totalAttending: stats['total_attending'] ?? 0,
        totalNotAttending: stats['total_not_attending'] ?? 0,
        totalMaybe: stats['total_maybe'] ?? 0,
      );

      state = AsyncValue.data(eventWithDetails);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<Map<String, dynamic>> _getUserRsvpStatus(int eventId, int municipalityId) async {
    try {
      // Implementation would fetch user's RSVP status from API
      return {'status': null, 'guests_count': 0};
    } catch (e) {
      return {'status': null, 'guests_count': 0};
    }
  }

  Future<Map<String, int>> _getEventStats(int eventId, int municipalityId) async {
    try {
      // Implementation would fetch event attendance stats from API
      return {
        'total_attending': 0,
        'total_not_attending': 0,
        'total_maybe': 0,
      };
    } catch (e) {
      return {
        'total_attending': 0,
        'total_not_attending': 0,
        'total_maybe': 0,
      };
    }
  }
}

class EventRsvpNotifier extends StateNotifier<AsyncValue<bool>> {
  final ApiService _apiService;

  EventRsvpNotifier(this._apiService) : super(const AsyncValue.data(false));

  Future<void> submitRsvp(int municipalityId, int eventId, String status, int guestsCount) async {
    try {
      state = const AsyncValue.loading();

      await _apiService.submitEventRsvp(municipalityId, eventId, {
        'status': status,
        'guests_count': guestsCount,
      });

      state = const AsyncValue.data(true);

      // Reset state after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = const AsyncValue.data(false);
        }
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addToCalendar(Event event, String calendarType) async {
    try {
      // Implementation would integrate with device calendar
      // For now, just simulate success
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Event model extension for UI state
extension EventExtension on Event {
  Event copyWith({
    String? userRsvpStatus,
    int? userGuestsCount,
    int? totalAttending,
    int? totalNotAttending,
    int? totalMaybe,
  }) {
    return Event(
      id: id,
      title: title,
      description: description,
      location: location,
      startsAt: startsAt,
      endsAt: endsAt,
      maxAttendees: maxAttendees,
      requiresRsvp: requiresRsvp,
      status: status,
      municipalityId: municipalityId,
      createdAt: createdAt,
      userRsvpStatus: userRsvpStatus ?? this.userRsvpStatus,
      userGuestsCount: userGuestsCount ?? this.userGuestsCount,
      totalAttending: totalAttending ?? this.totalAttending,
      totalNotAttending: totalNotAttending ?? this.totalNotAttending,
      totalMaybe: totalMaybe ?? this.totalMaybe,
    );
  }
}