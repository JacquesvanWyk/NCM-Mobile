// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckIdNumberRequestImpl _$$CheckIdNumberRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckIdNumberRequestImpl(
      idNumber: json['id_number'] as String,
    );

Map<String, dynamic> _$$CheckIdNumberRequestImplToJson(
        _$CheckIdNumberRequestImpl instance) =>
    <String, dynamic>{
      'id_number': instance.idNumber,
    };

_$CheckIdNumberResponseImpl _$$CheckIdNumberResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckIdNumberResponseImpl(
      exists: json['exists'] as bool,
      hasAccount: json['has_account'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      member: json['member'] == null
          ? null
          : MemberData.fromJson(json['member'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CheckIdNumberResponseImplToJson(
        _$CheckIdNumberResponseImpl instance) =>
    <String, dynamic>{
      'exists': instance.exists,
      'has_account': instance.hasAccount,
      'message': instance.message,
      'error': instance.error,
      'member': instance.member,
    };

_$MemberDataImpl _$$MemberDataImplFromJson(Map<String, dynamic> json) =>
    _$MemberDataImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      surname: json['surname'] as String,
      ward: json['ward'] as String?,
      email: json['email'] as String?,
      telNumber: json['tel_number'] as String?,
    );

Map<String, dynamic> _$$MemberDataImplToJson(_$MemberDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'ward': instance.ward,
      'email': instance.email,
      'tel_number': instance.telNumber,
    };

_$RegisterMemberRequestImpl _$$RegisterMemberRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterMemberRequestImpl(
      idNumber: json['id_number'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String?,
      telNumber: json['tel_number'] as String?,
      ward: json['ward'] as String?,
      address: json['address'] as String?,
      town: json['town'] as String?,
      municipalityId: (json['municipality_id'] as num).toInt(),
      verificationMethod: json['verification_method'] as String,
    );

Map<String, dynamic> _$$RegisterMemberRequestImplToJson(
        _$RegisterMemberRequestImpl instance) =>
    <String, dynamic>{
      'id_number': instance.idNumber,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'tel_number': instance.telNumber,
      'ward': instance.ward,
      'address': instance.address,
      'town': instance.town,
      'municipality_id': instance.municipalityId,
      'verification_method': instance.verificationMethod,
    };

_$RegisterMemberResponseImpl _$$RegisterMemberResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterMemberResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      verificationRequired: json['verification_required'] as bool?,
      sentTo: json['sent_to'] as String?,
      memberId: (json['member_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RegisterMemberResponseImplToJson(
        _$RegisterMemberResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'verification_required': instance.verificationRequired,
      'sent_to': instance.sentTo,
      'member_id': instance.memberId,
    };

_$VerifyRegistrationRequestImpl _$$VerifyRegistrationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyRegistrationRequestImpl(
      idNumber: json['id_number'] as String,
      code: json['code'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
    );

Map<String, dynamic> _$$VerifyRegistrationRequestImplToJson(
        _$VerifyRegistrationRequestImpl instance) =>
    <String, dynamic>{
      'id_number': instance.idNumber,
      'code': instance.code,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };

_$VerifyRegistrationResponseImpl _$$VerifyRegistrationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyRegistrationResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      member: json['member'] == null
          ? null
          : MemberData.fromJson(json['member'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$VerifyRegistrationResponseImplToJson(
        _$VerifyRegistrationResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'user': instance.user,
      'member': instance.member,
      'token': instance.token,
    };

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      userType: json['user_type'] as String,
      municipalityId: (json['municipality_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'user_type': instance.userType,
      'municipality_id': instance.municipalityId,
    };

_$ResendCodeRequestImpl _$$ResendCodeRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ResendCodeRequestImpl(
      idNumber: json['id_number'] as String,
      verificationMethod: json['verification_method'] as String,
    );

Map<String, dynamic> _$$ResendCodeRequestImplToJson(
        _$ResendCodeRequestImpl instance) =>
    <String, dynamic>{
      'id_number': instance.idNumber,
      'verification_method': instance.verificationMethod,
    };

_$ResendCodeResponseImpl _$$ResendCodeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ResendCodeResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      sentTo: json['sent_to'] as String?,
    );

Map<String, dynamic> _$$ResendCodeResponseImplToJson(
        _$ResendCodeResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'sent_to': instance.sentTo,
    };
