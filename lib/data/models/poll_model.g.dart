// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollModelImpl _$$PollModelImplFromJson(Map<String, dynamic> json) =>
    _$PollModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      pollType: json['poll_type'] as String?,
      options: json['options'] as String,
      status: json['status'] as String,
      startsAt: json['starts_at'] == null
          ? null
          : DateTime.parse(json['starts_at'] as String),
      endsAt: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
      isPublic: json['is_public'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      hasVoted: _readHasVoted(json, 'has_voted') as bool? ?? false,
      results: json['results'] as List<dynamic>? ?? const [],
      municipality: json['municipality'] as String?,
    );

Map<String, dynamic> _$$PollModelImplToJson(_$PollModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'poll_type': instance.pollType,
      'options': instance.options,
      'status': instance.status,
      'starts_at': instance.startsAt?.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'is_public': instance.isPublic,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'has_voted': instance.hasVoted,
      'results': instance.results,
      'municipality': instance.municipality,
    };

_$PollOptionModelImpl _$$PollOptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PollOptionModelImpl(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      voteCount: (json['voteCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PollOptionModelImplToJson(
        _$PollOptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteCount': instance.voteCount,
    };

_$PollResponseRequestImpl _$$PollResponseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PollResponseRequestImpl(
      response: json['response'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$PollResponseRequestImplToJson(
        _$PollResponseRequestImpl instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
