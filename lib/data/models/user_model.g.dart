// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      userType: json['user_type'] as String?,
      member: json['member'] == null
          ? null
          : MemberModel.fromJson(json['member'] as Map<String, dynamic>),
      leader: json['leader'] == null
          ? null
          : LeaderModel.fromJson(json['leader'] as Map<String, dynamic>),
      municipalities: (json['municipalities'] as List<dynamic>?)
          ?.map((e) => MunicipalityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user_type': instance.userType,
      'member': instance.member,
      'leader': instance.leader,
      'municipalities': instance.municipalities,
    };

_$MemberModelImpl _$$MemberModelImplFromJson(Map<String, dynamic> json) =>
    _$MemberModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      membershipNumber: json['membership_number'] as String?,
      idNumber: json['id_number'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      picture: json['picture'] as String?,
      pictureUrl: json['picture_url'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      nationality: json['nationality'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      telNumber: json['tel_number'] as String?,
      alternativePhone: json['alternative_phone'] as String?,
      address: json['address'] as String?,
      municipality: _municipalityFromJson(json['municipality']),
      town: json['town'] as String?,
      ward: json['ward'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MemberModelImplToJson(_$MemberModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'municipality_id': instance.municipalityId,
      'membership_number': instance.membershipNumber,
      'id_number': instance.idNumber,
      'name': instance.name,
      'surname': instance.surname,
      'picture': instance.picture,
      'picture_url': instance.pictureUrl,
      'date_of_birth': instance.dateOfBirth,
      'nationality': instance.nationality,
      'gender': instance.gender,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'tel_number': instance.telNumber,
      'alternative_phone': instance.alternativePhone,
      'address': instance.address,
      'municipality': instance.municipality,
      'town': instance.town,
      'ward': instance.ward,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$LeaderModelImpl _$$LeaderModelImplFromJson(Map<String, dynamic> json) =>
    _$LeaderModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      municipalityId: (json['municipality_id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      picture: json['picture'] as String?,
      idNumber: json['id_number'] as String?,
      nationality: json['nationality'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      telNumber: json['tel_number'] as String?,
      town: json['town'] as String?,
      ward: json['ward'] as String?,
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      record: json['record'] as String?,
      criminalActivities: json['criminal_activities'] as String?,
      cv: json['cv'] as String?,
      contribution: json['contribution'] as String?,
      status: json['status'] as String? ?? 'active',
      level: json['level'] as String? ?? 'Field Worker',
      paid: const BoolConverter().fromJson(json['paid']),
      userSmsId: json['user_sms_id'] as String?,
      assignedMunicipalityId:
          (json['assigned_municipality_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$LeaderModelImplToJson(_$LeaderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'municipality_id': instance.municipalityId,
      'name': instance.name,
      'surname': instance.surname,
      'picture': instance.picture,
      'id_number': instance.idNumber,
      'nationality': instance.nationality,
      'gender': instance.gender,
      'address': instance.address,
      'tel_number': instance.telNumber,
      'town': instance.town,
      'ward': instance.ward,
      'education': instance.education,
      'record': instance.record,
      'criminal_activities': instance.criminalActivities,
      'cv': instance.cv,
      'contribution': instance.contribution,
      'status': instance.status,
      'level': instance.level,
      'paid': _$JsonConverterToJson<dynamic, bool>(
          instance.paid, const BoolConverter().toJson),
      'user_sms_id': instance.userSmsId,
      'assigned_municipality_id': instance.assignedMunicipalityId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$MunicipalityModelImpl _$$MunicipalityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MunicipalityModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      province: json['province'] as String,
      region: json['region'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactPhone: json['contact_phone'] as String?,
      website: json['website'] as String?,
      physicalAddress: json['physical_address'] as String?,
      postalAddress: json['postal_address'] as String?,
      mayorName: json['mayor_name'] as String?,
      municipalManager: json['municipal_manager'] as String?,
      isActive: const BoolConverter().fromJson(json['is_active']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MunicipalityModelImplToJson(
        _$MunicipalityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'province': instance.province,
      'region': instance.region,
      'contact_email': instance.contactEmail,
      'contact_phone': instance.contactPhone,
      'website': instance.website,
      'physical_address': instance.physicalAddress,
      'postal_address': instance.postalAddress,
      'mayor_name': instance.mayorName,
      'municipal_manager': instance.municipalManager,
      'is_active': _$JsonConverterToJson<dynamic, bool>(
          instance.isActive, const BoolConverter().toJson),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
