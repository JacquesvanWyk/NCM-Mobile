import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../data/models/event_model.dart';
import '../../../data/models/user_model.dart';

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
      final municipalityId = user?.member?.municipalityId;
      if (municipalityId == null) {
        state = AsyncValue.error('No municipality access', StackTrace.current);
        return;
      }

      final eventModels = await _apiService.getEvents(
        municipalityId,
        upcomingOnly: upcomingOnly,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      // Convert EventModel to Event
      final events = eventModels.map((e) => Event(
        id: e.id,
        municipalityId: e.municipalityId,
        title: e.title,
        description: e.description,
        eventType: e.eventType,
        eventDate: e.eventDate,
        location: e.location,
        capacity: e.capacity,
        registrationRequired: e.registrationRequired,
        registrationDeadline: e.registrationDeadline,
        status: e.status,
        userRsvpStatus: e.userRsvpStatus,
        userGuestsCount: e.userGuestsCount,
        totalAttending: e.totalAttending,
      )).toList();

      state = AsyncValue.data(events);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
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
      final municipalityId = user?.member?.municipalityId;
      if (municipalityId == null) {
        state = AsyncValue.error('No municipality access', StackTrace.current);
        return;
      }

      final eventModel = await _apiService.getEventDetail(municipalityId, _eventId);

      // Convert EventModel to Event
      final event = Event(
        id: eventModel.id,
        municipalityId: eventModel.municipalityId,
        title: eventModel.title,
        description: eventModel.description,
        eventType: eventModel.eventType,
        eventDate: eventModel.eventDate,
        location: eventModel.location,
        capacity: eventModel.capacity,
        registrationRequired: eventModel.registrationRequired,
        registrationDeadline: eventModel.registrationDeadline,
        status: eventModel.status,
        userRsvpStatus: eventModel.userRsvpStatus,
        userGuestsCount: eventModel.userGuestsCount,
        totalAttending: eventModel.totalAttending,
      );

      state = AsyncValue.data(event);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadEventDetail();
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
}
