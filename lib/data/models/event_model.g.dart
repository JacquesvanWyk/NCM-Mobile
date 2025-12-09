// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: (json['id'] as num).toInt(),
      municipalityId: (json['municipality_id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      eventType: json['event_type'] as String?,
      eventDate: DateTime.parse(json['event_date'] as String),
      location: json['location'] as String,
      capacity: (json['capacity'] as num?)?.toInt(),
      registrationRequired: json['registration_required'] as bool? ?? false,
      registrationDeadline: json['registration_deadline'] == null
          ? null
          : DateTime.parse(json['registration_deadline'] as String),
      status: json['status'] as String? ?? 'published',
      userRsvpStatus: json['user_rsvp_status'] as String?,
      userGuestsCount: (json['user_guests_count'] as num?)?.toInt() ?? 0,
      totalAttending: (json['total_attending'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'municipality_id': instance.municipalityId,
      'title': instance.title,
      'description': instance.description,
      'event_type': instance.eventType,
      'event_date': instance.eventDate.toIso8601String(),
      'location': instance.location,
      'capacity': instance.capacity,
      'registration_required': instance.registrationRequired,
      'registration_deadline': instance.registrationDeadline?.toIso8601String(),
      'status': instance.status,
      'user_rsvp_status': instance.userRsvpStatus,
      'user_guests_count': instance.userGuestsCount,
      'total_attending': instance.totalAttending,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$EventListResponseImpl _$$EventListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$EventListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      lastPage: (json['lastPage'] as num).toInt(),
    );

Map<String, dynamic> _$$EventListResponseImplToJson(
        _$EventListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'currentPage': instance.currentPage,
      'perPage': instance.perPage,
      'total': instance.total,
      'lastPage': instance.lastPage,
    };

_$RsvpResponseImpl _$$RsvpResponseImplFromJson(Map<String, dynamic> json) =>
    _$RsvpResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      rsvpStatus: json['rsvp_status'] as String?,
    );

Map<String, dynamic> _$$RsvpResponseImplToJson(_$RsvpResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'rsvp_status': instance.rsvpStatus,
    };

_$RsvpRequestImpl _$$RsvpRequestImplFromJson(Map<String, dynamic> json) =>
    _$RsvpRequestImpl(
      status: json['status'] as String,
      guestsCount: (json['guests_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$RsvpRequestImplToJson(_$RsvpRequestImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'guests_count': instance.guestsCount,
    };
