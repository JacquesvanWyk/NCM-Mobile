import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_stats_model.freezed.dart';
part 'sms_stats_model.g.dart';

@freezed
class SmsStats with _$SmsStats {
  const factory SmsStats({
    required int total,
    required int sent,
    required int delivered,
    required int pending,
    required int failed,
    required double deliveryRate,
    required SmsPeriodStats today,
    required SmsPeriodStats thisWeek,
    required SmsPeriodStats thisMonth,
  }) = _SmsStats;

  factory SmsStats.fromJson(Map<String, dynamic> json) =>
      _$SmsStatsFromJson(json);
}

@freezed
class SmsPeriodStats with _$SmsPeriodStats {
  const factory SmsPeriodStats({
    required int total,
    required int delivered,
  }) = _SmsPeriodStats;

  factory SmsPeriodStats.fromJson(Map<String, dynamic> json) =>
      _$SmsPeriodStatsFromJson(json);
}
