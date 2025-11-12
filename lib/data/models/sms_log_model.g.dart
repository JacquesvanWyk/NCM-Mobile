// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsLogImpl _$$SmsLogImplFromJson(Map<String, dynamic> json) => _$SmsLogImpl(
      id: (json['id'] as num).toInt(),
      messageId: json['messageId'] as String,
      recipient: json['recipient'] as String,
      recipientName: json['recipientName'] as String?,
      messageContent: json['messageContent'] as String,
      status: json['status'] as String,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SmsLogImplToJson(_$SmsLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messageId': instance.messageId,
      'recipient': instance.recipient,
      'recipientName': instance.recipientName,
      'messageContent': instance.messageContent,
      'status': instance.status,
      'sentAt': instance.sentAt?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'errorMessage': instance.errorMessage,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$SmsLogListResponseImpl _$$SmsLogListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SmsLogListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => SmsLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: (json['currentPage'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      lastPage: (json['lastPage'] as num).toInt(),
    );

Map<String, dynamic> _$$SmsLogListResponseImplToJson(
        _$SmsLogListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'currentPage': instance.currentPage,
      'perPage': instance.perPage,
      'total': instance.total,
      'lastPage': instance.lastPage,
    };
