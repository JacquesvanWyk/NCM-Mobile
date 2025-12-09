import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required int id,
    @JsonKey(name: 'municipality_id') required int municipalityId,
    required String title,
    required String description,
    @JsonKey(name: 'event_type') String? eventType,
    @JsonKey(name: 'event_date') required DateTime eventDate,
    required String location,
    int? capacity,
    @JsonKey(name: 'registration_required') @Default(false) bool registrationRequired,
    @JsonKey(name: 'registration_deadline') DateTime? registrationDeadline,
    @Default('published') String status,
    @JsonKey(name: 'user_rsvp_status') String? userRsvpStatus,
    @JsonKey(name: 'user_guests_count') @Default(0) int userGuestsCount,
    @JsonKey(name: 'total_attending') @Default(0) int totalAttending,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
class EventListResponse with _$EventListResponse {
  const factory EventListResponse({
    required List<Event> data,
    required int currentPage,
    required int perPage,
    required int total,
    required int lastPage,
  }) = _EventListResponse;

  factory EventListResponse.fromJson(Map<String, dynamic> json) => _$EventListResponseFromJson(json);
}

@freezed
class RsvpResponse with _$RsvpResponse {
  const factory RsvpResponse({
    required bool success,
    required String message,
    @JsonKey(name: 'rsvp_status') String? rsvpStatus,
  }) = _RsvpResponse;

  factory RsvpResponse.fromJson(Map<String, dynamic> json) => _$RsvpResponseFromJson(json);
}

@freezed
class RsvpRequest with _$RsvpRequest {
  const factory RsvpRequest({
    required String status, // 'attending', 'not_attending', 'maybe'
    @JsonKey(name: 'guests_count') @Default(0) int guestsCount,
  }) = _RsvpRequest;

  factory RsvpRequest.fromJson(Map<String, dynamic> json) => _$RsvpRequestFromJson(json);
}
