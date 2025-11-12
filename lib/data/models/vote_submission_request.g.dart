// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_submission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoteSubmissionRequestImpl _$$VoteSubmissionRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VoteSubmissionRequestImpl(
      pollOptionId: (json['poll_option_id'] as num).toInt(),
      responseData: json['response_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$VoteSubmissionRequestImplToJson(
        _$VoteSubmissionRequestImpl instance) =>
    <String, dynamic>{
      'poll_option_id': instance.pollOptionId,
      'response_data': instance.responseData,
    };
