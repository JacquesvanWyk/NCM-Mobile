// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SmsStats _$SmsStatsFromJson(Map<String, dynamic> json) {
  return _SmsStats.fromJson(json);
}

/// @nodoc
mixin _$SmsStats {
  int get total => throw _privateConstructorUsedError;
  int get sent => throw _privateConstructorUsedError;
  int get delivered => throw _privateConstructorUsedError;
  int get pending => throw _privateConstructorUsedError;
  int get failed => throw _privateConstructorUsedError;
  double get deliveryRate => throw _privateConstructorUsedError;
  SmsPeriodStats get today => throw _privateConstructorUsedError;
  SmsPeriodStats get thisWeek => throw _privateConstructorUsedError;
  SmsPeriodStats get thisMonth => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmsStatsCopyWith<SmsStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsStatsCopyWith<$Res> {
  factory $SmsStatsCopyWith(SmsStats value, $Res Function(SmsStats) then) =
      _$SmsStatsCopyWithImpl<$Res, SmsStats>;
  @useResult
  $Res call(
      {int total,
      int sent,
      int delivered,
      int pending,
      int failed,
      double deliveryRate,
      SmsPeriodStats today,
      SmsPeriodStats thisWeek,
      SmsPeriodStats thisMonth});

  $SmsPeriodStatsCopyWith<$Res> get today;
  $SmsPeriodStatsCopyWith<$Res> get thisWeek;
  $SmsPeriodStatsCopyWith<$Res> get thisMonth;
}

/// @nodoc
class _$SmsStatsCopyWithImpl<$Res, $Val extends SmsStats>
    implements $SmsStatsCopyWith<$Res> {
  _$SmsStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? sent = null,
    Object? delivered = null,
    Object? pending = null,
    Object? failed = null,
    Object? deliveryRate = null,
    Object? today = null,
    Object? thisWeek = null,
    Object? thisMonth = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      delivered: null == delivered
          ? _value.delivered
          : delivered // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryRate: null == deliveryRate
          ? _value.deliveryRate
          : deliveryRate // ignore: cast_nullable_to_non_nullable
              as double,
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as SmsPeriodStats,
      thisWeek: null == thisWeek
          ? _value.thisWeek
          : thisWeek // ignore: cast_nullable_to_non_nullable
              as SmsPeriodStats,
      thisMonth: null == thisMonth
          ? _value.thisMonth
          : thisMonth // ignore: cast_nullable_to_non_nullable
              as SmsPeriodStats,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SmsPeriodStatsCopyWith<$Res> get today {
    return $SmsPeriodStatsCopyWith<$Res>(_value.today, (value) {
      return _then(_value.copyWith(today: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmsPeriodStatsCopyWith<$Res> get thisWeek {
    return $SmsPeriodStatsCopyWith<$Res>(_value.thisWeek, (value) {
      return _then(_value.copyWith(thisWeek: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmsPeriodStatsCopyWith<$Res> get thisMonth {
    return $SmsPeriodStatsCopyWith<$Res>(_value.thisMonth, (value) {
      return _then(_value.copyWith(thisMonth: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SmsStatsImplCopyWith<$Res>
    implements $SmsStatsCopyWith<$Res> {
  factory _$$SmsStatsImplCopyWith(
          _$SmsStatsImpl value, $Res Function(_$SmsStatsImpl) then) =
      __$$SmsStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      int sent,
      int delivered,
      int pending,
      int failed,
      double deliveryRate,
      SmsPeriodStats today,
      SmsPeriodStats thisWeek,
      SmsPeriodStats thisMonth});

  @override
  $SmsPeriodStatsCopyWith<$Res> get today;
  @override
  $SmsPeriodStatsCopyWith<$Res> get thisWeek;
  @override
  $SmsPeriodStatsCopyWith<$Res> get thisMonth;
}

/// @nodoc
class __$$SmsStatsImplCopyWithImpl<$Res>
    extends _$SmsStatsCopyWithImpl<$Res, _$SmsStatsImpl>
    implements _$$SmsStatsImplCopyWith<$Res> {
  __$$SmsStatsImplCopyWithImpl(
      _$SmsStatsImpl _value, $Res Function(_$SmsStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? sent = null,
    Object? delivered = null,
    Object? pending = null,
    Object? failed = null,
    Object? deliveryRate = null,
    Object? today = null,
    Object? thisWeek = null,
    Object? thisMonth = null,
  }) {
    return _then(_$SmsStatsImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      delivered: null == delivered
          ? _value.delivered
          : delivered // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryRate: null == deliveryRate
          ? _value.deliveryRate
          : deliveryRate // ignore: cast_nullable_to_non_nullable
              as double,
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as SmsPeriodStats,
      thisWeek: null == thisWeek
          ? _value.thisWeek
          : thisWeek // ignore: cast_nullable_to_non_nullable
              as SmsPeriodStats,
      thisMonth: null == thisMonth
          ? _value.thisMonth
          : thisMonth // ignore: cast_nullable_to_non_nullable
              as SmsPeriodStats,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsStatsImpl implements _SmsStats {
  const _$SmsStatsImpl(
      {required this.total,
      required this.sent,
      required this.delivered,
      required this.pending,
      required this.failed,
      required this.deliveryRate,
      required this.today,
      required this.thisWeek,
      required this.thisMonth});

  factory _$SmsStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsStatsImplFromJson(json);

  @override
  final int total;
  @override
  final int sent;
  @override
  final int delivered;
  @override
  final int pending;
  @override
  final int failed;
  @override
  final double deliveryRate;
  @override
  final SmsPeriodStats today;
  @override
  final SmsPeriodStats thisWeek;
  @override
  final SmsPeriodStats thisMonth;

  @override
  String toString() {
    return 'SmsStats(total: $total, sent: $sent, delivered: $delivered, pending: $pending, failed: $failed, deliveryRate: $deliveryRate, today: $today, thisWeek: $thisWeek, thisMonth: $thisMonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsStatsImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.delivered, delivered) ||
                other.delivered == delivered) &&
            (identical(other.pending, pending) || other.pending == pending) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.deliveryRate, deliveryRate) ||
                other.deliveryRate == deliveryRate) &&
            (identical(other.today, today) || other.today == today) &&
            (identical(other.thisWeek, thisWeek) ||
                other.thisWeek == thisWeek) &&
            (identical(other.thisMonth, thisMonth) ||
                other.thisMonth == thisMonth));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, sent, delivered, pending,
      failed, deliveryRate, today, thisWeek, thisMonth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsStatsImplCopyWith<_$SmsStatsImpl> get copyWith =>
      __$$SmsStatsImplCopyWithImpl<_$SmsStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsStatsImplToJson(
      this,
    );
  }
}

abstract class _SmsStats implements SmsStats {
  const factory _SmsStats(
      {required final int total,
      required final int sent,
      required final int delivered,
      required final int pending,
      required final int failed,
      required final double deliveryRate,
      required final SmsPeriodStats today,
      required final SmsPeriodStats thisWeek,
      required final SmsPeriodStats thisMonth}) = _$SmsStatsImpl;

  factory _SmsStats.fromJson(Map<String, dynamic> json) =
      _$SmsStatsImpl.fromJson;

  @override
  int get total;
  @override
  int get sent;
  @override
  int get delivered;
  @override
  int get pending;
  @override
  int get failed;
  @override
  double get deliveryRate;
  @override
  SmsPeriodStats get today;
  @override
  SmsPeriodStats get thisWeek;
  @override
  SmsPeriodStats get thisMonth;
  @override
  @JsonKey(ignore: true)
  _$$SmsStatsImplCopyWith<_$SmsStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmsPeriodStats _$SmsPeriodStatsFromJson(Map<String, dynamic> json) {
  return _SmsPeriodStats.fromJson(json);
}

/// @nodoc
mixin _$SmsPeriodStats {
  int get total => throw _privateConstructorUsedError;
  int get delivered => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmsPeriodStatsCopyWith<SmsPeriodStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsPeriodStatsCopyWith<$Res> {
  factory $SmsPeriodStatsCopyWith(
          SmsPeriodStats value, $Res Function(SmsPeriodStats) then) =
      _$SmsPeriodStatsCopyWithImpl<$Res, SmsPeriodStats>;
  @useResult
  $Res call({int total, int delivered});
}

/// @nodoc
class _$SmsPeriodStatsCopyWithImpl<$Res, $Val extends SmsPeriodStats>
    implements $SmsPeriodStatsCopyWith<$Res> {
  _$SmsPeriodStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? delivered = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      delivered: null == delivered
          ? _value.delivered
          : delivered // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsPeriodStatsImplCopyWith<$Res>
    implements $SmsPeriodStatsCopyWith<$Res> {
  factory _$$SmsPeriodStatsImplCopyWith(_$SmsPeriodStatsImpl value,
          $Res Function(_$SmsPeriodStatsImpl) then) =
      __$$SmsPeriodStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, int delivered});
}

/// @nodoc
class __$$SmsPeriodStatsImplCopyWithImpl<$Res>
    extends _$SmsPeriodStatsCopyWithImpl<$Res, _$SmsPeriodStatsImpl>
    implements _$$SmsPeriodStatsImplCopyWith<$Res> {
  __$$SmsPeriodStatsImplCopyWithImpl(
      _$SmsPeriodStatsImpl _value, $Res Function(_$SmsPeriodStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? delivered = null,
  }) {
    return _then(_$SmsPeriodStatsImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      delivered: null == delivered
          ? _value.delivered
          : delivered // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsPeriodStatsImpl implements _SmsPeriodStats {
  const _$SmsPeriodStatsImpl({required this.total, required this.delivered});

  factory _$SmsPeriodStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsPeriodStatsImplFromJson(json);

  @override
  final int total;
  @override
  final int delivered;

  @override
  String toString() {
    return 'SmsPeriodStats(total: $total, delivered: $delivered)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsPeriodStatsImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.delivered, delivered) ||
                other.delivered == delivered));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, delivered);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsPeriodStatsImplCopyWith<_$SmsPeriodStatsImpl> get copyWith =>
      __$$SmsPeriodStatsImplCopyWithImpl<_$SmsPeriodStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsPeriodStatsImplToJson(
      this,
    );
  }
}

abstract class _SmsPeriodStats implements SmsPeriodStats {
  const factory _SmsPeriodStats(
      {required final int total,
      required final int delivered}) = _$SmsPeriodStatsImpl;

  factory _SmsPeriodStats.fromJson(Map<String, dynamic> json) =
      _$SmsPeriodStatsImpl.fromJson;

  @override
  int get total;
  @override
  int get delivered;
  @override
  @JsonKey(ignore: true)
  _$$SmsPeriodStatsImplCopyWith<_$SmsPeriodStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
