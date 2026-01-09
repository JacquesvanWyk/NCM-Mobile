import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_model.freezed.dart';
part 'poll_model.g.dart';

@freezed
class PollModel with _$PollModel {
  const factory PollModel({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'poll_type') String? pollType,
    required String options, // JSON string from API Platform
    required String status,
    @JsonKey(name: 'starts_at') DateTime? startsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @JsonKey(name: 'is_public') @Default(true) bool isPublic,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'has_voted', readValue: _readHasVoted) @Default(false) bool hasVoted,
    @Default([]) List<dynamic> results,
    String? municipality, // API Platform relation URL
  }) = _PollModel;

  factory PollModel.fromJson(Map<String, dynamic> json) => _$PollModelFromJson(json);
}

// Helper to handle both 'has_voted' and 'hasVoted' from API
Object? _readHasVoted(Map<dynamic, dynamic> json, String key) {
  return json['has_voted'] ?? json['hasVoted'] ?? false;
}

@freezed
class PollOptionModel with _$PollOptionModel {
  const factory PollOptionModel({
    required int id,
    required String text,
    @Default(0) int voteCount,
  }) = _PollOptionModel;

  factory PollOptionModel.fromJson(Map<String, dynamic> json) => _$PollOptionModelFromJson(json);
}

@freezed
class PollResponseRequest with _$PollResponseRequest {
  const factory PollResponseRequest({
    required Map<String, dynamic> response,
  }) = _PollResponseRequest;

  factory PollResponseRequest.fromJson(Map<String, dynamic> json) => _$PollResponseRequestFromJson(json);
}