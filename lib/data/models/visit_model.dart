import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'visit_model.freezed.dart';
part 'visit_model.g.dart';

@freezed
class VisitModel with _$VisitModel {
  const factory VisitModel({
    required int id,
    @JsonKey(name: 'member_id') @Default(0) int memberId,
    @JsonKey(name: 'field_worker_id') int? fieldWorkerId,
    @JsonKey(name: 'leader_id') int? leaderId,
    @JsonKey(name: 'municipality_id') int? municipalityId,
    @JsonKey(name: 'visit_type') @Default('Door-to-Door') String visitType,
    @JsonKey(name: 'scheduled_date') DateTime? scheduledDate,
    @JsonKey(name: 'actual_date') DateTime? actualDate,
    @JsonKey(name: 'visit_date') DateTime? visitDate,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    @JsonKey(name: 'location_latitude') double? locationLatitude,
    @JsonKey(name: 'location_longitude') double? locationLongitude,
    @JsonKey(name: 'location_address') String? locationAddress,
    @JsonKey(name: 'sentiment_score') int? sentimentScore,
    @JsonKey(name: 'member_satisfaction') String? memberSatisfaction,
    @JsonKey(name: 'issues_identified') List<String>? issuesIdentified,
    @JsonKey(name: 'follow_up_required') @Default(false) bool followUpRequired,
    @JsonKey(name: 'follow_up_date') DateTime? followUpDate,
    String? summary,
    String? purpose,
    String? outcome,
    String? notes,
    @Default('scheduled') String status,
    @Default('medium') String priority,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,

    // Relationships
    MemberModel? member,
    LeaderModel? leader,
    @JsonKey(name: 'field_worker') dynamic fieldWorker,
    MunicipalityModel? municipality,
    @JsonKey(name: 'visit_notes') List<VisitNoteModel>? visitNotes,
  }) = _VisitModel;

  factory VisitModel.fromJson(Map<String, dynamic> json) =>
      _$VisitModelFromJson(json);
}

@freezed
class VisitNoteModel with _$VisitNoteModel {
  const factory VisitNoteModel({
    @Default(0) int id,
    @JsonKey(name: 'visit_id') @Default(0) int visitId,
    @JsonKey(name: 'field_worker_id') @Default(0) int fieldWorkerId,
    @JsonKey(name: 'note_type') @Default('General') String noteType,
    @Default('') String content,
    @JsonKey(name: 'is_private') @Default(false) bool isPrivate,
    List<String>? attachments,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _VisitNoteModel;

  factory VisitNoteModel.fromJson(Map<String, dynamic> json) =>
      _$VisitNoteModelFromJson(json);
}

@freezed
class VisitStatsModel with _$VisitStatsModel {
  const factory VisitStatsModel({
    @JsonKey(name: 'total_visits') required int totalVisits,
    @JsonKey(name: 'average_sentiment') double? averageSentiment,
    @JsonKey(name: 'sentiment_distribution') List<SentimentDistribution>? sentimentDistribution,
    @JsonKey(name: 'satisfaction_distribution') List<SatisfactionDistribution>? satisfactionDistribution,
  }) = _VisitStatsModel;

  factory VisitStatsModel.fromJson(Map<String, dynamic> json) =>
      _$VisitStatsModelFromJson(json);
}

@freezed
class SentimentDistribution with _$SentimentDistribution {
  const factory SentimentDistribution({
    required int total,
    @JsonKey(name: 'avg_score') required double avgScore,
    @JsonKey(name: 'sentiment_category') required String sentimentCategory,
  }) = _SentimentDistribution;

  factory SentimentDistribution.fromJson(Map<String, dynamic> json) =>
      _$SentimentDistributionFromJson(json);
}

@freezed
class SatisfactionDistribution with _$SatisfactionDistribution {
  const factory SatisfactionDistribution({
    @JsonKey(name: 'member_satisfaction') required String memberSatisfaction,
    required int count,
  }) = _SatisfactionDistribution;

  factory SatisfactionDistribution.fromJson(Map<String, dynamic> json) =>
      _$SatisfactionDistributionFromJson(json);
}