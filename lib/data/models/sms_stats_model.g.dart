// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsStatsImpl _$$SmsStatsImplFromJson(Map<String, dynamic> json) =>
    _$SmsStatsImpl(
      total: (json['total'] as num).toInt(),
      sent: (json['sent'] as num).toInt(),
      delivered: (json['delivered'] as num).toInt(),
      pending: (json['pending'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
      deliveryRate: (json['deliveryRate'] as num).toDouble(),
      today: SmsPeriodStats.fromJson(json['today'] as Map<String, dynamic>),
      thisWeek:
          SmsPeriodStats.fromJson(json['thisWeek'] as Map<String, dynamic>),
      thisMonth:
          SmsPeriodStats.fromJson(json['thisMonth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SmsStatsImplToJson(_$SmsStatsImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'sent': instance.sent,
      'delivered': instance.delivered,
      'pending': instance.pending,
      'failed': instance.failed,
      'deliveryRate': instance.deliveryRate,
      'today': instance.today,
      'thisWeek': instance.thisWeek,
      'thisMonth': instance.thisMonth,
    };

_$SmsPeriodStatsImpl _$$SmsPeriodStatsImplFromJson(Map<String, dynamic> json) =>
    _$SmsPeriodStatsImpl(
      total: (json['total'] as num).toInt(),
      delivered: (json['delivered'] as num).toInt(),
    );

Map<String, dynamic> _$$SmsPeriodStatsImplToJson(
        _$SmsPeriodStatsImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'delivered': instance.delivered,
    };
