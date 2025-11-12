import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_template_model.freezed.dart';
part 'sms_template_model.g.dart';

@freezed
class SmsTemplate with _$SmsTemplate {
  const factory SmsTemplate({
    required int id,
    required String name,
    required String content,
    required List<String> placeholders,
  }) = _SmsTemplate;

  factory SmsTemplate.fromJson(Map<String, dynamic> json) =>
      _$SmsTemplateFromJson(json);
}
