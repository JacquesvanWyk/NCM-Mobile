// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_verified_at')
  DateTime? get emailVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  String? get userType => throw _privateConstructorUsedError;
  MemberModel? get member => throw _privateConstructorUsedError;
  LeaderModel? get leader => throw _privateConstructorUsedError;
  List<MunicipalityModel>? get municipalities =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String email,
      @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'user_type') String? userType,
      MemberModel? member,
      LeaderModel? leader,
      List<MunicipalityModel>? municipalities});

  $MemberModelCopyWith<$Res>? get member;
  $LeaderModelCopyWith<$Res>? get leader;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? emailVerifiedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userType = freezed,
    Object? member = freezed,
    Object? leader = freezed,
    Object? municipalities = freezed,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberModel?,
      leader: freezed == leader
          ? _value.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as LeaderModel?,
      municipalities: freezed == municipalities
          ? _value.municipalities
          : municipalities // ignore: cast_nullable_to_non_nullable
              as List<MunicipalityModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberModelCopyWith<$Res>? get member {
    if (_value.member == null) {
      return null;
    }

    return $MemberModelCopyWith<$Res>(_value.member!, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaderModelCopyWith<$Res>? get leader {
    if (_value.leader == null) {
      return null;
    }

    return $LeaderModelCopyWith<$Res>(_value.leader!, (value) {
      return _then(_value.copyWith(leader: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String email,
      @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'user_type') String? userType,
      MemberModel? member,
      LeaderModel? leader,
      List<MunicipalityModel>? municipalities});

  @override
  $MemberModelCopyWith<$Res>? get member;
  @override
  $LeaderModelCopyWith<$Res>? get leader;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? emailVerifiedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userType = freezed,
    Object? member = freezed,
    Object? leader = freezed,
    Object? municipalities = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberModel?,
      leader: freezed == leader
          ? _value.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as LeaderModel?,
      municipalities: freezed == municipalities
          ? _value._municipalities
          : municipalities // ignore: cast_nullable_to_non_nullable
              as List<MunicipalityModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.name,
      required this.email,
      @JsonKey(name: 'email_verified_at') this.emailVerifiedAt,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'user_type') this.userType,
      this.member,
      this.leader,
      final List<MunicipalityModel>? municipalities})
      : _municipalities = municipalities;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'user_type')
  final String? userType;
  @override
  final MemberModel? member;
  @override
  final LeaderModel? leader;
  final List<MunicipalityModel>? _municipalities;
  @override
  List<MunicipalityModel>? get municipalities {
    final value = _municipalities;
    if (value == null) return null;
    if (_municipalities is EqualUnmodifiableListView) return _municipalities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, userType: $userType, member: $member, leader: $leader, municipalities: $municipalities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.emailVerifiedAt, emailVerifiedAt) ||
                other.emailVerifiedAt == emailVerifiedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.leader, leader) || other.leader == leader) &&
            const DeepCollectionEquality()
                .equals(other._municipalities, _municipalities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      emailVerifiedAt,
      createdAt,
      updatedAt,
      userType,
      member,
      leader,
      const DeepCollectionEquality().hash(_municipalities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final int id,
      required final String name,
      required final String email,
      @JsonKey(name: 'email_verified_at') final DateTime? emailVerifiedAt,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'user_type') final String? userType,
      final MemberModel? member,
      final LeaderModel? leader,
      final List<MunicipalityModel>? municipalities}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'email_verified_at')
  DateTime? get emailVerifiedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'user_type')
  String? get userType;
  @override
  MemberModel? get member;
  @override
  LeaderModel? get leader;
  @override
  List<MunicipalityModel>? get municipalities;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) {
  return _MemberModel.fromJson(json);
}

/// @nodoc
mixin _$MemberModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int? get municipalityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'membership_number')
  String? get membershipNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_number')
  String? get idNumber => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  @JsonKey(name: 'picture_url')
  String? get pictureUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_of_birth')
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'tel_number')
  String? get telNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'alternative_phone')
  String? get alternativePhone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  MunicipalityModel? get municipality => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;
  String? get ward => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberModelCopyWith<MemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberModelCopyWith<$Res> {
  factory $MemberModelCopyWith(
          MemberModel value, $Res Function(MemberModel) then) =
      _$MemberModelCopyWithImpl<$Res, MemberModel>;
  @useResult
  $Res call(
      {int id,
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
      MunicipalityModel? municipality,
      String? town,
      String? ward,
      String? status,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $MunicipalityModelCopyWith<$Res>? get municipality;
}

/// @nodoc
class _$MemberModelCopyWithImpl<$Res, $Val extends MemberModel>
    implements $MemberModelCopyWith<$Res> {
  _$MemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? municipalityId = freezed,
    Object? membershipNumber = freezed,
    Object? idNumber = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? picture = freezed,
    Object? pictureUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? nationality = freezed,
    Object? gender = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? telNumber = freezed,
    Object? alternativePhone = freezed,
    Object? address = freezed,
    Object? municipality = freezed,
    Object? town = freezed,
    Object? ward = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
      membershipNumber: freezed == membershipNumber
          ? _value.membershipNumber
          : membershipNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: freezed == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      alternativePhone: freezed == alternativePhone
          ? _value.alternativePhone
          : alternativePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as MunicipalityModel?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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

  @override
  @pragma('vm:prefer-inline')
  $MunicipalityModelCopyWith<$Res>? get municipality {
    if (_value.municipality == null) {
      return null;
    }

    return $MunicipalityModelCopyWith<$Res>(_value.municipality!, (value) {
      return _then(_value.copyWith(municipality: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemberModelImplCopyWith<$Res>
    implements $MemberModelCopyWith<$Res> {
  factory _$$MemberModelImplCopyWith(
          _$MemberModelImpl value, $Res Function(_$MemberModelImpl) then) =
      __$$MemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
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
      MunicipalityModel? municipality,
      String? town,
      String? ward,
      String? status,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $MunicipalityModelCopyWith<$Res>? get municipality;
}

/// @nodoc
class __$$MemberModelImplCopyWithImpl<$Res>
    extends _$MemberModelCopyWithImpl<$Res, _$MemberModelImpl>
    implements _$$MemberModelImplCopyWith<$Res> {
  __$$MemberModelImplCopyWithImpl(
      _$MemberModelImpl _value, $Res Function(_$MemberModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? municipalityId = freezed,
    Object? membershipNumber = freezed,
    Object? idNumber = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? picture = freezed,
    Object? pictureUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? nationality = freezed,
    Object? gender = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? telNumber = freezed,
    Object? alternativePhone = freezed,
    Object? address = freezed,
    Object? municipality = freezed,
    Object? town = freezed,
    Object? ward = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MemberModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
      membershipNumber: freezed == membershipNumber
          ? _value.membershipNumber
          : membershipNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: freezed == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      alternativePhone: freezed == alternativePhone
          ? _value.alternativePhone
          : alternativePhone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as MunicipalityModel?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
class _$MemberModelImpl extends _MemberModel {
  const _$MemberModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'municipality_id') this.municipalityId,
      @JsonKey(name: 'membership_number') this.membershipNumber,
      @JsonKey(name: 'id_number') this.idNumber,
      this.name,
      this.surname,
      this.picture,
      @JsonKey(name: 'picture_url') this.pictureUrl,
      @JsonKey(name: 'date_of_birth') this.dateOfBirth,
      this.nationality,
      this.gender,
      this.email,
      @JsonKey(name: 'phone_number') this.phoneNumber,
      @JsonKey(name: 'tel_number') this.telNumber,
      @JsonKey(name: 'alternative_phone') this.alternativePhone,
      this.address,
      this.municipality,
      this.town,
      this.ward,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : super._();

  factory _$MemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;
  @override
  @JsonKey(name: 'membership_number')
  final String? membershipNumber;
  @override
  @JsonKey(name: 'id_number')
  final String? idNumber;
  @override
  final String? name;
  @override
  final String? surname;
  @override
  final String? picture;
  @override
  @JsonKey(name: 'picture_url')
  final String? pictureUrl;
  @override
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  @override
  final String? nationality;
  @override
  final String? gender;
  @override
  final String? email;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'tel_number')
  final String? telNumber;
  @override
  @JsonKey(name: 'alternative_phone')
  final String? alternativePhone;
  @override
  final String? address;
  @override
  final MunicipalityModel? municipality;
  @override
  final String? town;
  @override
  final String? ward;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MemberModel(id: $id, userId: $userId, municipalityId: $municipalityId, membershipNumber: $membershipNumber, idNumber: $idNumber, name: $name, surname: $surname, picture: $picture, pictureUrl: $pictureUrl, dateOfBirth: $dateOfBirth, nationality: $nationality, gender: $gender, email: $email, phoneNumber: $phoneNumber, telNumber: $telNumber, alternativePhone: $alternativePhone, address: $address, municipality: $municipality, town: $town, ward: $ward, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.membershipNumber, membershipNumber) ||
                other.membershipNumber == membershipNumber) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.telNumber, telNumber) ||
                other.telNumber == telNumber) &&
            (identical(other.alternativePhone, alternativePhone) ||
                other.alternativePhone == alternativePhone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.municipality, municipality) ||
                other.municipality == municipality) &&
            (identical(other.town, town) || other.town == town) &&
            (identical(other.ward, ward) || other.ward == ward) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        municipalityId,
        membershipNumber,
        idNumber,
        name,
        surname,
        picture,
        pictureUrl,
        dateOfBirth,
        nationality,
        gender,
        email,
        phoneNumber,
        telNumber,
        alternativePhone,
        address,
        municipality,
        town,
        ward,
        status,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberModelImplCopyWith<_$MemberModelImpl> get copyWith =>
      __$$MemberModelImplCopyWithImpl<_$MemberModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberModelImplToJson(
      this,
    );
  }
}

abstract class _MemberModel extends MemberModel {
  const factory _MemberModel(
          {required final int id,
          @JsonKey(name: 'user_id') final int? userId,
          @JsonKey(name: 'municipality_id') final int? municipalityId,
          @JsonKey(name: 'membership_number') final String? membershipNumber,
          @JsonKey(name: 'id_number') final String? idNumber,
          final String? name,
          final String? surname,
          final String? picture,
          @JsonKey(name: 'picture_url') final String? pictureUrl,
          @JsonKey(name: 'date_of_birth') final String? dateOfBirth,
          final String? nationality,
          final String? gender,
          final String? email,
          @JsonKey(name: 'phone_number') final String? phoneNumber,
          @JsonKey(name: 'tel_number') final String? telNumber,
          @JsonKey(name: 'alternative_phone') final String? alternativePhone,
          final String? address,
          final MunicipalityModel? municipality,
          final String? town,
          final String? ward,
          final String? status,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$MemberModelImpl;
  const _MemberModel._() : super._();

  factory _MemberModel.fromJson(Map<String, dynamic> json) =
      _$MemberModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(name: 'municipality_id')
  int? get municipalityId;
  @override
  @JsonKey(name: 'membership_number')
  String? get membershipNumber;
  @override
  @JsonKey(name: 'id_number')
  String? get idNumber;
  @override
  String? get name;
  @override
  String? get surname;
  @override
  String? get picture;
  @override
  @JsonKey(name: 'picture_url')
  String? get pictureUrl;
  @override
  @JsonKey(name: 'date_of_birth')
  String? get dateOfBirth;
  @override
  String? get nationality;
  @override
  String? get gender;
  @override
  String? get email;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(name: 'tel_number')
  String? get telNumber;
  @override
  @JsonKey(name: 'alternative_phone')
  String? get alternativePhone;
  @override
  String? get address;
  @override
  MunicipalityModel? get municipality;
  @override
  String? get town;
  @override
  String? get ward;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$MemberModelImplCopyWith<_$MemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaderModel _$LeaderModelFromJson(Map<String, dynamic> json) {
  return _LeaderModel.fromJson(json);
}

/// @nodoc
mixin _$LeaderModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int get municipalityId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_number')
  String? get idNumber => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'tel_number')
  String? get telNumber => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get municipality => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;
  String? get ward => throw _privateConstructorUsedError;
  List<String>? get education => throw _privateConstructorUsedError;
  String? get record => throw _privateConstructorUsedError;
  @JsonKey(name: 'criminal_activities')
  String? get criminalActivities => throw _privateConstructorUsedError;
  String? get cv => throw _privateConstructorUsedError;
  String? get contribution => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid')
  @BoolConverter()
  bool? get paid => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_sms_id')
  String? get userSmsId => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_municipality_id')
  int? get assignedMunicipalityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderModelCopyWith<LeaderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderModelCopyWith<$Res> {
  factory $LeaderModelCopyWith(
          LeaderModel value, $Res Function(LeaderModel) then) =
      _$LeaderModelCopyWithImpl<$Res, LeaderModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'municipality_id') int municipalityId,
      String name,
      String surname,
      String? picture,
      @JsonKey(name: 'id_number') String? idNumber,
      String? nationality,
      String? gender,
      String? address,
      @JsonKey(name: 'tel_number') String? telNumber,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? municipality,
      String? town,
      String? ward,
      List<String>? education,
      String? record,
      @JsonKey(name: 'criminal_activities') String? criminalActivities,
      String? cv,
      String? contribution,
      String status,
      String level,
      @JsonKey(name: 'paid') @BoolConverter() bool? paid,
      @JsonKey(name: 'user_sms_id') String? userSmsId,
      @JsonKey(name: 'assigned_municipality_id') int? assignedMunicipalityId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$LeaderModelCopyWithImpl<$Res, $Val extends LeaderModel>
    implements $LeaderModelCopyWith<$Res> {
  _$LeaderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? municipalityId = null,
    Object? name = null,
    Object? surname = null,
    Object? picture = freezed,
    Object? idNumber = freezed,
    Object? nationality = freezed,
    Object? gender = freezed,
    Object? address = freezed,
    Object? telNumber = freezed,
    Object? municipality = freezed,
    Object? town = freezed,
    Object? ward = freezed,
    Object? education = freezed,
    Object? record = freezed,
    Object? criminalActivities = freezed,
    Object? cv = freezed,
    Object? contribution = freezed,
    Object? status = null,
    Object? level = null,
    Object? paid = freezed,
    Object? userSmsId = freezed,
    Object? assignedMunicipalityId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      education: freezed == education
          ? _value.education
          : education // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      record: freezed == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as String?,
      criminalActivities: freezed == criminalActivities
          ? _value.criminalActivities
          : criminalActivities // ignore: cast_nullable_to_non_nullable
              as String?,
      cv: freezed == cv
          ? _value.cv
          : cv // ignore: cast_nullable_to_non_nullable
              as String?,
      contribution: freezed == contribution
          ? _value.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      paid: freezed == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as bool?,
      userSmsId: freezed == userSmsId
          ? _value.userSmsId
          : userSmsId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedMunicipalityId: freezed == assignedMunicipalityId
          ? _value.assignedMunicipalityId
          : assignedMunicipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$LeaderModelImplCopyWith<$Res>
    implements $LeaderModelCopyWith<$Res> {
  factory _$$LeaderModelImplCopyWith(
          _$LeaderModelImpl value, $Res Function(_$LeaderModelImpl) then) =
      __$$LeaderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'municipality_id') int municipalityId,
      String name,
      String surname,
      String? picture,
      @JsonKey(name: 'id_number') String? idNumber,
      String? nationality,
      String? gender,
      String? address,
      @JsonKey(name: 'tel_number') String? telNumber,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? municipality,
      String? town,
      String? ward,
      List<String>? education,
      String? record,
      @JsonKey(name: 'criminal_activities') String? criminalActivities,
      String? cv,
      String? contribution,
      String status,
      String level,
      @JsonKey(name: 'paid') @BoolConverter() bool? paid,
      @JsonKey(name: 'user_sms_id') String? userSmsId,
      @JsonKey(name: 'assigned_municipality_id') int? assignedMunicipalityId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$LeaderModelImplCopyWithImpl<$Res>
    extends _$LeaderModelCopyWithImpl<$Res, _$LeaderModelImpl>
    implements _$$LeaderModelImplCopyWith<$Res> {
  __$$LeaderModelImplCopyWithImpl(
      _$LeaderModelImpl _value, $Res Function(_$LeaderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? municipalityId = null,
    Object? name = null,
    Object? surname = null,
    Object? picture = freezed,
    Object? idNumber = freezed,
    Object? nationality = freezed,
    Object? gender = freezed,
    Object? address = freezed,
    Object? telNumber = freezed,
    Object? municipality = freezed,
    Object? town = freezed,
    Object? ward = freezed,
    Object? education = freezed,
    Object? record = freezed,
    Object? criminalActivities = freezed,
    Object? cv = freezed,
    Object? contribution = freezed,
    Object? status = null,
    Object? level = null,
    Object? paid = freezed,
    Object? userSmsId = freezed,
    Object? assignedMunicipalityId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LeaderModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      education: freezed == education
          ? _value._education
          : education // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      record: freezed == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as String?,
      criminalActivities: freezed == criminalActivities
          ? _value.criminalActivities
          : criminalActivities // ignore: cast_nullable_to_non_nullable
              as String?,
      cv: freezed == cv
          ? _value.cv
          : cv // ignore: cast_nullable_to_non_nullable
              as String?,
      contribution: freezed == contribution
          ? _value.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      paid: freezed == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as bool?,
      userSmsId: freezed == userSmsId
          ? _value.userSmsId
          : userSmsId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedMunicipalityId: freezed == assignedMunicipalityId
          ? _value.assignedMunicipalityId
          : assignedMunicipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$LeaderModelImpl implements _LeaderModel {
  const _$LeaderModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'municipality_id') required this.municipalityId,
      required this.name,
      required this.surname,
      this.picture,
      @JsonKey(name: 'id_number') this.idNumber,
      this.nationality,
      this.gender,
      this.address,
      @JsonKey(name: 'tel_number') this.telNumber,
      @JsonKey(includeFromJson: false, includeToJson: false) this.municipality,
      this.town,
      this.ward,
      final List<String>? education,
      this.record,
      @JsonKey(name: 'criminal_activities') this.criminalActivities,
      this.cv,
      this.contribution,
      required this.status,
      required this.level,
      @JsonKey(name: 'paid') @BoolConverter() this.paid,
      @JsonKey(name: 'user_sms_id') this.userSmsId,
      @JsonKey(name: 'assigned_municipality_id') this.assignedMunicipalityId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _education = education;

  factory _$LeaderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'municipality_id')
  final int municipalityId;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String? picture;
  @override
  @JsonKey(name: 'id_number')
  final String? idNumber;
  @override
  final String? nationality;
  @override
  final String? gender;
  @override
  final String? address;
  @override
  @JsonKey(name: 'tel_number')
  final String? telNumber;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? municipality;
  @override
  final String? town;
  @override
  final String? ward;
  final List<String>? _education;
  @override
  List<String>? get education {
    final value = _education;
    if (value == null) return null;
    if (_education is EqualUnmodifiableListView) return _education;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? record;
  @override
  @JsonKey(name: 'criminal_activities')
  final String? criminalActivities;
  @override
  final String? cv;
  @override
  final String? contribution;
  @override
  final String status;
  @override
  final String level;
  @override
  @JsonKey(name: 'paid')
  @BoolConverter()
  final bool? paid;
  @override
  @JsonKey(name: 'user_sms_id')
  final String? userSmsId;
  @override
  @JsonKey(name: 'assigned_municipality_id')
  final int? assignedMunicipalityId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LeaderModel(id: $id, userId: $userId, municipalityId: $municipalityId, name: $name, surname: $surname, picture: $picture, idNumber: $idNumber, nationality: $nationality, gender: $gender, address: $address, telNumber: $telNumber, municipality: $municipality, town: $town, ward: $ward, education: $education, record: $record, criminalActivities: $criminalActivities, cv: $cv, contribution: $contribution, status: $status, level: $level, paid: $paid, userSmsId: $userSmsId, assignedMunicipalityId: $assignedMunicipalityId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.telNumber, telNumber) ||
                other.telNumber == telNumber) &&
            (identical(other.municipality, municipality) ||
                other.municipality == municipality) &&
            (identical(other.town, town) || other.town == town) &&
            (identical(other.ward, ward) || other.ward == ward) &&
            const DeepCollectionEquality()
                .equals(other._education, _education) &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.criminalActivities, criminalActivities) ||
                other.criminalActivities == criminalActivities) &&
            (identical(other.cv, cv) || other.cv == cv) &&
            (identical(other.contribution, contribution) ||
                other.contribution == contribution) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.userSmsId, userSmsId) ||
                other.userSmsId == userSmsId) &&
            (identical(other.assignedMunicipalityId, assignedMunicipalityId) ||
                other.assignedMunicipalityId == assignedMunicipalityId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        municipalityId,
        name,
        surname,
        picture,
        idNumber,
        nationality,
        gender,
        address,
        telNumber,
        municipality,
        town,
        ward,
        const DeepCollectionEquality().hash(_education),
        record,
        criminalActivities,
        cv,
        contribution,
        status,
        level,
        paid,
        userSmsId,
        assignedMunicipalityId,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderModelImplCopyWith<_$LeaderModelImpl> get copyWith =>
      __$$LeaderModelImplCopyWithImpl<_$LeaderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderModelImplToJson(
      this,
    );
  }
}

abstract class _LeaderModel implements LeaderModel {
  const factory _LeaderModel(
      {required final int id,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'municipality_id') required final int municipalityId,
      required final String name,
      required final String surname,
      final String? picture,
      @JsonKey(name: 'id_number') final String? idNumber,
      final String? nationality,
      final String? gender,
      final String? address,
      @JsonKey(name: 'tel_number') final String? telNumber,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? municipality,
      final String? town,
      final String? ward,
      final List<String>? education,
      final String? record,
      @JsonKey(name: 'criminal_activities') final String? criminalActivities,
      final String? cv,
      final String? contribution,
      required final String status,
      required final String level,
      @JsonKey(name: 'paid') @BoolConverter() final bool? paid,
      @JsonKey(name: 'user_sms_id') final String? userSmsId,
      @JsonKey(name: 'assigned_municipality_id')
      final int? assignedMunicipalityId,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at')
      final DateTime? updatedAt}) = _$LeaderModelImpl;

  factory _LeaderModel.fromJson(Map<String, dynamic> json) =
      _$LeaderModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'municipality_id')
  int get municipalityId;
  @override
  String get name;
  @override
  String get surname;
  @override
  String? get picture;
  @override
  @JsonKey(name: 'id_number')
  String? get idNumber;
  @override
  String? get nationality;
  @override
  String? get gender;
  @override
  String? get address;
  @override
  @JsonKey(name: 'tel_number')
  String? get telNumber;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get municipality;
  @override
  String? get town;
  @override
  String? get ward;
  @override
  List<String>? get education;
  @override
  String? get record;
  @override
  @JsonKey(name: 'criminal_activities')
  String? get criminalActivities;
  @override
  String? get cv;
  @override
  String? get contribution;
  @override
  String get status;
  @override
  String get level;
  @override
  @JsonKey(name: 'paid')
  @BoolConverter()
  bool? get paid;
  @override
  @JsonKey(name: 'user_sms_id')
  String? get userSmsId;
  @override
  @JsonKey(name: 'assigned_municipality_id')
  int? get assignedMunicipalityId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$LeaderModelImplCopyWith<_$LeaderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MunicipalityModel _$MunicipalityModelFromJson(Map<String, dynamic> json) {
  return _MunicipalityModel.fromJson(json);
}

/// @nodoc
mixin _$MunicipalityModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code =>
      throw _privateConstructorUsedError; // Made nullable - API sends 'slug' instead
  String get province => throw _privateConstructorUsedError;
  String? get region =>
      throw _privateConstructorUsedError; // Made nullable - not always present in API
  @JsonKey(name: 'contact_email')
  String? get contactEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_phone')
  String? get contactPhone => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  @JsonKey(name: 'physical_address')
  String? get physicalAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_address')
  String? get postalAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'mayor_name')
  String? get mayorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipal_manager')
  String? get municipalManager => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  @BoolConverter()
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MunicipalityModelCopyWith<MunicipalityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MunicipalityModelCopyWith<$Res> {
  factory $MunicipalityModelCopyWith(
          MunicipalityModel value, $Res Function(MunicipalityModel) then) =
      _$MunicipalityModelCopyWithImpl<$Res, MunicipalityModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? code,
      String province,
      String? region,
      @JsonKey(name: 'contact_email') String? contactEmail,
      @JsonKey(name: 'contact_phone') String? contactPhone,
      String? website,
      @JsonKey(name: 'physical_address') String? physicalAddress,
      @JsonKey(name: 'postal_address') String? postalAddress,
      @JsonKey(name: 'mayor_name') String? mayorName,
      @JsonKey(name: 'municipal_manager') String? municipalManager,
      @JsonKey(name: 'is_active') @BoolConverter() bool? isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$MunicipalityModelCopyWithImpl<$Res, $Val extends MunicipalityModel>
    implements $MunicipalityModelCopyWith<$Res> {
  _$MunicipalityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? province = null,
    Object? region = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? website = freezed,
    Object? physicalAddress = freezed,
    Object? postalAddress = freezed,
    Object? mayorName = freezed,
    Object? municipalManager = freezed,
    Object? isActive = freezed,
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
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      province: null == province
          ? _value.province
          : province // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      physicalAddress: freezed == physicalAddress
          ? _value.physicalAddress
          : physicalAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      postalAddress: freezed == postalAddress
          ? _value.postalAddress
          : postalAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      mayorName: freezed == mayorName
          ? _value.mayorName
          : mayorName // ignore: cast_nullable_to_non_nullable
              as String?,
      municipalManager: freezed == municipalManager
          ? _value.municipalManager
          : municipalManager // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
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
abstract class _$$MunicipalityModelImplCopyWith<$Res>
    implements $MunicipalityModelCopyWith<$Res> {
  factory _$$MunicipalityModelImplCopyWith(_$MunicipalityModelImpl value,
          $Res Function(_$MunicipalityModelImpl) then) =
      __$$MunicipalityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? code,
      String province,
      String? region,
      @JsonKey(name: 'contact_email') String? contactEmail,
      @JsonKey(name: 'contact_phone') String? contactPhone,
      String? website,
      @JsonKey(name: 'physical_address') String? physicalAddress,
      @JsonKey(name: 'postal_address') String? postalAddress,
      @JsonKey(name: 'mayor_name') String? mayorName,
      @JsonKey(name: 'municipal_manager') String? municipalManager,
      @JsonKey(name: 'is_active') @BoolConverter() bool? isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$MunicipalityModelImplCopyWithImpl<$Res>
    extends _$MunicipalityModelCopyWithImpl<$Res, _$MunicipalityModelImpl>
    implements _$$MunicipalityModelImplCopyWith<$Res> {
  __$$MunicipalityModelImplCopyWithImpl(_$MunicipalityModelImpl _value,
      $Res Function(_$MunicipalityModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? province = null,
    Object? region = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? website = freezed,
    Object? physicalAddress = freezed,
    Object? postalAddress = freezed,
    Object? mayorName = freezed,
    Object? municipalManager = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MunicipalityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      province: null == province
          ? _value.province
          : province // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      physicalAddress: freezed == physicalAddress
          ? _value.physicalAddress
          : physicalAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      postalAddress: freezed == postalAddress
          ? _value.postalAddress
          : postalAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      mayorName: freezed == mayorName
          ? _value.mayorName
          : mayorName // ignore: cast_nullable_to_non_nullable
              as String?,
      municipalManager: freezed == municipalManager
          ? _value.municipalManager
          : municipalManager // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
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
class _$MunicipalityModelImpl implements _MunicipalityModel {
  const _$MunicipalityModelImpl(
      {required this.id,
      required this.name,
      this.code,
      required this.province,
      this.region,
      @JsonKey(name: 'contact_email') this.contactEmail,
      @JsonKey(name: 'contact_phone') this.contactPhone,
      this.website,
      @JsonKey(name: 'physical_address') this.physicalAddress,
      @JsonKey(name: 'postal_address') this.postalAddress,
      @JsonKey(name: 'mayor_name') this.mayorName,
      @JsonKey(name: 'municipal_manager') this.municipalManager,
      @JsonKey(name: 'is_active') @BoolConverter() this.isActive,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$MunicipalityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MunicipalityModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? code;
// Made nullable - API sends 'slug' instead
  @override
  final String province;
  @override
  final String? region;
// Made nullable - not always present in API
  @override
  @JsonKey(name: 'contact_email')
  final String? contactEmail;
  @override
  @JsonKey(name: 'contact_phone')
  final String? contactPhone;
  @override
  final String? website;
  @override
  @JsonKey(name: 'physical_address')
  final String? physicalAddress;
  @override
  @JsonKey(name: 'postal_address')
  final String? postalAddress;
  @override
  @JsonKey(name: 'mayor_name')
  final String? mayorName;
  @override
  @JsonKey(name: 'municipal_manager')
  final String? municipalManager;
  @override
  @JsonKey(name: 'is_active')
  @BoolConverter()
  final bool? isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MunicipalityModel(id: $id, name: $name, code: $code, province: $province, region: $region, contactEmail: $contactEmail, contactPhone: $contactPhone, website: $website, physicalAddress: $physicalAddress, postalAddress: $postalAddress, mayorName: $mayorName, municipalManager: $municipalManager, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MunicipalityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.province, province) ||
                other.province == province) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.physicalAddress, physicalAddress) ||
                other.physicalAddress == physicalAddress) &&
            (identical(other.postalAddress, postalAddress) ||
                other.postalAddress == postalAddress) &&
            (identical(other.mayorName, mayorName) ||
                other.mayorName == mayorName) &&
            (identical(other.municipalManager, municipalManager) ||
                other.municipalManager == municipalManager) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
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
      code,
      province,
      region,
      contactEmail,
      contactPhone,
      website,
      physicalAddress,
      postalAddress,
      mayorName,
      municipalManager,
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MunicipalityModelImplCopyWith<_$MunicipalityModelImpl> get copyWith =>
      __$$MunicipalityModelImplCopyWithImpl<_$MunicipalityModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MunicipalityModelImplToJson(
      this,
    );
  }
}

abstract class _MunicipalityModel implements MunicipalityModel {
  const factory _MunicipalityModel(
          {required final int id,
          required final String name,
          final String? code,
          required final String province,
          final String? region,
          @JsonKey(name: 'contact_email') final String? contactEmail,
          @JsonKey(name: 'contact_phone') final String? contactPhone,
          final String? website,
          @JsonKey(name: 'physical_address') final String? physicalAddress,
          @JsonKey(name: 'postal_address') final String? postalAddress,
          @JsonKey(name: 'mayor_name') final String? mayorName,
          @JsonKey(name: 'municipal_manager') final String? municipalManager,
          @JsonKey(name: 'is_active') @BoolConverter() final bool? isActive,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$MunicipalityModelImpl;

  factory _MunicipalityModel.fromJson(Map<String, dynamic> json) =
      _$MunicipalityModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get code;
  @override // Made nullable - API sends 'slug' instead
  String get province;
  @override
  String? get region;
  @override // Made nullable - not always present in API
  @JsonKey(name: 'contact_email')
  String? get contactEmail;
  @override
  @JsonKey(name: 'contact_phone')
  String? get contactPhone;
  @override
  String? get website;
  @override
  @JsonKey(name: 'physical_address')
  String? get physicalAddress;
  @override
  @JsonKey(name: 'postal_address')
  String? get postalAddress;
  @override
  @JsonKey(name: 'mayor_name')
  String? get mayorName;
  @override
  @JsonKey(name: 'municipal_manager')
  String? get municipalManager;
  @override
  @JsonKey(name: 'is_active')
  @BoolConverter()
  bool? get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$MunicipalityModelImplCopyWith<_$MunicipalityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
