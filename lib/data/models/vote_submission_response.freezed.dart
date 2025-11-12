// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_submission_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoteSubmissionResponse _$VoteSubmissionResponseFromJson(
    Map<String, dynamic> json) {
  return _VoteSubmissionResponse.fromJson(json);
}

/// @nodoc
mixin _$VoteSubmissionResponse {
  String get message => throw _privateConstructorUsedError;
  VoteSubmissionData? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoteSubmissionResponseCopyWith<VoteSubmissionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteSubmissionResponseCopyWith<$Res> {
  factory $VoteSubmissionResponseCopyWith(VoteSubmissionResponse value,
          $Res Function(VoteSubmissionResponse) then) =
      _$VoteSubmissionResponseCopyWithImpl<$Res, VoteSubmissionResponse>;
  @useResult
  $Res call({String message, VoteSubmissionData? data});

  $VoteSubmissionDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$VoteSubmissionResponseCopyWithImpl<$Res,
        $Val extends VoteSubmissionResponse>
    implements $VoteSubmissionResponseCopyWith<$Res> {
  _$VoteSubmissionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as VoteSubmissionData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VoteSubmissionDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $VoteSubmissionDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VoteSubmissionResponseImplCopyWith<$Res>
    implements $VoteSubmissionResponseCopyWith<$Res> {
  factory _$$VoteSubmissionResponseImplCopyWith(
          _$VoteSubmissionResponseImpl value,
          $Res Function(_$VoteSubmissionResponseImpl) then) =
      __$$VoteSubmissionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, VoteSubmissionData? data});

  @override
  $VoteSubmissionDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$VoteSubmissionResponseImplCopyWithImpl<$Res>
    extends _$VoteSubmissionResponseCopyWithImpl<$Res,
        _$VoteSubmissionResponseImpl>
    implements _$$VoteSubmissionResponseImplCopyWith<$Res> {
  __$$VoteSubmissionResponseImplCopyWithImpl(
      _$VoteSubmissionResponseImpl _value,
      $Res Function(_$VoteSubmissionResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$VoteSubmissionResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as VoteSubmissionData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteSubmissionResponseImpl implements _VoteSubmissionResponse {
  const _$VoteSubmissionResponseImpl({required this.message, this.data});

  factory _$VoteSubmissionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteSubmissionResponseImplFromJson(json);

  @override
  final String message;
  @override
  final VoteSubmissionData? data;

  @override
  String toString() {
    return 'VoteSubmissionResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteSubmissionResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteSubmissionResponseImplCopyWith<_$VoteSubmissionResponseImpl>
      get copyWith => __$$VoteSubmissionResponseImplCopyWithImpl<
          _$VoteSubmissionResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteSubmissionResponseImplToJson(
      this,
    );
  }
}

abstract class _VoteSubmissionResponse implements VoteSubmissionResponse {
  const factory _VoteSubmissionResponse(
      {required final String message,
      final VoteSubmissionData? data}) = _$VoteSubmissionResponseImpl;

  factory _VoteSubmissionResponse.fromJson(Map<String, dynamic> json) =
      _$VoteSubmissionResponseImpl.fromJson;

  @override
  String get message;
  @override
  VoteSubmissionData? get data;
  @override
  @JsonKey(ignore: true)
  _$$VoteSubmissionResponseImplCopyWith<_$VoteSubmissionResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VoteSubmissionData _$VoteSubmissionDataFromJson(Map<String, dynamic> json) {
  return _VoteSubmissionData.fromJson(json);
}

/// @nodoc
mixin _$VoteSubmissionData {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'poll_id')
  int get pollId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'poll_option_id')
  int get pollOptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'submitted_at')
  String get submittedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'queue_id')
  int get queueId => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_processing_time')
  String get estimatedProcessingTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoteSubmissionDataCopyWith<VoteSubmissionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteSubmissionDataCopyWith<$Res> {
  factory $VoteSubmissionDataCopyWith(
          VoteSubmissionData value, $Res Function(VoteSubmissionData) then) =
      _$VoteSubmissionDataCopyWithImpl<$Res, VoteSubmissionData>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'poll_id') int pollId,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'poll_option_id') int pollOptionId,
      @JsonKey(name: 'submitted_at') String submittedAt,
      String status,
      @JsonKey(name: 'queue_id') int queueId,
      @JsonKey(name: 'estimated_processing_time')
      String estimatedProcessingTime});
}

/// @nodoc
class _$VoteSubmissionDataCopyWithImpl<$Res, $Val extends VoteSubmissionData>
    implements $VoteSubmissionDataCopyWith<$Res> {
  _$VoteSubmissionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pollId = null,
    Object? userId = null,
    Object? pollOptionId = null,
    Object? submittedAt = null,
    Object? status = null,
    Object? queueId = null,
    Object? estimatedProcessingTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pollId: null == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pollOptionId: null == pollOptionId
          ? _value.pollOptionId
          : pollOptionId // ignore: cast_nullable_to_non_nullable
              as int,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      queueId: null == queueId
          ? _value.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedProcessingTime: null == estimatedProcessingTime
          ? _value.estimatedProcessingTime
          : estimatedProcessingTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteSubmissionDataImplCopyWith<$Res>
    implements $VoteSubmissionDataCopyWith<$Res> {
  factory _$$VoteSubmissionDataImplCopyWith(_$VoteSubmissionDataImpl value,
          $Res Function(_$VoteSubmissionDataImpl) then) =
      __$$VoteSubmissionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'poll_id') int pollId,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'poll_option_id') int pollOptionId,
      @JsonKey(name: 'submitted_at') String submittedAt,
      String status,
      @JsonKey(name: 'queue_id') int queueId,
      @JsonKey(name: 'estimated_processing_time')
      String estimatedProcessingTime});
}

/// @nodoc
class __$$VoteSubmissionDataImplCopyWithImpl<$Res>
    extends _$VoteSubmissionDataCopyWithImpl<$Res, _$VoteSubmissionDataImpl>
    implements _$$VoteSubmissionDataImplCopyWith<$Res> {
  __$$VoteSubmissionDataImplCopyWithImpl(_$VoteSubmissionDataImpl _value,
      $Res Function(_$VoteSubmissionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pollId = null,
    Object? userId = null,
    Object? pollOptionId = null,
    Object? submittedAt = null,
    Object? status = null,
    Object? queueId = null,
    Object? estimatedProcessingTime = null,
  }) {
    return _then(_$VoteSubmissionDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pollId: null == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pollOptionId: null == pollOptionId
          ? _value.pollOptionId
          : pollOptionId // ignore: cast_nullable_to_non_nullable
              as int,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      queueId: null == queueId
          ? _value.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedProcessingTime: null == estimatedProcessingTime
          ? _value.estimatedProcessingTime
          : estimatedProcessingTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteSubmissionDataImpl implements _VoteSubmissionData {
  const _$VoteSubmissionDataImpl(
      {required this.id,
      @JsonKey(name: 'poll_id') required this.pollId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'poll_option_id') required this.pollOptionId,
      @JsonKey(name: 'submitted_at') required this.submittedAt,
      required this.status,
      @JsonKey(name: 'queue_id') required this.queueId,
      @JsonKey(name: 'estimated_processing_time')
      required this.estimatedProcessingTime});

  factory _$VoteSubmissionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteSubmissionDataImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'poll_id')
  final int pollId;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'poll_option_id')
  final int pollOptionId;
  @override
  @JsonKey(name: 'submitted_at')
  final String submittedAt;
  @override
  final String status;
  @override
  @JsonKey(name: 'queue_id')
  final int queueId;
  @override
  @JsonKey(name: 'estimated_processing_time')
  final String estimatedProcessingTime;

  @override
  String toString() {
    return 'VoteSubmissionData(id: $id, pollId: $pollId, userId: $userId, pollOptionId: $pollOptionId, submittedAt: $submittedAt, status: $status, queueId: $queueId, estimatedProcessingTime: $estimatedProcessingTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteSubmissionDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pollId, pollId) || other.pollId == pollId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pollOptionId, pollOptionId) ||
                other.pollOptionId == pollOptionId) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.queueId, queueId) || other.queueId == queueId) &&
            (identical(
                    other.estimatedProcessingTime, estimatedProcessingTime) ||
                other.estimatedProcessingTime == estimatedProcessingTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pollId, userId, pollOptionId,
      submittedAt, status, queueId, estimatedProcessingTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteSubmissionDataImplCopyWith<_$VoteSubmissionDataImpl> get copyWith =>
      __$$VoteSubmissionDataImplCopyWithImpl<_$VoteSubmissionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteSubmissionDataImplToJson(
      this,
    );
  }
}

abstract class _VoteSubmissionData implements VoteSubmissionData {
  const factory _VoteSubmissionData(
          {required final int id,
          @JsonKey(name: 'poll_id') required final int pollId,
          @JsonKey(name: 'user_id') required final int userId,
          @JsonKey(name: 'poll_option_id') required final int pollOptionId,
          @JsonKey(name: 'submitted_at') required final String submittedAt,
          required final String status,
          @JsonKey(name: 'queue_id') required final int queueId,
          @JsonKey(name: 'estimated_processing_time')
          required final String estimatedProcessingTime}) =
      _$VoteSubmissionDataImpl;

  factory _VoteSubmissionData.fromJson(Map<String, dynamic> json) =
      _$VoteSubmissionDataImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'poll_id')
  int get pollId;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'poll_option_id')
  int get pollOptionId;
  @override
  @JsonKey(name: 'submitted_at')
  String get submittedAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'queue_id')
  int get queueId;
  @override
  @JsonKey(name: 'estimated_processing_time')
  String get estimatedProcessingTime;
  @override
  @JsonKey(ignore: true)
  _$$VoteSubmissionDataImplCopyWith<_$VoteSubmissionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
