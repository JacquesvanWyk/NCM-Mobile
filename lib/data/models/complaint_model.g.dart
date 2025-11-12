// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplaintModelImpl _$$ComplaintModelImplFromJson(Map<String, dynamic> json) =>
    _$ComplaintModelImpl(
      id: (json['id'] as num).toInt(),
      memberId: (json['member_id'] as num).toInt(),
      complaintCategoryId: (json['complaint_category_id'] as num?)?.toInt(),
      assignedLeaderId: (json['assigned_leader_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String? ?? 'medium',
      status: json['status'] as String? ?? 'submitted',
      locationAddress: json['location_address'] as String?,
      locationLatitude: (json['location_latitude'] as num?)?.toDouble(),
      locationLongitude: (json['location_longitude'] as num?)?.toDouble(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      contactMethodPreference:
          json['contact_method_preference'] as String? ?? 'phone',
      isAnonymous: json['is_anonymous'] as bool? ?? false,
      resolvedAt: json['resolved_at'] == null
          ? null
          : DateTime.parse(json['resolved_at'] as String),
      resolutionNotes: json['resolution_notes'] as String?,
      externalReferenceNumber: json['external_reference_number'] as String?,
      escalatedToDepartment: json['escalated_to_department'] as String?,
      responseDeadline: json['response_deadline'] == null
          ? null
          : DateTime.parse(json['response_deadline'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      member: json['member'] == null
          ? null
          : MemberModel.fromJson(json['member'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : ComplaintCategoryModel.fromJson(
              json['category'] as Map<String, dynamic>),
      assignedLeader: json['assignedLeader'] == null
          ? null
          : LeaderModel.fromJson(
              json['assignedLeader'] as Map<String, dynamic>),
      municipality: json['municipality'] == null
          ? null
          : MunicipalityModel.fromJson(
              json['municipality'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ComplaintModelImplToJson(
        _$ComplaintModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'complaint_category_id': instance.complaintCategoryId,
      'assigned_leader_id': instance.assignedLeaderId,
      'municipality_id': instance.municipalityId,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'status': instance.status,
      'location_address': instance.locationAddress,
      'location_latitude': instance.locationLatitude,
      'location_longitude': instance.locationLongitude,
      'photos': instance.photos,
      'documents': instance.documents,
      'contact_method_preference': instance.contactMethodPreference,
      'is_anonymous': instance.isAnonymous,
      'resolved_at': instance.resolvedAt?.toIso8601String(),
      'resolution_notes': instance.resolutionNotes,
      'external_reference_number': instance.externalReferenceNumber,
      'escalated_to_department': instance.escalatedToDepartment,
      'response_deadline': instance.responseDeadline?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'member': instance.member,
      'category': instance.category,
      'assignedLeader': instance.assignedLeader,
      'municipality': instance.municipality,
    };

_$ComplaintCategoryModelImpl _$$ComplaintCategoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplaintCategoryModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String? ?? '#007bff',
      department: json['department'] as String?,
      priorityLevel: json['priority_level'] as String? ?? 'medium',
      responseTimeHours: (json['response_time_hours'] as num?)?.toInt() ?? 72,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ComplaintCategoryModelImplToJson(
        _$ComplaintCategoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'color': instance.color,
      'department': instance.department,
      'priority_level': instance.priorityLevel,
      'response_time_hours': instance.responseTimeHours,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
