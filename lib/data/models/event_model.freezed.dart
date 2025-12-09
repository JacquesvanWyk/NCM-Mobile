// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int get municipalityId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type')
  String? get eventType => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  DateTime get eventDate => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'registration_required')
  bool get registrationRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'registration_deadline')
  DateTime? get registrationDeadline => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_rsvp_status')
  String? get userRsvpStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_guests_count')
  int get userGuestsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_attending')
  int get totalAttending => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'municipality_id') int municipalityId,
      String title,
      String description,
      @JsonKey(name: 'event_type') String? eventType,
      @JsonKey(name: 'event_date') DateTime eventDate,
      String location,
      int? capacity,
      @JsonKey(name: 'registration_required') bool registrationRequired,
      @JsonKey(name: 'registration_deadline') DateTime? registrationDeadline,
      String status,
      @JsonKey(name: 'user_rsvp_status') String? userRsvpStatus,
      @JsonKey(name: 'user_guests_count') int userGuestsCount,
      @JsonKey(name: 'total_attending') int totalAttending,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? municipalityId = null,
    Object? title = null,
    Object? description = null,
    Object? eventType = freezed,
    Object? eventDate = null,
    Object? location = null,
    Object? capacity = freezed,
    Object? registrationRequired = null,
    Object? registrationDeadline = freezed,
    Object? status = null,
    Object? userRsvpStatus = freezed,
    Object? userGuestsCount = null,
    Object? totalAttending = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      registrationRequired: null == registrationRequired
          ? _value.registrationRequired
          : registrationRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      registrationDeadline: freezed == registrationDeadline
          ? _value.registrationDeadline
          : registrationDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userRsvpStatus: freezed == userRsvpStatus
          ? _value.userRsvpStatus
          : userRsvpStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      userGuestsCount: null == userGuestsCount
          ? _value.userGuestsCount
          : userGuestsCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAttending: null == totalAttending
          ? _value.totalAttending
          : totalAttending // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'municipality_id') int municipalityId,
      String title,
      String description,
      @JsonKey(name: 'event_type') String? eventType,
      @JsonKey(name: 'event_date') DateTime eventDate,
      String location,
      int? capacity,
      @JsonKey(name: 'registration_required') bool registrationRequired,
      @JsonKey(name: 'registration_deadline') DateTime? registrationDeadline,
      String status,
      @JsonKey(name: 'user_rsvp_status') String? userRsvpStatus,
      @JsonKey(name: 'user_guests_count') int userGuestsCount,
      @JsonKey(name: 'total_attending') int totalAttending,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? municipalityId = null,
    Object? title = null,
    Object? description = null,
    Object? eventType = freezed,
    Object? eventDate = null,
    Object? location = null,
    Object? capacity = freezed,
    Object? registrationRequired = null,
    Object? registrationDeadline = freezed,
    Object? status = null,
    Object? userRsvpStatus = freezed,
    Object? userGuestsCount = null,
    Object? totalAttending = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      registrationRequired: null == registrationRequired
          ? _value.registrationRequired
          : registrationRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      registrationDeadline: freezed == registrationDeadline
          ? _value.registrationDeadline
          : registrationDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userRsvpStatus: freezed == userRsvpStatus
          ? _value.userRsvpStatus
          : userRsvpStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      userGuestsCount: null == userGuestsCount
          ? _value.userGuestsCount
          : userGuestsCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAttending: null == totalAttending
          ? _value.totalAttending
          : totalAttending // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl implements _Event {
  const _$EventImpl(
      {required this.id,
      @JsonKey(name: 'municipality_id') required this.municipalityId,
      required this.title,
      required this.description,
      @JsonKey(name: 'event_type') this.eventType,
      @JsonKey(name: 'event_date') required this.eventDate,
      required this.location,
      this.capacity,
      @JsonKey(name: 'registration_required') this.registrationRequired = false,
      @JsonKey(name: 'registration_deadline') this.registrationDeadline,
      this.status = 'published',
      @JsonKey(name: 'user_rsvp_status') this.userRsvpStatus,
      @JsonKey(name: 'user_guests_count') this.userGuestsCount = 0,
      @JsonKey(name: 'total_attending') this.totalAttending = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'municipality_id')
  final int municipalityId;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'event_type')
  final String? eventType;
  @override
  @JsonKey(name: 'event_date')
  final DateTime eventDate;
  @override
  final String location;
  @override
  final int? capacity;
  @override
  @JsonKey(name: 'registration_required')
  final bool registrationRequired;
  @override
  @JsonKey(name: 'registration_deadline')
  final DateTime? registrationDeadline;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'user_rsvp_status')
  final String? userRsvpStatus;
  @override
  @JsonKey(name: 'user_guests_count')
  final int userGuestsCount;
  @override
  @JsonKey(name: 'total_attending')
  final int totalAttending;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Event(id: $id, municipalityId: $municipalityId, title: $title, description: $description, eventType: $eventType, eventDate: $eventDate, location: $location, capacity: $capacity, registrationRequired: $registrationRequired, registrationDeadline: $registrationDeadline, status: $status, userRsvpStatus: $userRsvpStatus, userGuestsCount: $userGuestsCount, totalAttending: $totalAttending, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.registrationRequired, registrationRequired) ||
                other.registrationRequired == registrationRequired) &&
            (identical(other.registrationDeadline, registrationDeadline) ||
                other.registrationDeadline == registrationDeadline) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userRsvpStatus, userRsvpStatus) ||
                other.userRsvpStatus == userRsvpStatus) &&
            (identical(other.userGuestsCount, userGuestsCount) ||
                other.userGuestsCount == userGuestsCount) &&
            (identical(other.totalAttending, totalAttending) ||
                other.totalAttending == totalAttending) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      municipalityId,
      title,
      description,
      eventType,
      eventDate,
      location,
      capacity,
      registrationRequired,
      registrationDeadline,
      status,
      userRsvpStatus,
      userGuestsCount,
      totalAttending,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final int id,
      @JsonKey(name: 'municipality_id') required final int municipalityId,
      required final String title,
      required final String description,
      @JsonKey(name: 'event_type') final String? eventType,
      @JsonKey(name: 'event_date') required final DateTime eventDate,
      required final String location,
      final int? capacity,
      @JsonKey(name: 'registration_required') final bool registrationRequired,
      @JsonKey(name: 'registration_deadline')
      final DateTime? registrationDeadline,
      final String status,
      @JsonKey(name: 'user_rsvp_status') final String? userRsvpStatus,
      @JsonKey(name: 'user_guests_count') final int userGuestsCount,
      @JsonKey(name: 'total_attending') final int totalAttending,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'municipality_id')
  int get municipalityId;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'event_type')
  String? get eventType;
  @override
  @JsonKey(name: 'event_date')
  DateTime get eventDate;
  @override
  String get location;
  @override
  int? get capacity;
  @override
  @JsonKey(name: 'registration_required')
  bool get registrationRequired;
  @override
  @JsonKey(name: 'registration_deadline')
  DateTime? get registrationDeadline;
  @override
  String get status;
  @override
  @JsonKey(name: 'user_rsvp_status')
  String? get userRsvpStatus;
  @override
  @JsonKey(name: 'user_guests_count')
  int get userGuestsCount;
  @override
  @JsonKey(name: 'total_attending')
  int get totalAttending;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventListResponse _$EventListResponseFromJson(Map<String, dynamic> json) {
  return _EventListResponse.fromJson(json);
}

/// @nodoc
mixin _$EventListResponse {
  List<Event> get data => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get lastPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventListResponseCopyWith<EventListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventListResponseCopyWith<$Res> {
  factory $EventListResponseCopyWith(
          EventListResponse value, $Res Function(EventListResponse) then) =
      _$EventListResponseCopyWithImpl<$Res, EventListResponse>;
  @useResult
  $Res call(
      {List<Event> data,
      int currentPage,
      int perPage,
      int total,
      int lastPage});
}

/// @nodoc
class _$EventListResponseCopyWithImpl<$Res, $Val extends EventListResponse>
    implements $EventListResponseCopyWith<$Res> {
  _$EventListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? currentPage = null,
    Object? perPage = null,
    Object? total = null,
    Object? lastPage = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventListResponseImplCopyWith<$Res>
    implements $EventListResponseCopyWith<$Res> {
  factory _$$EventListResponseImplCopyWith(_$EventListResponseImpl value,
          $Res Function(_$EventListResponseImpl) then) =
      __$$EventListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Event> data,
      int currentPage,
      int perPage,
      int total,
      int lastPage});
}

/// @nodoc
class __$$EventListResponseImplCopyWithImpl<$Res>
    extends _$EventListResponseCopyWithImpl<$Res, _$EventListResponseImpl>
    implements _$$EventListResponseImplCopyWith<$Res> {
  __$$EventListResponseImplCopyWithImpl(_$EventListResponseImpl _value,
      $Res Function(_$EventListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? currentPage = null,
    Object? perPage = null,
    Object? total = null,
    Object? lastPage = null,
  }) {
    return _then(_$EventListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventListResponseImpl implements _EventListResponse {
  const _$EventListResponseImpl(
      {required final List<Event> data,
      required this.currentPage,
      required this.perPage,
      required this.total,
      required this.lastPage})
      : _data = data;

  factory _$EventListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventListResponseImplFromJson(json);

  final List<Event> _data;
  @override
  List<Event> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int currentPage;
  @override
  final int perPage;
  @override
  final int total;
  @override
  final int lastPage;

  @override
  String toString() {
    return 'EventListResponse(data: $data, currentPage: $currentPage, perPage: $perPage, total: $total, lastPage: $lastPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      currentPage,
      perPage,
      total,
      lastPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventListResponseImplCopyWith<_$EventListResponseImpl> get copyWith =>
      __$$EventListResponseImplCopyWithImpl<_$EventListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventListResponseImplToJson(
      this,
    );
  }
}

abstract class _EventListResponse implements EventListResponse {
  const factory _EventListResponse(
      {required final List<Event> data,
      required final int currentPage,
      required final int perPage,
      required final int total,
      required final int lastPage}) = _$EventListResponseImpl;

  factory _EventListResponse.fromJson(Map<String, dynamic> json) =
      _$EventListResponseImpl.fromJson;

  @override
  List<Event> get data;
  @override
  int get currentPage;
  @override
  int get perPage;
  @override
  int get total;
  @override
  int get lastPage;
  @override
  @JsonKey(ignore: true)
  _$$EventListResponseImplCopyWith<_$EventListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RsvpResponse _$RsvpResponseFromJson(Map<String, dynamic> json) {
  return _RsvpResponse.fromJson(json);
}

/// @nodoc
mixin _$RsvpResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'rsvp_status')
  String? get rsvpStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RsvpResponseCopyWith<RsvpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RsvpResponseCopyWith<$Res> {
  factory $RsvpResponseCopyWith(
          RsvpResponse value, $Res Function(RsvpResponse) then) =
      _$RsvpResponseCopyWithImpl<$Res, RsvpResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'rsvp_status') String? rsvpStatus});
}

/// @nodoc
class _$RsvpResponseCopyWithImpl<$Res, $Val extends RsvpResponse>
    implements $RsvpResponseCopyWith<$Res> {
  _$RsvpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? rsvpStatus = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      rsvpStatus: freezed == rsvpStatus
          ? _value.rsvpStatus
          : rsvpStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RsvpResponseImplCopyWith<$Res>
    implements $RsvpResponseCopyWith<$Res> {
  factory _$$RsvpResponseImplCopyWith(
          _$RsvpResponseImpl value, $Res Function(_$RsvpResponseImpl) then) =
      __$$RsvpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'rsvp_status') String? rsvpStatus});
}

/// @nodoc
class __$$RsvpResponseImplCopyWithImpl<$Res>
    extends _$RsvpResponseCopyWithImpl<$Res, _$RsvpResponseImpl>
    implements _$$RsvpResponseImplCopyWith<$Res> {
  __$$RsvpResponseImplCopyWithImpl(
      _$RsvpResponseImpl _value, $Res Function(_$RsvpResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? rsvpStatus = freezed,
  }) {
    return _then(_$RsvpResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      rsvpStatus: freezed == rsvpStatus
          ? _value.rsvpStatus
          : rsvpStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RsvpResponseImpl implements _RsvpResponse {
  const _$RsvpResponseImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'rsvp_status') this.rsvpStatus});

  factory _$RsvpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RsvpResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'rsvp_status')
  final String? rsvpStatus;

  @override
  String toString() {
    return 'RsvpResponse(success: $success, message: $message, rsvpStatus: $rsvpStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RsvpResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.rsvpStatus, rsvpStatus) ||
                other.rsvpStatus == rsvpStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, rsvpStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RsvpResponseImplCopyWith<_$RsvpResponseImpl> get copyWith =>
      __$$RsvpResponseImplCopyWithImpl<_$RsvpResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RsvpResponseImplToJson(
      this,
    );
  }
}

abstract class _RsvpResponse implements RsvpResponse {
  const factory _RsvpResponse(
          {required final bool success,
          required final String message,
          @JsonKey(name: 'rsvp_status') final String? rsvpStatus}) =
      _$RsvpResponseImpl;

  factory _RsvpResponse.fromJson(Map<String, dynamic> json) =
      _$RsvpResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'rsvp_status')
  String? get rsvpStatus;
  @override
  @JsonKey(ignore: true)
  _$$RsvpResponseImplCopyWith<_$RsvpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RsvpRequest _$RsvpRequestFromJson(Map<String, dynamic> json) {
  return _RsvpRequest.fromJson(json);
}

/// @nodoc
mixin _$RsvpRequest {
  String get status =>
      throw _privateConstructorUsedError; // 'attending', 'not_attending', 'maybe'
  @JsonKey(name: 'guests_count')
  int get guestsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RsvpRequestCopyWith<RsvpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RsvpRequestCopyWith<$Res> {
  factory $RsvpRequestCopyWith(
          RsvpRequest value, $Res Function(RsvpRequest) then) =
      _$RsvpRequestCopyWithImpl<$Res, RsvpRequest>;
  @useResult
  $Res call({String status, @JsonKey(name: 'guests_count') int guestsCount});
}

/// @nodoc
class _$RsvpRequestCopyWithImpl<$Res, $Val extends RsvpRequest>
    implements $RsvpRequestCopyWith<$Res> {
  _$RsvpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? guestsCount = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      guestsCount: null == guestsCount
          ? _value.guestsCount
          : guestsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RsvpRequestImplCopyWith<$Res>
    implements $RsvpRequestCopyWith<$Res> {
  factory _$$RsvpRequestImplCopyWith(
          _$RsvpRequestImpl value, $Res Function(_$RsvpRequestImpl) then) =
      __$$RsvpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, @JsonKey(name: 'guests_count') int guestsCount});
}

/// @nodoc
class __$$RsvpRequestImplCopyWithImpl<$Res>
    extends _$RsvpRequestCopyWithImpl<$Res, _$RsvpRequestImpl>
    implements _$$RsvpRequestImplCopyWith<$Res> {
  __$$RsvpRequestImplCopyWithImpl(
      _$RsvpRequestImpl _value, $Res Function(_$RsvpRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? guestsCount = null,
  }) {
    return _then(_$RsvpRequestImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      guestsCount: null == guestsCount
          ? _value.guestsCount
          : guestsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RsvpRequestImpl implements _RsvpRequest {
  const _$RsvpRequestImpl(
      {required this.status,
      @JsonKey(name: 'guests_count') this.guestsCount = 0});

  factory _$RsvpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RsvpRequestImplFromJson(json);

  @override
  final String status;
// 'attending', 'not_attending', 'maybe'
  @override
  @JsonKey(name: 'guests_count')
  final int guestsCount;

  @override
  String toString() {
    return 'RsvpRequest(status: $status, guestsCount: $guestsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RsvpRequestImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.guestsCount, guestsCount) ||
                other.guestsCount == guestsCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, guestsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RsvpRequestImplCopyWith<_$RsvpRequestImpl> get copyWith =>
      __$$RsvpRequestImplCopyWithImpl<_$RsvpRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RsvpRequestImplToJson(
      this,
    );
  }
}

abstract class _RsvpRequest implements RsvpRequest {
  const factory _RsvpRequest(
          {required final String status,
          @JsonKey(name: 'guests_count') final int guestsCount}) =
      _$RsvpRequestImpl;

  factory _RsvpRequest.fromJson(Map<String, dynamic> json) =
      _$RsvpRequestImpl.fromJson;

  @override
  String get status;
  @override // 'attending', 'not_attending', 'maybe'
  @JsonKey(name: 'guests_count')
  int get guestsCount;
  @override
  @JsonKey(ignore: true)
  _$$RsvpRequestImplCopyWith<_$RsvpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
