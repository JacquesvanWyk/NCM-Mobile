// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_submission_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoteSubmissionRequest _$VoteSubmissionRequestFromJson(
    Map<String, dynamic> json) {
  return _VoteSubmissionRequest.fromJson(json);
}

/// @nodoc
mixin _$VoteSubmissionRequest {
  @JsonKey(name: 'poll_option_id')
  int get pollOptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_data')
  Map<String, dynamic>? get responseData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoteSubmissionRequestCopyWith<VoteSubmissionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteSubmissionRequestCopyWith<$Res> {
  factory $VoteSubmissionRequestCopyWith(VoteSubmissionRequest value,
          $Res Function(VoteSubmissionRequest) then) =
      _$VoteSubmissionRequestCopyWithImpl<$Res, VoteSubmissionRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'poll_option_id') int pollOptionId,
      @JsonKey(name: 'response_data') Map<String, dynamic>? responseData});
}

/// @nodoc
class _$VoteSubmissionRequestCopyWithImpl<$Res,
        $Val extends VoteSubmissionRequest>
    implements $VoteSubmissionRequestCopyWith<$Res> {
  _$VoteSubmissionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pollOptionId = null,
    Object? responseData = freezed,
  }) {
    return _then(_value.copyWith(
      pollOptionId: null == pollOptionId
          ? _value.pollOptionId
          : pollOptionId // ignore: cast_nullable_to_non_nullable
              as int,
      responseData: freezed == responseData
          ? _value.responseData
          : responseData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteSubmissionRequestImplCopyWith<$Res>
    implements $VoteSubmissionRequestCopyWith<$Res> {
  factory _$$VoteSubmissionRequestImplCopyWith(
          _$VoteSubmissionRequestImpl value,
          $Res Function(_$VoteSubmissionRequestImpl) then) =
      __$$VoteSubmissionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'poll_option_id') int pollOptionId,
      @JsonKey(name: 'response_data') Map<String, dynamic>? responseData});
}

/// @nodoc
class __$$VoteSubmissionRequestImplCopyWithImpl<$Res>
    extends _$VoteSubmissionRequestCopyWithImpl<$Res,
        _$VoteSubmissionRequestImpl>
    implements _$$VoteSubmissionRequestImplCopyWith<$Res> {
  __$$VoteSubmissionRequestImplCopyWithImpl(_$VoteSubmissionRequestImpl _value,
      $Res Function(_$VoteSubmissionRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pollOptionId = null,
    Object? responseData = freezed,
  }) {
    return _then(_$VoteSubmissionRequestImpl(
      pollOptionId: null == pollOptionId
          ? _value.pollOptionId
          : pollOptionId // ignore: cast_nullable_to_non_nullable
              as int,
      responseData: freezed == responseData
          ? _value._responseData
          : responseData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteSubmissionRequestImpl implements _VoteSubmissionRequest {
  const _$VoteSubmissionRequestImpl(
      {@JsonKey(name: 'poll_option_id') required this.pollOptionId,
      @JsonKey(name: 'response_data') final Map<String, dynamic>? responseData})
      : _responseData = responseData;

  factory _$VoteSubmissionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteSubmissionRequestImplFromJson(json);

  @override
  @JsonKey(name: 'poll_option_id')
  final int pollOptionId;
  final Map<String, dynamic>? _responseData;
  @override
  @JsonKey(name: 'response_data')
  Map<String, dynamic>? get responseData {
    final value = _responseData;
    if (value == null) return null;
    if (_responseData is EqualUnmodifiableMapView) return _responseData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VoteSubmissionRequest(pollOptionId: $pollOptionId, responseData: $responseData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteSubmissionRequestImpl &&
            (identical(other.pollOptionId, pollOptionId) ||
                other.pollOptionId == pollOptionId) &&
            const DeepCollectionEquality()
                .equals(other._responseData, _responseData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pollOptionId,
      const DeepCollectionEquality().hash(_responseData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteSubmissionRequestImplCopyWith<_$VoteSubmissionRequestImpl>
      get copyWith => __$$VoteSubmissionRequestImplCopyWithImpl<
          _$VoteSubmissionRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteSubmissionRequestImplToJson(
      this,
    );
  }
}

abstract class _VoteSubmissionRequest implements VoteSubmissionRequest {
  const factory _VoteSubmissionRequest(
      {@JsonKey(name: 'poll_option_id') required final int pollOptionId,
      @JsonKey(name: 'response_data')
      final Map<String, dynamic>? responseData}) = _$VoteSubmissionRequestImpl;

  factory _VoteSubmissionRequest.fromJson(Map<String, dynamic> json) =
      _$VoteSubmissionRequestImpl.fromJson;

  @override
  @JsonKey(name: 'poll_option_id')
  int get pollOptionId;
  @override
  @JsonKey(name: 'response_data')
  Map<String, dynamic>? get responseData;
  @override
  @JsonKey(ignore: true)
  _$$VoteSubmissionRequestImplCopyWith<_$VoteSubmissionRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
