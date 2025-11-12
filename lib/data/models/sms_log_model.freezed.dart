// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SmsLog _$SmsLogFromJson(Map<String, dynamic> json) {
  return _SmsLog.fromJson(json);
}

/// @nodoc
mixin _$SmsLog {
  int get id => throw _privateConstructorUsedError;
  String get messageId => throw _privateConstructorUsedError;
  String get recipient => throw _privateConstructorUsedError;
  String? get recipientName => throw _privateConstructorUsedError;
  String get messageContent => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmsLogCopyWith<SmsLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsLogCopyWith<$Res> {
  factory $SmsLogCopyWith(SmsLog value, $Res Function(SmsLog) then) =
      _$SmsLogCopyWithImpl<$Res, SmsLog>;
  @useResult
  $Res call(
      {int id,
      String messageId,
      String recipient,
      String? recipientName,
      String messageContent,
      String status,
      DateTime? sentAt,
      DateTime? deliveredAt,
      String? errorMessage,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$SmsLogCopyWithImpl<$Res, $Val extends SmsLog>
    implements $SmsLogCopyWith<$Res> {
  _$SmsLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? messageId = null,
    Object? recipient = null,
    Object? recipientName = freezed,
    Object? messageContent = null,
    Object? status = null,
    Object? sentAt = freezed,
    Object? deliveredAt = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: freezed == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String?,
      messageContent: null == messageContent
          ? _value.messageContent
          : messageContent // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsLogImplCopyWith<$Res> implements $SmsLogCopyWith<$Res> {
  factory _$$SmsLogImplCopyWith(
          _$SmsLogImpl value, $Res Function(_$SmsLogImpl) then) =
      __$$SmsLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String messageId,
      String recipient,
      String? recipientName,
      String messageContent,
      String status,
      DateTime? sentAt,
      DateTime? deliveredAt,
      String? errorMessage,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$SmsLogImplCopyWithImpl<$Res>
    extends _$SmsLogCopyWithImpl<$Res, _$SmsLogImpl>
    implements _$$SmsLogImplCopyWith<$Res> {
  __$$SmsLogImplCopyWithImpl(
      _$SmsLogImpl _value, $Res Function(_$SmsLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? messageId = null,
    Object? recipient = null,
    Object? recipientName = freezed,
    Object? messageContent = null,
    Object? status = null,
    Object? sentAt = freezed,
    Object? deliveredAt = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SmsLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: freezed == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String?,
      messageContent: null == messageContent
          ? _value.messageContent
          : messageContent // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsLogImpl implements _SmsLog {
  const _$SmsLogImpl(
      {required this.id,
      required this.messageId,
      required this.recipient,
      this.recipientName,
      required this.messageContent,
      required this.status,
      this.sentAt,
      this.deliveredAt,
      this.errorMessage,
      required this.createdAt,
      required this.updatedAt});

  factory _$SmsLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsLogImplFromJson(json);

  @override
  final int id;
  @override
  final String messageId;
  @override
  final String recipient;
  @override
  final String? recipientName;
  @override
  final String messageContent;
  @override
  final String status;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? deliveredAt;
  @override
  final String? errorMessage;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SmsLog(id: $id, messageId: $messageId, recipient: $recipient, recipientName: $recipientName, messageContent: $messageContent, status: $status, sentAt: $sentAt, deliveredAt: $deliveredAt, errorMessage: $errorMessage, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.messageContent, messageContent) ||
                other.messageContent == messageContent) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
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
      messageId,
      recipient,
      recipientName,
      messageContent,
      status,
      sentAt,
      deliveredAt,
      errorMessage,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsLogImplCopyWith<_$SmsLogImpl> get copyWith =>
      __$$SmsLogImplCopyWithImpl<_$SmsLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsLogImplToJson(
      this,
    );
  }
}

abstract class _SmsLog implements SmsLog {
  const factory _SmsLog(
      {required final int id,
      required final String messageId,
      required final String recipient,
      final String? recipientName,
      required final String messageContent,
      required final String status,
      final DateTime? sentAt,
      final DateTime? deliveredAt,
      final String? errorMessage,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$SmsLogImpl;

  factory _SmsLog.fromJson(Map<String, dynamic> json) = _$SmsLogImpl.fromJson;

  @override
  int get id;
  @override
  String get messageId;
  @override
  String get recipient;
  @override
  String? get recipientName;
  @override
  String get messageContent;
  @override
  String get status;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get deliveredAt;
  @override
  String? get errorMessage;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SmsLogImplCopyWith<_$SmsLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmsLogListResponse _$SmsLogListResponseFromJson(Map<String, dynamic> json) {
  return _SmsLogListResponse.fromJson(json);
}

/// @nodoc
mixin _$SmsLogListResponse {
  List<SmsLog> get data => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get lastPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmsLogListResponseCopyWith<SmsLogListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsLogListResponseCopyWith<$Res> {
  factory $SmsLogListResponseCopyWith(
          SmsLogListResponse value, $Res Function(SmsLogListResponse) then) =
      _$SmsLogListResponseCopyWithImpl<$Res, SmsLogListResponse>;
  @useResult
  $Res call(
      {List<SmsLog> data,
      int currentPage,
      int perPage,
      int total,
      int lastPage});
}

/// @nodoc
class _$SmsLogListResponseCopyWithImpl<$Res, $Val extends SmsLogListResponse>
    implements $SmsLogListResponseCopyWith<$Res> {
  _$SmsLogListResponseCopyWithImpl(this._value, this._then);

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
              as List<SmsLog>,
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
abstract class _$$SmsLogListResponseImplCopyWith<$Res>
    implements $SmsLogListResponseCopyWith<$Res> {
  factory _$$SmsLogListResponseImplCopyWith(_$SmsLogListResponseImpl value,
          $Res Function(_$SmsLogListResponseImpl) then) =
      __$$SmsLogListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SmsLog> data,
      int currentPage,
      int perPage,
      int total,
      int lastPage});
}

/// @nodoc
class __$$SmsLogListResponseImplCopyWithImpl<$Res>
    extends _$SmsLogListResponseCopyWithImpl<$Res, _$SmsLogListResponseImpl>
    implements _$$SmsLogListResponseImplCopyWith<$Res> {
  __$$SmsLogListResponseImplCopyWithImpl(_$SmsLogListResponseImpl _value,
      $Res Function(_$SmsLogListResponseImpl) _then)
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
    return _then(_$SmsLogListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SmsLog>,
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
class _$SmsLogListResponseImpl implements _SmsLogListResponse {
  const _$SmsLogListResponseImpl(
      {required final List<SmsLog> data,
      required this.currentPage,
      required this.perPage,
      required this.total,
      required this.lastPage})
      : _data = data;

  factory _$SmsLogListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsLogListResponseImplFromJson(json);

  final List<SmsLog> _data;
  @override
  List<SmsLog> get data {
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
    return 'SmsLogListResponse(data: $data, currentPage: $currentPage, perPage: $perPage, total: $total, lastPage: $lastPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsLogListResponseImpl &&
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
  _$$SmsLogListResponseImplCopyWith<_$SmsLogListResponseImpl> get copyWith =>
      __$$SmsLogListResponseImplCopyWithImpl<_$SmsLogListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsLogListResponseImplToJson(
      this,
    );
  }
}

abstract class _SmsLogListResponse implements SmsLogListResponse {
  const factory _SmsLogListResponse(
      {required final List<SmsLog> data,
      required final int currentPage,
      required final int perPage,
      required final int total,
      required final int lastPage}) = _$SmsLogListResponseImpl;

  factory _SmsLogListResponse.fromJson(Map<String, dynamic> json) =
      _$SmsLogListResponseImpl.fromJson;

  @override
  List<SmsLog> get data;
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
  _$$SmsLogListResponseImplCopyWith<_$SmsLogListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
