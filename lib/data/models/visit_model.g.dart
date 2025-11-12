// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitModelImpl _$$VisitModelImplFromJson(Map<String, dynamic> json) =>
    _$VisitModelImpl(
      id: (json['id'] as num).toInt(),
      memberId: (json['member_id'] as num).toInt(),
      fieldWorkerId: (json['field_worker_id'] as num?)?.toInt(),
      leaderId: (json['leader_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      visitType: json['visit_type'] as String,
      scheduledDate: json['scheduled_date'] == null
          ? null
          : DateTime.parse(json['scheduled_date'] as String),
      actualDate: json['actual_date'] == null
          ? null
          : DateTime.parse(json['actual_date'] as String),
      visitDate: json['visit_date'] == null
          ? null
          : DateTime.parse(json['visit_date'] as String),
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      locationLatitude: (json['location_latitude'] as num?)?.toDouble(),
      locationLongitude: (json['location_longitude'] as num?)?.toDouble(),
      locationAddress: json['location_address'] as String?,
      sentimentScore: (json['sentiment_score'] as num?)?.toInt(),
      memberSatisfaction: json['member_satisfaction'] as String?,
      issuesIdentified: (json['issues_identified'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followUpRequired: json['follow_up_required'] as bool? ?? false,
      followUpDate: json['follow_up_date'] == null
          ? null
          : DateTime.parse(json['follow_up_date'] as String),
      summary: json['summary'] as String?,
      purpose: json['purpose'] as String?,
      outcome: json['outcome'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as String? ?? 'scheduled',
      priority: json['priority'] as String? ?? 'medium',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      member: json['member'] == null
          ? null
          : MemberModel.fromJson(json['member'] as Map<String, dynamic>),
      leader: json['leader'] == null
          ? null
          : LeaderModel.fromJson(json['leader'] as Map<String, dynamic>),
      fieldWorker: json['field_worker'],
      municipality: json['municipality'] == null
          ? null
          : MunicipalityModel.fromJson(
              json['municipality'] as Map<String, dynamic>),
      visitNotes: (json['visit_notes'] as List<dynamic>?)
          ?.map((e) => VisitNoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VisitModelImplToJson(_$VisitModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'field_worker_id': instance.fieldWorkerId,
      'leader_id': instance.leaderId,
      'municipality_id': instance.municipalityId,
      'visit_type': instance.visitType,
      'scheduled_date': instance.scheduledDate?.toIso8601String(),
      'actual_date': instance.actualDate?.toIso8601String(),
      'visit_date': instance.visitDate?.toIso8601String(),
      'duration_minutes': instance.durationMinutes,
      'location_latitude': instance.locationLatitude,
      'location_longitude': instance.locationLongitude,
      'location_address': instance.locationAddress,
      'sentiment_score': instance.sentimentScore,
      'member_satisfaction': instance.memberSatisfaction,
      'issues_identified': instance.issuesIdentified,
      'follow_up_required': instance.followUpRequired,
      'follow_up_date': instance.followUpDate?.toIso8601String(),
      'summary': instance.summary,
      'purpose': instance.purpose,
      'outcome': instance.outcome,
      'notes': instance.notes,
      'status': instance.status,
      'priority': instance.priority,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'member': instance.member,
      'leader': instance.leader,
      'field_worker': instance.fieldWorker,
      'municipality': instance.municipality,
      'visit_notes': instance.visitNotes,
    };

_$VisitNoteModelImpl _$$VisitNoteModelImplFromJson(Map<String, dynamic> json) =>
    _$VisitNoteModelImpl(
      id: (json['id'] as num).toInt(),
      visitId: (json['visit_id'] as num).toInt(),
      fieldWorkerId: (json['field_worker_id'] as num).toInt(),
      noteType: json['note_type'] as String? ?? 'General',
      content: json['content'] as String,
      isPrivate: json['is_private'] as bool? ?? false,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$VisitNoteModelImplToJson(
        _$VisitNoteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visit_id': instance.visitId,
      'field_worker_id': instance.fieldWorkerId,
      'note_type': instance.noteType,
      'content': instance.content,
      'is_private': instance.isPrivate,
      'attachments': instance.attachments,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$VisitStatsModelImpl _$$VisitStatsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VisitStatsModelImpl(
      totalVisits: (json['total_visits'] as num).toInt(),
      averageSentiment: (json['average_sentiment'] as num?)?.toDouble(),
      sentimentDistribution: (json['sentiment_distribution'] as List<dynamic>?)
          ?.map(
              (e) => SentimentDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
      satisfactionDistribution:
          (json['satisfaction_distribution'] as List<dynamic>?)
              ?.map((e) =>
                  SatisfactionDistribution.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$VisitStatsModelImplToJson(
        _$VisitStatsModelImpl instance) =>
    <String, dynamic>{
      'total_visits': instance.totalVisits,
      'average_sentiment': instance.averageSentiment,
      'sentiment_distribution': instance.sentimentDistribution,
      'satisfaction_distribution': instance.satisfactionDistribution,
    };

_$SentimentDistributionImpl _$$SentimentDistributionImplFromJson(
        Map<String, dynamic> json) =>
    _$SentimentDistributionImpl(
      total: (json['total'] as num).toInt(),
      avgScore: (json['avg_score'] as num).toDouble(),
      sentimentCategory: json['sentiment_category'] as String,
    );

Map<String, dynamic> _$$SentimentDistributionImplToJson(
        _$SentimentDistributionImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'avg_score': instance.avgScore,
      'sentiment_category': instance.sentimentCategory,
    };

_$SatisfactionDistributionImpl _$$SatisfactionDistributionImplFromJson(
        Map<String, dynamic> json) =>
    _$SatisfactionDistributionImpl(
      memberSatisfaction: json['member_satisfaction'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$SatisfactionDistributionImplToJson(
        _$SatisfactionDistributionImpl instance) =>
    <String, dynamic>{
      'member_satisfaction': instance.memberSatisfaction,
      'count': instance.count,
    };
