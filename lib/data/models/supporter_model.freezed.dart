// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supporter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupporterModel _$SupporterModelFromJson(Map<String, dynamic> json) {
  return _SupporterModel.fromJson(json);
}

/// @nodoc
mixin _$SupporterModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'surname')
  String get surname => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'telephone')
  String? get telephone => throw _privateConstructorUsedError;
  @JsonKey(name: 'picture')
  String? get picture => throw _privateConstructorUsedError;
  @JsonKey(name: 'supporter_id')
  String? get supporterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int? get municipalityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality')
  String? get municipality => throw _privateConstructorUsedError;
  @JsonKey(name: 'ward')
  String? get ward => throw _privateConstructorUsedError;
  @JsonKey(name: 'registered_voter')
  String? get registeredVoter => throw _privateConstructorUsedError;
  @JsonKey(name: 'voter')
  String? get voter => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_vote')
  String? get specialVote => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupporterModelCopyWith<SupporterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupporterModelCopyWith<$Res> {
  factory $SupporterModelCopyWith(
          SupporterModel value, $Res Function(SupporterModel) then) =
      _$SupporterModelCopyWithImpl<$Res, SupporterModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
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
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$SupporterModelCopyWithImpl<$Res, $Val extends SupporterModel>
    implements $SupporterModelCopyWith<$Res> {
  _$SupporterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? email = freezed,
    Object? telephone = freezed,
    Object? picture = freezed,
    Object? supporterId = freezed,
    Object? municipalityId = freezed,
    Object? municipality = freezed,
    Object? ward = freezed,
    Object? registeredVoter = freezed,
    Object? voter = freezed,
    Object? specialVote = freezed,
    Object? status = freezed,
    Object? address = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      telephone: freezed == telephone
          ? _value.telephone
          : telephone // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      supporterId: freezed == supporterId
          ? _value.supporterId
          : supporterId // ignore: cast_nullable_to_non_nullable
              as String?,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      registeredVoter: freezed == registeredVoter
          ? _value.registeredVoter
          : registeredVoter // ignore: cast_nullable_to_non_nullable
              as String?,
      voter: freezed == voter
          ? _value.voter
          : voter // ignore: cast_nullable_to_non_nullable
              as String?,
      specialVote: freezed == specialVote
          ? _value.specialVote
          : specialVote // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupporterModelImplCopyWith<$Res>
    implements $SupporterModelCopyWith<$Res> {
  factory _$$SupporterModelImplCopyWith(_$SupporterModelImpl value,
          $Res Function(_$SupporterModelImpl) then) =
      __$$SupporterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
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
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$SupporterModelImplCopyWithImpl<$Res>
    extends _$SupporterModelCopyWithImpl<$Res, _$SupporterModelImpl>
    implements _$$SupporterModelImplCopyWith<$Res> {
  __$$SupporterModelImplCopyWithImpl(
      _$SupporterModelImpl _value, $Res Function(_$SupporterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? email = freezed,
    Object? telephone = freezed,
    Object? picture = freezed,
    Object? supporterId = freezed,
    Object? municipalityId = freezed,
    Object? municipality = freezed,
    Object? ward = freezed,
    Object? registeredVoter = freezed,
    Object? voter = freezed,
    Object? specialVote = freezed,
    Object? status = freezed,
    Object? address = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SupporterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      telephone: freezed == telephone
          ? _value.telephone
          : telephone // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      supporterId: freezed == supporterId
          ? _value.supporterId
          : supporterId // ignore: cast_nullable_to_non_nullable
              as String?,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      registeredVoter: freezed == registeredVoter
          ? _value.registeredVoter
          : registeredVoter // ignore: cast_nullable_to_non_nullable
              as String?,
      voter: freezed == voter
          ? _value.voter
          : voter // ignore: cast_nullable_to_non_nullable
              as String?,
      specialVote: freezed == specialVote
          ? _value.specialVote
          : specialVote // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupporterModelImpl extends _SupporterModel {
  const _$SupporterModelImpl(
      {required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'surname') required this.surname,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'telephone') this.telephone,
      @JsonKey(name: 'picture') this.picture,
      @JsonKey(name: 'supporter_id') this.supporterId,
      @JsonKey(name: 'municipality_id') this.municipalityId,
      @JsonKey(name: 'municipality') this.municipality,
      @JsonKey(name: 'ward') this.ward,
      @JsonKey(name: 'registered_voter') this.registeredVoter,
      @JsonKey(name: 'voter') this.voter,
      @JsonKey(name: 'special_vote') this.specialVote,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'address') this.address,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : super._();

  factory _$SupporterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupporterModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'surname')
  final String surname;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'telephone')
  final String? telephone;
  @override
  @JsonKey(name: 'picture')
  final String? picture;
  @override
  @JsonKey(name: 'supporter_id')
  final String? supporterId;
  @override
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;
  @override
  @JsonKey(name: 'municipality')
  final String? municipality;
  @override
  @JsonKey(name: 'ward')
  final String? ward;
  @override
  @JsonKey(name: 'registered_voter')
  final String? registeredVoter;
  @override
  @JsonKey(name: 'voter')
  final String? voter;
  @override
  @JsonKey(name: 'special_vote')
  final String? specialVote;
  @override
  @JsonKey(name: 'status')
  final String? status;
  @override
  @JsonKey(name: 'address')
  final String? address;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SupporterModel(id: $id, name: $name, surname: $surname, email: $email, telephone: $telephone, picture: $picture, supporterId: $supporterId, municipalityId: $municipalityId, municipality: $municipality, ward: $ward, registeredVoter: $registeredVoter, voter: $voter, specialVote: $specialVote, status: $status, address: $address, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupporterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.supporterId, supporterId) ||
                other.supporterId == supporterId) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.municipality, municipality) ||
                other.municipality == municipality) &&
            (identical(other.ward, ward) || other.ward == ward) &&
            (identical(other.registeredVoter, registeredVoter) ||
                other.registeredVoter == registeredVoter) &&
            (identical(other.voter, voter) || other.voter == voter) &&
            (identical(other.specialVote, specialVote) ||
                other.specialVote == specialVote) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      surname,
      email,
      telephone,
      picture,
      supporterId,
      municipalityId,
      municipality,
      ward,
      registeredVoter,
      voter,
      specialVote,
      status,
      address,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupporterModelImplCopyWith<_$SupporterModelImpl> get copyWith =>
      __$$SupporterModelImplCopyWithImpl<_$SupporterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupporterModelImplToJson(
      this,
    );
  }
}

abstract class _SupporterModel extends SupporterModel {
  const factory _SupporterModel(
          {required final int id,
          @JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'surname') required final String surname,
          @JsonKey(name: 'email') final String? email,
          @JsonKey(name: 'telephone') final String? telephone,
          @JsonKey(name: 'picture') final String? picture,
          @JsonKey(name: 'supporter_id') final String? supporterId,
          @JsonKey(name: 'municipality_id') final int? municipalityId,
          @JsonKey(name: 'municipality') final String? municipality,
          @JsonKey(name: 'ward') final String? ward,
          @JsonKey(name: 'registered_voter') final String? registeredVoter,
          @JsonKey(name: 'voter') final String? voter,
          @JsonKey(name: 'special_vote') final String? specialVote,
          @JsonKey(name: 'status') final String? status,
          @JsonKey(name: 'address') final String? address,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$SupporterModelImpl;
  const _SupporterModel._() : super._();

  factory _SupporterModel.fromJson(Map<String, dynamic> json) =
      _$SupporterModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'surname')
  String get surname;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'telephone')
  String? get telephone;
  @override
  @JsonKey(name: 'picture')
  String? get picture;
  @override
  @JsonKey(name: 'supporter_id')
  String? get supporterId;
  @override
  @JsonKey(name: 'municipality_id')
  int? get municipalityId;
  @override
  @JsonKey(name: 'municipality')
  String? get municipality;
  @override
  @JsonKey(name: 'ward')
  String? get ward;
  @override
  @JsonKey(name: 'registered_voter')
  String? get registeredVoter;
  @override
  @JsonKey(name: 'voter')
  String? get voter;
  @override
  @JsonKey(name: 'special_vote')
  String? get specialVote;
  @override
  @JsonKey(name: 'status')
  String? get status;
  @override
  @JsonKey(name: 'address')
  String? get address;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SupporterModelImplCopyWith<_$SupporterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
