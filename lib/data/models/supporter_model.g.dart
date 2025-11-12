// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supporter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupporterModelImpl _$$SupporterModelImplFromJson(Map<String, dynamic> json) =>
    _$SupporterModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String?,
      telephone: json['telephone'] as String?,
      picture: json['picture'] as String?,
      supporterId: json['supporter_id'] as String?,
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
      municipality: json['municipality'] as String?,
      ward: json['ward'] as String?,
      registeredVoter: json['registered_voter'] as String?,
      voter: json['voter'] as String?,
      specialVote: json['special_vote'] as String?,
      status: json['status'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$SupporterModelImplToJson(
        _$SupporterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'telephone': instance.telephone,
      'picture': instance.picture,
      'supporter_id': instance.supporterId,
      'municipality_id': instance.municipalityId,
      'municipality': instance.municipality,
      'ward': instance.ward,
      'registered_voter': instance.registeredVoter,
      'voter': instance.voter,
      'special_vote': instance.specialVote,
      'status': instance.status,
      'address': instance.address,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
