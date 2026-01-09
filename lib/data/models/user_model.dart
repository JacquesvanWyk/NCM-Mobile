import 'package:freezed_annotation/freezed_annotation.dart';
import '../converters/bool_converter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'user_type') String? userType,
    MemberModel? member,
    LeaderModel? leader,
    List<MunicipalityModel>? municipalities,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class MemberModel with _$MemberModel {
  const MemberModel._();

  const factory MemberModel({
    required int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'municipality_id') int? municipalityId,
    @JsonKey(name: 'membership_number') String? membershipNumber,
    @JsonKey(name: 'id_number') String? idNumber,
    String? name,
    String? surname,
    String? picture,
    @JsonKey(name: 'picture_url') String? pictureUrl,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    String? nationality,
    String? gender,
    String? email,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'tel_number') String? telNumber,
    @JsonKey(name: 'alternative_phone') String? alternativePhone,
    String? address,
    @JsonKey(fromJson: _municipalityFromJson) MunicipalityModel? municipality,
    String? town,
    String? ward,
    String? status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  // Helper getters for backward compatibility and null safety
  String get displayFirstName => name ?? '';
  String get displayLastName => surname ?? '';
  String get displayFullName => '${displayFirstName} ${displayLastName}'.trim();
  String get displayMembershipNumber => membershipNumber ?? '';
  String get displayIdNumber => idNumber ?? '';
  String get displayPhone => phoneNumber ?? telNumber ?? '';
  String get displayAddress => address ?? '';
  String get displayMunicipality => municipality?.name ?? '';
  String get displayWard => ward ?? '';
  String get displayPicture => pictureUrl ?? picture ?? '';
  bool get isActive => status?.toLowerCase() == 'active' || status?.toLowerCase() == 'approved';
}

@freezed
class LeaderModel with _$LeaderModel {
  const factory LeaderModel({
    required int id,
    @JsonKey(name: 'user_id') @Default(0) int userId,
    @JsonKey(name: 'municipality_id') @Default(0) int municipalityId,
    @Default('') String name,
    @Default('') String surname,
    String? picture,
    @JsonKey(name: 'id_number') String? idNumber,
    String? nationality,
    String? gender,
    String? address,
    @JsonKey(name: 'tel_number') String? telNumber,
    @JsonKey(includeFromJson: false, includeToJson: false) String? municipality,
    String? town,
    String? ward,
    List<String>? education,
    String? record,
    @JsonKey(name: 'criminal_activities') String? criminalActivities,
    String? cv,
    String? contribution,
    @Default('active') String status,
    @Default('Field Worker') String level,
    @JsonKey(name: 'paid') @BoolConverter() bool? paid,
    @JsonKey(name: 'user_sms_id') String? userSmsId,
    @JsonKey(name: 'assigned_municipality_id') int? assignedMunicipalityId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _LeaderModel;

  factory LeaderModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderModelFromJson(json);
}

@freezed
class MunicipalityModel with _$MunicipalityModel {
  const factory MunicipalityModel({
    required int id,
    required String name,
    String? code,  // Made nullable - API sends 'slug' instead
    required String province,
    String? region,  // Made nullable - not always present in API
    @JsonKey(name: 'contact_email') String? contactEmail,
    @JsonKey(name: 'contact_phone') String? contactPhone,
    String? website,
    @JsonKey(name: 'physical_address') String? physicalAddress,
    @JsonKey(name: 'postal_address') String? postalAddress,
    @JsonKey(name: 'mayor_name') String? mayorName,
    @JsonKey(name: 'municipal_manager') String? municipalManager,
    @JsonKey(name: 'is_active') @BoolConverter() bool? isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _MunicipalityModel;

  factory MunicipalityModel.fromJson(Map<String, dynamic> json) =>
      _$MunicipalityModelFromJson(json);
}

/// Converts municipality field which can be either a String or a Map
MunicipalityModel? _municipalityFromJson(dynamic json) {
  if (json == null) return null;
  if (json is String) {
    // API returns municipality as a string name
    return MunicipalityModel(
      id: 0,
      name: json,
      province: '',
    );
  }
  if (json is Map<String, dynamic>) {
    return MunicipalityModel.fromJson(json);
  }
  return null;
}