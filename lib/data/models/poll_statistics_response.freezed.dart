// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_statistics_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PollStatisticsWrapper _$PollStatisticsWrapperFromJson(
    Map<String, dynamic> json) {
  return _PollStatisticsWrapper.fromJson(json);
}

/// @nodoc
mixin _$PollStatisticsWrapper {
  PollStatisticsResponse get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollStatisticsWrapperCopyWith<PollStatisticsWrapper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollStatisticsWrapperCopyWith<$Res> {
  factory $PollStatisticsWrapperCopyWith(PollStatisticsWrapper value,
          $Res Function(PollStatisticsWrapper) then) =
      _$PollStatisticsWrapperCopyWithImpl<$Res, PollStatisticsWrapper>;
  @useResult
  $Res call({PollStatisticsResponse data});

  $PollStatisticsResponseCopyWith<$Res> get data;
}

/// @nodoc
class _$PollStatisticsWrapperCopyWithImpl<$Res,
        $Val extends PollStatisticsWrapper>
    implements $PollStatisticsWrapperCopyWith<$Res> {
  _$PollStatisticsWrapperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PollStatisticsResponse,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PollStatisticsResponseCopyWith<$Res> get data {
    return $PollStatisticsResponseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PollStatisticsWrapperImplCopyWith<$Res>
    implements $PollStatisticsWrapperCopyWith<$Res> {
  factory _$$PollStatisticsWrapperImplCopyWith(
          _$PollStatisticsWrapperImpl value,
          $Res Function(_$PollStatisticsWrapperImpl) then) =
      __$$PollStatisticsWrapperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PollStatisticsResponse data});

  @override
  $PollStatisticsResponseCopyWith<$Res> get data;
}

/// @nodoc
class __$$PollStatisticsWrapperImplCopyWithImpl<$Res>
    extends _$PollStatisticsWrapperCopyWithImpl<$Res,
        _$PollStatisticsWrapperImpl>
    implements _$$PollStatisticsWrapperImplCopyWith<$Res> {
  __$$PollStatisticsWrapperImplCopyWithImpl(_$PollStatisticsWrapperImpl _value,
      $Res Function(_$PollStatisticsWrapperImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$PollStatisticsWrapperImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PollStatisticsResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollStatisticsWrapperImpl implements _PollStatisticsWrapper {
  const _$PollStatisticsWrapperImpl({required this.data});

  factory _$PollStatisticsWrapperImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollStatisticsWrapperImplFromJson(json);

  @override
  final PollStatisticsResponse data;

  @override
  String toString() {
    return 'PollStatisticsWrapper(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollStatisticsWrapperImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollStatisticsWrapperImplCopyWith<_$PollStatisticsWrapperImpl>
      get copyWith => __$$PollStatisticsWrapperImplCopyWithImpl<
          _$PollStatisticsWrapperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollStatisticsWrapperImplToJson(
      this,
    );
  }
}

abstract class _PollStatisticsWrapper implements PollStatisticsWrapper {
  const factory _PollStatisticsWrapper(
          {required final PollStatisticsResponse data}) =
      _$PollStatisticsWrapperImpl;

  factory _PollStatisticsWrapper.fromJson(Map<String, dynamic> json) =
      _$PollStatisticsWrapperImpl.fromJson;

  @override
  PollStatisticsResponse get data;
  @override
  @JsonKey(ignore: true)
  _$$PollStatisticsWrapperImplCopyWith<_$PollStatisticsWrapperImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PollStatisticsResponse _$PollStatisticsResponseFromJson(
    Map<String, dynamic> json) {
  return _PollStatisticsResponse.fromJson(json);
}

/// @nodoc
mixin _$PollStatisticsResponse {
  @JsonKey(name: 'total_votes')
  int get totalVotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'participation_rate')
  double get participationRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_statistics')
  List<OptionStatistic> get optionStatistics =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'cache_status')
  String? get cacheStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_eligible_voters')
  int? get totalEligibleVoters => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_at')
  DateTime? get lastUpdatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollStatisticsResponseCopyWith<PollStatisticsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollStatisticsResponseCopyWith<$Res> {
  factory $PollStatisticsResponseCopyWith(PollStatisticsResponse value,
          $Res Function(PollStatisticsResponse) then) =
      _$PollStatisticsResponseCopyWithImpl<$Res, PollStatisticsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_votes') int totalVotes,
      @JsonKey(name: 'participation_rate') double participationRate,
      @JsonKey(name: 'option_statistics')
      List<OptionStatistic> optionStatistics,
      @JsonKey(name: 'cache_status') String? cacheStatus,
      @JsonKey(name: 'total_eligible_voters') int? totalEligibleVoters,
      @JsonKey(name: 'last_updated_at') DateTime? lastUpdatedAt});
}

/// @nodoc
class _$PollStatisticsResponseCopyWithImpl<$Res,
        $Val extends PollStatisticsResponse>
    implements $PollStatisticsResponseCopyWith<$Res> {
  _$PollStatisticsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVotes = null,
    Object? participationRate = null,
    Object? optionStatistics = null,
    Object? cacheStatus = freezed,
    Object? totalEligibleVoters = freezed,
    Object? lastUpdatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      totalVotes: null == totalVotes
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      participationRate: null == participationRate
          ? _value.participationRate
          : participationRate // ignore: cast_nullable_to_non_nullable
              as double,
      optionStatistics: null == optionStatistics
          ? _value.optionStatistics
          : optionStatistics // ignore: cast_nullable_to_non_nullable
              as List<OptionStatistic>,
      cacheStatus: freezed == cacheStatus
          ? _value.cacheStatus
          : cacheStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      totalEligibleVoters: freezed == totalEligibleVoters
          ? _value.totalEligibleVoters
          : totalEligibleVoters // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollStatisticsResponseImplCopyWith<$Res>
    implements $PollStatisticsResponseCopyWith<$Res> {
  factory _$$PollStatisticsResponseImplCopyWith(
          _$PollStatisticsResponseImpl value,
          $Res Function(_$PollStatisticsResponseImpl) then) =
      __$$PollStatisticsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_votes') int totalVotes,
      @JsonKey(name: 'participation_rate') double participationRate,
      @JsonKey(name: 'option_statistics')
      List<OptionStatistic> optionStatistics,
      @JsonKey(name: 'cache_status') String? cacheStatus,
      @JsonKey(name: 'total_eligible_voters') int? totalEligibleVoters,
      @JsonKey(name: 'last_updated_at') DateTime? lastUpdatedAt});
}

/// @nodoc
class __$$PollStatisticsResponseImplCopyWithImpl<$Res>
    extends _$PollStatisticsResponseCopyWithImpl<$Res,
        _$PollStatisticsResponseImpl>
    implements _$$PollStatisticsResponseImplCopyWith<$Res> {
  __$$PollStatisticsResponseImplCopyWithImpl(
      _$PollStatisticsResponseImpl _value,
      $Res Function(_$PollStatisticsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVotes = null,
    Object? participationRate = null,
    Object? optionStatistics = null,
    Object? cacheStatus = freezed,
    Object? totalEligibleVoters = freezed,
    Object? lastUpdatedAt = freezed,
  }) {
    return _then(_$PollStatisticsResponseImpl(
      totalVotes: null == totalVotes
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      participationRate: null == participationRate
          ? _value.participationRate
          : participationRate // ignore: cast_nullable_to_non_nullable
              as double,
      optionStatistics: null == optionStatistics
          ? _value._optionStatistics
          : optionStatistics // ignore: cast_nullable_to_non_nullable
              as List<OptionStatistic>,
      cacheStatus: freezed == cacheStatus
          ? _value.cacheStatus
          : cacheStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      totalEligibleVoters: freezed == totalEligibleVoters
          ? _value.totalEligibleVoters
          : totalEligibleVoters // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdatedAt: freezed == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollStatisticsResponseImpl implements _PollStatisticsResponse {
  const _$PollStatisticsResponseImpl(
      {@JsonKey(name: 'total_votes') required this.totalVotes,
      @JsonKey(name: 'participation_rate') required this.participationRate,
      @JsonKey(name: 'option_statistics')
      required final List<OptionStatistic> optionStatistics,
      @JsonKey(name: 'cache_status') this.cacheStatus,
      @JsonKey(name: 'total_eligible_voters') this.totalEligibleVoters,
      @JsonKey(name: 'last_updated_at') this.lastUpdatedAt})
      : _optionStatistics = optionStatistics;

  factory _$PollStatisticsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollStatisticsResponseImplFromJson(json);

  @override
  @JsonKey(name: 'total_votes')
  final int totalVotes;
  @override
  @JsonKey(name: 'participation_rate')
  final double participationRate;
  final List<OptionStatistic> _optionStatistics;
  @override
  @JsonKey(name: 'option_statistics')
  List<OptionStatistic> get optionStatistics {
    if (_optionStatistics is EqualUnmodifiableListView)
      return _optionStatistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionStatistics);
  }

  @override
  @JsonKey(name: 'cache_status')
  final String? cacheStatus;
  @override
  @JsonKey(name: 'total_eligible_voters')
  final int? totalEligibleVoters;
  @override
  @JsonKey(name: 'last_updated_at')
  final DateTime? lastUpdatedAt;

  @override
  String toString() {
    return 'PollStatisticsResponse(totalVotes: $totalVotes, participationRate: $participationRate, optionStatistics: $optionStatistics, cacheStatus: $cacheStatus, totalEligibleVoters: $totalEligibleVoters, lastUpdatedAt: $lastUpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollStatisticsResponseImpl &&
            (identical(other.totalVotes, totalVotes) ||
                other.totalVotes == totalVotes) &&
            (identical(other.participationRate, participationRate) ||
                other.participationRate == participationRate) &&
            const DeepCollectionEquality()
                .equals(other._optionStatistics, _optionStatistics) &&
            (identical(other.cacheStatus, cacheStatus) ||
                other.cacheStatus == cacheStatus) &&
            (identical(other.totalEligibleVoters, totalEligibleVoters) ||
                other.totalEligibleVoters == totalEligibleVoters) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalVotes,
      participationRate,
      const DeepCollectionEquality().hash(_optionStatistics),
      cacheStatus,
      totalEligibleVoters,
      lastUpdatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollStatisticsResponseImplCopyWith<_$PollStatisticsResponseImpl>
      get copyWith => __$$PollStatisticsResponseImplCopyWithImpl<
          _$PollStatisticsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollStatisticsResponseImplToJson(
      this,
    );
  }
}

abstract class _PollStatisticsResponse implements PollStatisticsResponse {
  const factory _PollStatisticsResponse(
      {@JsonKey(name: 'total_votes') required final int totalVotes,
      @JsonKey(name: 'participation_rate')
      required final double participationRate,
      @JsonKey(name: 'option_statistics')
      required final List<OptionStatistic> optionStatistics,
      @JsonKey(name: 'cache_status') final String? cacheStatus,
      @JsonKey(name: 'total_eligible_voters') final int? totalEligibleVoters,
      @JsonKey(name: 'last_updated_at')
      final DateTime? lastUpdatedAt}) = _$PollStatisticsResponseImpl;

  factory _PollStatisticsResponse.fromJson(Map<String, dynamic> json) =
      _$PollStatisticsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'total_votes')
  int get totalVotes;
  @override
  @JsonKey(name: 'participation_rate')
  double get participationRate;
  @override
  @JsonKey(name: 'option_statistics')
  List<OptionStatistic> get optionStatistics;
  @override
  @JsonKey(name: 'cache_status')
  String? get cacheStatus;
  @override
  @JsonKey(name: 'total_eligible_voters')
  int? get totalEligibleVoters;
  @override
  @JsonKey(name: 'last_updated_at')
  DateTime? get lastUpdatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PollStatisticsResponseImplCopyWith<_$PollStatisticsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OptionStatistic _$OptionStatisticFromJson(Map<String, dynamic> json) {
  return _OptionStatistic.fromJson(json);
}

/// @nodoc
mixin _$OptionStatistic {
  @JsonKey(name: 'option_id')
  int get optionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_text')
  String get optionText => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_leading')
  bool get isLeading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptionStatisticCopyWith<OptionStatistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionStatisticCopyWith<$Res> {
  factory $OptionStatisticCopyWith(
          OptionStatistic value, $Res Function(OptionStatistic) then) =
      _$OptionStatisticCopyWithImpl<$Res, OptionStatistic>;
  @useResult
  $Res call(
      {@JsonKey(name: 'option_id') int optionId,
      @JsonKey(name: 'option_text') String optionText,
      @JsonKey(name: 'vote_count') int voteCount,
      double percentage,
      @JsonKey(name: 'is_leading') bool isLeading});
}

/// @nodoc
class _$OptionStatisticCopyWithImpl<$Res, $Val extends OptionStatistic>
    implements $OptionStatisticCopyWith<$Res> {
  _$OptionStatisticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optionId = null,
    Object? optionText = null,
    Object? voteCount = null,
    Object? percentage = null,
    Object? isLeading = null,
  }) {
    return _then(_value.copyWith(
      optionId: null == optionId
          ? _value.optionId
          : optionId // ignore: cast_nullable_to_non_nullable
              as int,
      optionText: null == optionText
          ? _value.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      isLeading: null == isLeading
          ? _value.isLeading
          : isLeading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptionStatisticImplCopyWith<$Res>
    implements $OptionStatisticCopyWith<$Res> {
  factory _$$OptionStatisticImplCopyWith(_$OptionStatisticImpl value,
          $Res Function(_$OptionStatisticImpl) then) =
      __$$OptionStatisticImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'option_id') int optionId,
      @JsonKey(name: 'option_text') String optionText,
      @JsonKey(name: 'vote_count') int voteCount,
      double percentage,
      @JsonKey(name: 'is_leading') bool isLeading});
}

/// @nodoc
class __$$OptionStatisticImplCopyWithImpl<$Res>
    extends _$OptionStatisticCopyWithImpl<$Res, _$OptionStatisticImpl>
    implements _$$OptionStatisticImplCopyWith<$Res> {
  __$$OptionStatisticImplCopyWithImpl(
      _$OptionStatisticImpl _value, $Res Function(_$OptionStatisticImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optionId = null,
    Object? optionText = null,
    Object? voteCount = null,
    Object? percentage = null,
    Object? isLeading = null,
  }) {
    return _then(_$OptionStatisticImpl(
      optionId: null == optionId
          ? _value.optionId
          : optionId // ignore: cast_nullable_to_non_nullable
              as int,
      optionText: null == optionText
          ? _value.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      isLeading: null == isLeading
          ? _value.isLeading
          : isLeading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionStatisticImpl implements _OptionStatistic {
  const _$OptionStatisticImpl(
      {@JsonKey(name: 'option_id') required this.optionId,
      @JsonKey(name: 'option_text') required this.optionText,
      @JsonKey(name: 'vote_count') required this.voteCount,
      required this.percentage,
      @JsonKey(name: 'is_leading') required this.isLeading});

  factory _$OptionStatisticImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionStatisticImplFromJson(json);

  @override
  @JsonKey(name: 'option_id')
  final int optionId;
  @override
  @JsonKey(name: 'option_text')
  final String optionText;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @override
  final double percentage;
  @override
  @JsonKey(name: 'is_leading')
  final bool isLeading;

  @override
  String toString() {
    return 'OptionStatistic(optionId: $optionId, optionText: $optionText, voteCount: $voteCount, percentage: $percentage, isLeading: $isLeading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionStatisticImpl &&
            (identical(other.optionId, optionId) ||
                other.optionId == optionId) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.isLeading, isLeading) ||
                other.isLeading == isLeading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, optionId, optionText, voteCount, percentage, isLeading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionStatisticImplCopyWith<_$OptionStatisticImpl> get copyWith =>
      __$$OptionStatisticImplCopyWithImpl<_$OptionStatisticImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionStatisticImplToJson(
      this,
    );
  }
}

abstract class _OptionStatistic implements OptionStatistic {
  const factory _OptionStatistic(
          {@JsonKey(name: 'option_id') required final int optionId,
          @JsonKey(name: 'option_text') required final String optionText,
          @JsonKey(name: 'vote_count') required final int voteCount,
          required final double percentage,
          @JsonKey(name: 'is_leading') required final bool isLeading}) =
      _$OptionStatisticImpl;

  factory _OptionStatistic.fromJson(Map<String, dynamic> json) =
      _$OptionStatisticImpl.fromJson;

  @override
  @JsonKey(name: 'option_id')
  int get optionId;
  @override
  @JsonKey(name: 'option_text')
  String get optionText;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  double get percentage;
  @override
  @JsonKey(name: 'is_leading')
  bool get isLeading;
  @override
  @JsonKey(ignore: true)
  _$$OptionStatisticImplCopyWith<_$OptionStatisticImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
