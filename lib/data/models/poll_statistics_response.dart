import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_statistics_response.freezed.dart';
part 'poll_statistics_response.g.dart';

@freezed
class PollStatisticsWrapper with _$PollStatisticsWrapper {
  const factory PollStatisticsWrapper({
    required PollStatisticsResponse data,
  }) = _PollStatisticsWrapper;

  factory PollStatisticsWrapper.fromJson(Map<String, dynamic> json) =>
      _$PollStatisticsWrapperFromJson(json);
}

@freezed
class PollStatisticsResponse with _$PollStatisticsResponse {
  const factory PollStatisticsResponse({
    @JsonKey(name: 'total_votes') required int totalVotes,
    @JsonKey(name: 'participation_rate') required double participationRate,
    @JsonKey(name: 'option_statistics') required List<OptionStatistic> optionStatistics,
    @JsonKey(name: 'cache_status') String? cacheStatus,
    @JsonKey(name: 'total_eligible_voters') int? totalEligibleVoters,
    @JsonKey(name: 'last_updated_at') DateTime? lastUpdatedAt,
  }) = _PollStatisticsResponse;

  factory PollStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$PollStatisticsResponseFromJson(json);
}

@freezed
class OptionStatistic with _$OptionStatistic {
  const factory OptionStatistic({
    @JsonKey(name: 'option_id') required int optionId,
    @JsonKey(name: 'option_text') required String optionText,
    @JsonKey(name: 'vote_count') required int voteCount,
    required double percentage,
    @JsonKey(name: 'is_leading') required bool isLeading,
  }) = _OptionStatistic;

  factory OptionStatistic.fromJson(Map<String, dynamic> json) =>
      _$OptionStatisticFromJson(json);
}