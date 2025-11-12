import 'package:freezed_annotation/freezed_annotation.dart';

part 'supporter_model.freezed.dart';
part 'supporter_model.g.dart';

@freezed
class SupporterModel with _$SupporterModel {
  const SupporterModel._();

  const factory SupporterModel({
    required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'surname') required String surname,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'telephone') String? telephone,
    @JsonKey(name: 'picture') String? picture,
    @JsonKey(name: 'supporter_id') String? supporterId,
    @JsonKey(name: 'municipality_id') int? municipalityId,
    @JsonKey(name: 'municipality') String? municipality,
    @JsonKey(name: 'ward') String? ward,
    @JsonKey(name: 'registered_voter') String? registeredVoter,
    @JsonKey(name: 'voter') String? voter,
    @JsonKey(name: 'special_vote') String? specialVote,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SupporterModel;

  factory SupporterModel.fromJson(Map<String, dynamic> json) =>
      _$SupporterModelFromJson(json);

  // Helper getters
  String get displayFullName => '${name} ${surname}'.trim();
  String get displayPhone => telephone ?? 'N/A';
  String get displayEmail => email ?? 'N/A';
  String get displayMunicipality => municipality ?? 'N/A';
  String get displayWard => ward ?? 'N/A';
  String get displaySupporterId => supporterId ?? 'N/A';
  bool get isRegisteredVoter => registeredVoter?.toLowerCase() == 'yes' || registeredVoter == '1' || registeredVoter == 'true';
  bool get willVote => voter?.toLowerCase() == 'yes' || voter == '1' || voter == 'true';
  bool get needsSpecialVote => specialVote?.toLowerCase() == 'yes' || specialVote == '1' || specialVote == 'true';
  bool get isApproved => status?.toLowerCase() == 'approved';
}
