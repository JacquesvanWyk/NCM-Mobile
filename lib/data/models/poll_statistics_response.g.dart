// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_statistics_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollStatisticsWrapperImpl _$$PollStatisticsWrapperImplFromJson(
        Map<String, dynamic> json) =>
    _$PollStatisticsWrapperImpl(
      data:
          PollStatisticsResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PollStatisticsWrapperImplToJson(
        _$PollStatisticsWrapperImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$PollStatisticsResponseImpl _$$PollStatisticsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PollStatisticsResponseImpl(
      totalVotes: (json['total_votes'] as num).toInt(),
      participationRate: (json['participation_rate'] as num).toDouble(),
      optionStatistics: (json['option_statistics'] as List<dynamic>)
          .map((e) => OptionStatistic.fromJson(e as Map<String, dynamic>))
          .toList(),
      cacheStatus: json['cache_status'] as String?,
      totalEligibleVoters: (json['total_eligible_voters'] as num?)?.toInt(),
      lastUpdatedAt: json['last_updated_at'] == null
          ? null
          : DateTime.parse(json['last_updated_at'] as String),
    );

Map<String, dynamic> _$$PollStatisticsResponseImplToJson(
        _$PollStatisticsResponseImpl instance) =>
    <String, dynamic>{
      'total_votes': instance.totalVotes,
      'participation_rate': instance.participationRate,
      'option_statistics': instance.optionStatistics,
      'cache_status': instance.cacheStatus,
      'total_eligible_voters': instance.totalEligibleVoters,
      'last_updated_at': instance.lastUpdatedAt?.toIso8601String(),
    };

_$OptionStatisticImpl _$$OptionStatisticImplFromJson(
        Map<String, dynamic> json) =>
    _$OptionStatisticImpl(
      optionId: (json['option_id'] as num).toInt(),
      optionText: json['option_text'] as String,
      voteCount: (json['vote_count'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      isLeading: json['is_leading'] as bool,
    );

Map<String, dynamic> _$$OptionStatisticImplToJson(
        _$OptionStatisticImpl instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'option_text': instance.optionText,
      'vote_count': instance.voteCount,
      'percentage': instance.percentage,
      'is_leading': instance.isLeading,
    };
