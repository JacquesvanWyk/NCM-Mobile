// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsTemplateImpl _$$SmsTemplateImplFromJson(Map<String, dynamic> json) =>
    _$SmsTemplateImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      content: json['content'] as String,
      placeholders: (json['placeholders'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SmsTemplateImplToJson(_$SmsTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'placeholders': instance.placeholders,
    };
