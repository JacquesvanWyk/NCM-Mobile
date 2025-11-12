import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_submission_request.freezed.dart';
part 'vote_submission_request.g.dart';

@freezed
class VoteSubmissionRequest with _$VoteSubmissionRequest {
  const factory VoteSubmissionRequest({
    @JsonKey(name: 'poll_option_id') required int pollOptionId,
    @JsonKey(name: 'response_data') Map<String, dynamic>? responseData,
  }) = _VoteSubmissionRequest;

  factory VoteSubmissionRequest.fromJson(Map<String, dynamic> json) =>
      _$VoteSubmissionRequestFromJson(json);
}