import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'complaint_model.freezed.dart';
part 'complaint_model.g.dart';

@freezed
class ComplaintModel with _$ComplaintModel {
  const factory ComplaintModel({
    required int id,
    @JsonKey(name: 'member_id') required int memberId,
    @JsonKey(name: 'complaint_category_id') int? complaintCategoryId,
    @JsonKey(name: 'assigned_leader_id') int? assignedLeaderId,
    @JsonKey(name: 'municipality_id') required int municipalityId,
    required String title,
    required String description,
    @Default('medium') String priority,
    @Default('submitted') String status,
    @JsonKey(name: 'location_address') String? locationAddress,
    @JsonKey(name: 'location_latitude') double? locationLatitude,
    @JsonKey(name: 'location_longitude') double? locationLongitude,
    List<String>? photos,
    List<String>? documents,
    @JsonKey(name: 'contact_method_preference') @Default('phone') String contactMethodPreference,
    @JsonKey(name: 'is_anonymous') @Default(false) bool isAnonymous,
    @JsonKey(name: 'resolved_at') DateTime? resolvedAt,
    @JsonKey(name: 'resolution_notes') String? resolutionNotes,
    @JsonKey(name: 'external_reference_number') String? externalReferenceNumber,
    @JsonKey(name: 'escalated_to_department') String? escalatedToDepartment,
    @JsonKey(name: 'response_deadline') DateTime? responseDeadline,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,

    // Relationships
    MemberModel? member,
    ComplaintCategoryModel? category,
    LeaderModel? assignedLeader,
    MunicipalityModel? municipality,
  }) = _ComplaintModel;

  factory ComplaintModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintModelFromJson(json);
}

@freezed
class ComplaintCategoryModel with _$ComplaintCategoryModel {
  const factory ComplaintCategoryModel({
    required int id,
    required String name,
    String? description,
    String? icon,
    @Default('#007bff') String color,
    String? department,
    @JsonKey(name: 'priority_level') @Default('medium') String priorityLevel,
    @JsonKey(name: 'response_time_hours') @Default(72) int responseTimeHours,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ComplaintCategoryModel;

  factory ComplaintCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintCategoryModelFromJson(json);
}

// Enums for better type safety
enum ComplaintPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum ComplaintStatus {
  @JsonValue('submitted')
  submitted,
  @JsonValue('assigned')
  assigned,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('resolved')
  resolved,
  @JsonValue('closed')
  closed,
  @JsonValue('escalated')
  escalated,
}

enum ContactMethodPreference {
  @JsonValue('phone')
  phone,
  @JsonValue('email')
  email,
  @JsonValue('sms')
  sms,
  @JsonValue('in_person')
  inPerson,
}