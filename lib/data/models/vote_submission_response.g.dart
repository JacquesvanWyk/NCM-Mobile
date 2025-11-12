// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_submission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoteSubmissionResponseImpl _$$VoteSubmissionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VoteSubmissionResponseImpl(
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : VoteSubmissionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VoteSubmissionResponseImplToJson(
        _$VoteSubmissionResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

_$VoteSubmissionDataImpl _$$VoteSubmissionDataImplFromJson(
        Map<String, dynamic> json) =>
    _$VoteSubmissionDataImpl(
      id: (json['id'] as num).toInt(),
      pollId: (json['poll_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      pollOptionId: (json['poll_option_id'] as num).toInt(),
      submittedAt: json['submitted_at'] as String,
      status: json['status'] as String,
      queueId: (json['queue_id'] as num).toInt(),
      estimatedProcessingTime: json['estimated_processing_time'] as String,
    );

Map<String, dynamic> _$$VoteSubmissionDataImplToJson(
        _$VoteSubmissionDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poll_id': instance.pollId,
      'user_id': instance.userId,
      'poll_option_id': instance.pollOptionId,
      'submitted_at': instance.submittedAt,
      'status': instance.status,
      'queue_id': instance.queueId,
      'estimated_processing_time': instance.estimatedProcessingTime,
    };
