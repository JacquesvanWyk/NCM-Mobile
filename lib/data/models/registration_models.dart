import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_models.freezed.dart';
part 'registration_models.g.dart';

// Check ID Number Request/Response
@freezed
class CheckIdNumberRequest with _$CheckIdNumberRequest {
  const factory CheckIdNumberRequest({
    @JsonKey(name: 'id_number') required String idNumber,
  }) = _CheckIdNumberRequest;

  factory CheckIdNumberRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckIdNumberRequestFromJson(json);
}

@freezed
class CheckIdNumberResponse with _$CheckIdNumberResponse {
  const factory CheckIdNumberResponse({
    required bool exists,
    @JsonKey(name: 'has_account') bool? hasAccount,
    String? message,
    String? error,
    MemberData? member,
  }) = _CheckIdNumberResponse;

  factory CheckIdNumberResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckIdNumberResponseFromJson(json);
}

@freezed
class MemberData with _$MemberData {
  const factory MemberData({
    required int id,
    required String name,
    required String surname,
    String? ward,
    String? email,
    @JsonKey(name: 'tel_number') String? telNumber,
  }) = _MemberData;

  factory MemberData.fromJson(Map<String, dynamic> json) =>
      _$MemberDataFromJson(json);
}

// Register Member Request/Response
@freezed
class RegisterMemberRequest with _$RegisterMemberRequest {
  const factory RegisterMemberRequest({
    @JsonKey(name: 'id_number') required String idNumber,
    required String name,
    required String surname,
    String? email,
    @JsonKey(name: 'tel_number') String? telNumber,
    String? ward,
    String? address,
    String? town,
    @JsonKey(name: 'municipality_id') required int municipalityId,
    @JsonKey(name: 'verification_method') required String verificationMethod,
  }) = _RegisterMemberRequest;

  factory RegisterMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterMemberRequestFromJson(json);
}

@freezed
class RegisterMemberResponse with _$RegisterMemberResponse {
  const factory RegisterMemberResponse({
    required bool success,
    required String message,
    @JsonKey(name: 'verification_required') bool? verificationRequired,
    @JsonKey(name: 'sent_to') String? sentTo,
    @JsonKey(name: 'member_id') int? memberId,
  }) = _RegisterMemberResponse;

  factory RegisterMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterMemberResponseFromJson(json);
}

// Verify Registration Request/Response
@freezed
class VerifyRegistrationRequest with _$VerifyRegistrationRequest {
  const factory VerifyRegistrationRequest({
    @JsonKey(name: 'id_number') required String idNumber,
    required String code,
    required String password,
    @JsonKey(name: 'password_confirmation') required String passwordConfirmation,
  }) = _VerifyRegistrationRequest;

  factory VerifyRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRegistrationRequestFromJson(json);
}

@freezed
class VerifyRegistrationResponse with _$VerifyRegistrationResponse {
  const factory VerifyRegistrationResponse({
    required bool success,
    required String message,
    UserData? user,
    MemberData? member,
    String? token,
  }) = _VerifyRegistrationResponse;

  factory VerifyRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyRegistrationResponseFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    required int id,
    required String name,
    required String email,
    @JsonKey(name: 'user_type') required String userType,
    @JsonKey(name: 'municipality_id') int? municipalityId,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

// Resend Code Request/Response
@freezed
class ResendCodeRequest with _$ResendCodeRequest {
  const factory ResendCodeRequest({
    @JsonKey(name: 'id_number') required String idNumber,
    @JsonKey(name: 'verification_method') required String verificationMethod,
  }) = _ResendCodeRequest;

  factory ResendCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeRequestFromJson(json);
}

@freezed
class ResendCodeResponse with _$ResendCodeResponse {
  const factory ResendCodeResponse({
    required bool success,
    required String message,
    @JsonKey(name: 'sent_to') String? sentTo,
  }) = _ResendCodeResponse;

  factory ResendCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeResponseFromJson(json);
}
