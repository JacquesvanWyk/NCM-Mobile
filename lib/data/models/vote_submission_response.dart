import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_submission_response.freezed.dart';
part 'vote_submission_response.g.dart';

@freezed
class VoteSubmissionResponse with _$VoteSubmissionResponse {
  const factory VoteSubmissionResponse({
    required String message,
    VoteSubmissionData? data,
  }) = _VoteSubmissionResponse;

  factory VoteSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$VoteSubmissionResponseFromJson(json);
}

@freezed
class VoteSubmissionData with _$VoteSubmissionData {
  const factory VoteSubmissionData({
    required int id,
    @JsonKey(name: 'poll_id') required int pollId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'poll_option_id') required int pollOptionId,
    @JsonKey(name: 'submitted_at') required String submittedAt,
    required String status,
    @JsonKey(name: 'queue_id') required int queueId,
    @JsonKey(name: 'estimated_processing_time') required String estimatedProcessingTime,
  }) = _VoteSubmissionData;

  factory VoteSubmissionData.fromJson(Map<String, dynamic> json) =>
      _$VoteSubmissionDataFromJson(json);
}