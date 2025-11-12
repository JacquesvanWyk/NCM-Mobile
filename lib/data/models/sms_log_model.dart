import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_log_model.freezed.dart';
part 'sms_log_model.g.dart';

@freezed
class SmsLog with _$SmsLog {
  const factory SmsLog({
    required int id,
    required String messageId,
    required String recipient,
    String? recipientName,
    required String messageContent,
    required String status,
    DateTime? sentAt,
    DateTime? deliveredAt,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SmsLog;

  factory SmsLog.fromJson(Map<String, dynamic> json) => _$SmsLogFromJson(json);
}

@freezed
class SmsLogListResponse with _$SmsLogListResponse {
  const factory SmsLogListResponse({
    required List<SmsLog> data,
    required int currentPage,
    required int perPage,
    required int total,
    required int lastPage,
  }) = _SmsLogListResponse;

  factory SmsLogListResponse.fromJson(Map<String, dynamic> json) =>
      _$SmsLogListResponseFromJson(json);
}
