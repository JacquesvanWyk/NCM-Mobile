import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_model.freezed.dart';
part 'poll_model.g.dart';

@freezed
class PollModel with _$PollModel {
  const factory PollModel({
    required int id,
    required String title,
    required String description,
    @JsonKey(name: 'poll_type') required String pollType,
    required String options, // JSON string from API Platform
    required String status,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    @JsonKey(name: 'is_public') required bool isPublic,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'has_voted') @Default(false) bool hasVoted,
    @Default([]) List<dynamic> results,
    String? municipality, // API Platform relation URL
  }) = _PollModel;

  factory PollModel.fromJson(Map<String, dynamic> json) => _$PollModelFromJson(json);
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