// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckIdNumberRequest _$CheckIdNumberRequestFromJson(Map<String, dynamic> json) {
  return _CheckIdNumberRequest.fromJson(json);
}

/// @nodoc
mixin _$CheckIdNumberRequest {
  @JsonKey(name: 'id_number')
  String get idNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckIdNumberRequestCopyWith<CheckIdNumberRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckIdNumberRequestCopyWith<$Res> {
  factory $CheckIdNumberRequestCopyWith(CheckIdNumberRequest value,
          $Res Function(CheckIdNumberRequest) then) =
      _$CheckIdNumberRequestCopyWithImpl<$Res, CheckIdNumberRequest>;
  @useResult
  $Res call({@JsonKey(name: 'id_number') String idNumber});
}

/// @nodoc
class _$CheckIdNumberRequestCopyWithImpl<$Res,
        $Val extends CheckIdNumberRequest>
    implements $CheckIdNumberRequestCopyWith<$Res> {
  _$CheckIdNumberRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
  }) {
    return _then(_value.copyWith(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckIdNumberRequestImplCopyWith<$Res>
    implements $CheckIdNumberRequestCopyWith<$Res> {
  factory _$$CheckIdNumberRequestImplCopyWith(_$CheckIdNumberRequestImpl value,
          $Res Function(_$CheckIdNumberRequestImpl) then) =
      __$$CheckIdNumberRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'id_number') String idNumber});
}

/// @nodoc
class __$$CheckIdNumberRequestImplCopyWithImpl<$Res>
    extends _$CheckIdNumberRequestCopyWithImpl<$Res, _$CheckIdNumberRequestImpl>
    implements _$$CheckIdNumberRequestImplCopyWith<$Res> {
  __$$CheckIdNumberRequestImplCopyWithImpl(_$CheckIdNumberRequestImpl _value,
      $Res Function(_$CheckIdNumberRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
  }) {
    return _then(_$CheckIdNumberRequestImpl(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckIdNumberRequestImpl implements _CheckIdNumberRequest {
  const _$CheckIdNumberRequestImpl(
      {@JsonKey(name: 'id_number') required this.idNumber});

  factory _$CheckIdNumberRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckIdNumberRequestImplFromJson(json);

  @override
  @JsonKey(name: 'id_number')
  final String idNumber;

  @override
  String toString() {
    return 'CheckIdNumberRequest(idNumber: $idNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckIdNumberRequestImpl &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckIdNumberRequestImplCopyWith<_$CheckIdNumberRequestImpl>
      get copyWith =>
          __$$CheckIdNumberRequestImplCopyWithImpl<_$CheckIdNumberRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckIdNumberRequestImplToJson(
      this,
    );
  }
}

abstract class _CheckIdNumberRequest implements CheckIdNumberRequest {
  const factory _CheckIdNumberRequest(
          {@JsonKey(name: 'id_number') required final String idNumber}) =
      _$CheckIdNumberRequestImpl;

  factory _CheckIdNumberRequest.fromJson(Map<String, dynamic> json) =
      _$CheckIdNumberRequestImpl.fromJson;

  @override
  @JsonKey(name: 'id_number')
  String get idNumber;
  @override
  @JsonKey(ignore: true)
  _$$CheckIdNumberRequestImplCopyWith<_$CheckIdNumberRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CheckIdNumberResponse _$CheckIdNumberResponseFromJson(
    Map<String, dynamic> json) {
  return _CheckIdNumberResponse.fromJson(json);
}

/// @nodoc
mixin _$CheckIdNumberResponse {
  bool get exists => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_account')
  bool? get hasAccount => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  MemberData? get member => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckIdNumberResponseCopyWith<CheckIdNumberResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckIdNumberResponseCopyWith<$Res> {
  factory $CheckIdNumberResponseCopyWith(CheckIdNumberResponse value,
          $Res Function(CheckIdNumberResponse) then) =
      _$CheckIdNumberResponseCopyWithImpl<$Res, CheckIdNumberResponse>;
  @useResult
  $Res call(
      {bool exists,
      @JsonKey(name: 'has_account') bool? hasAccount,
      String? message,
      String? error,
      MemberData? member});

  $MemberDataCopyWith<$Res>? get member;
}

/// @nodoc
class _$CheckIdNumberResponseCopyWithImpl<$Res,
        $Val extends CheckIdNumberResponse>
    implements $CheckIdNumberResponseCopyWith<$Res> {
  _$CheckIdNumberResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exists = null,
    Object? hasAccount = freezed,
    Object? message = freezed,
    Object? error = freezed,
    Object? member = freezed,
  }) {
    return _then(_value.copyWith(
      exists: null == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAccount: freezed == hasAccount
          ? _value.hasAccount
          : hasAccount // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberDataCopyWith<$Res>? get member {
    if (_value.member == null) {
      return null;
    }

    return $MemberDataCopyWith<$Res>(_value.member!, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckIdNumberResponseImplCopyWith<$Res>
    implements $CheckIdNumberResponseCopyWith<$Res> {
  factory _$$CheckIdNumberResponseImplCopyWith(
          _$CheckIdNumberResponseImpl value,
          $Res Function(_$CheckIdNumberResponseImpl) then) =
      __$$CheckIdNumberResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool exists,
      @JsonKey(name: 'has_account') bool? hasAccount,
      String? message,
      String? error,
      MemberData? member});

  @override
  $MemberDataCopyWith<$Res>? get member;
}

/// @nodoc
class __$$CheckIdNumberResponseImplCopyWithImpl<$Res>
    extends _$CheckIdNumberResponseCopyWithImpl<$Res,
        _$CheckIdNumberResponseImpl>
    implements _$$CheckIdNumberResponseImplCopyWith<$Res> {
  __$$CheckIdNumberResponseImplCopyWithImpl(_$CheckIdNumberResponseImpl _value,
      $Res Function(_$CheckIdNumberResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exists = null,
    Object? hasAccount = freezed,
    Object? message = freezed,
    Object? error = freezed,
    Object? member = freezed,
  }) {
    return _then(_$CheckIdNumberResponseImpl(
      exists: null == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAccount: freezed == hasAccount
          ? _value.hasAccount
          : hasAccount // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckIdNumberResponseImpl implements _CheckIdNumberResponse {
  const _$CheckIdNumberResponseImpl(
      {required this.exists,
      @JsonKey(name: 'has_account') this.hasAccount,
      this.message,
      this.error,
      this.member});

  factory _$CheckIdNumberResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckIdNumberResponseImplFromJson(json);

  @override
  final bool exists;
  @override
  @JsonKey(name: 'has_account')
  final bool? hasAccount;
  @override
  final String? message;
  @override
  final String? error;
  @override
  final MemberData? member;

  @override
  String toString() {
    return 'CheckIdNumberResponse(exists: $exists, hasAccount: $hasAccount, message: $message, error: $error, member: $member)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckIdNumberResponseImpl &&
            (identical(other.exists, exists) || other.exists == exists) &&
            (identical(other.hasAccount, hasAccount) ||
                other.hasAccount == hasAccount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.member, member) || other.member == member));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, exists, hasAccount, message, error, member);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckIdNumberResponseImplCopyWith<_$CheckIdNumberResponseImpl>
      get copyWith => __$$CheckIdNumberResponseImplCopyWithImpl<
          _$CheckIdNumberResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckIdNumberResponseImplToJson(
      this,
    );
  }
}

abstract class _CheckIdNumberResponse implements CheckIdNumberResponse {
  const factory _CheckIdNumberResponse(
      {required final bool exists,
      @JsonKey(name: 'has_account') final bool? hasAccount,
      final String? message,
      final String? error,
      final MemberData? member}) = _$CheckIdNumberResponseImpl;

  factory _CheckIdNumberResponse.fromJson(Map<String, dynamic> json) =
      _$CheckIdNumberResponseImpl.fromJson;

  @override
  bool get exists;
  @override
  @JsonKey(name: 'has_account')
  bool? get hasAccount;
  @override
  String? get message;
  @override
  String? get error;
  @override
  MemberData? get member;
  @override
  @JsonKey(ignore: true)
  _$$CheckIdNumberResponseImplCopyWith<_$CheckIdNumberResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MemberData _$MemberDataFromJson(Map<String, dynamic> json) {
  return _MemberData.fromJson(json);
}

/// @nodoc
mixin _$MemberData {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String? get ward => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'tel_number')
  String? get telNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberDataCopyWith<MemberData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberDataCopyWith<$Res> {
  factory $MemberDataCopyWith(
          MemberData value, $Res Function(MemberData) then) =
      _$MemberDataCopyWithImpl<$Res, MemberData>;
  @useResult
  $Res call(
      {int id,
      String name,
      String surname,
      String? ward,
      String? email,
      @JsonKey(name: 'tel_number') String? telNumber});
}

/// @nodoc
class _$MemberDataCopyWithImpl<$Res, $Val extends MemberData>
    implements $MemberDataCopyWith<$Res> {
  _$MemberDataCopyWithImpl(this._value, this._then);

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
    Object? ward = freezed,
    Object? email = freezed,
    Object? telNumber = freezed,
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
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberDataImplCopyWith<$Res>
    implements $MemberDataCopyWith<$Res> {
  factory _$$MemberDataImplCopyWith(
          _$MemberDataImpl value, $Res Function(_$MemberDataImpl) then) =
      __$$MemberDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String surname,
      String? ward,
      String? email,
      @JsonKey(name: 'tel_number') String? telNumber});
}

/// @nodoc
class __$$MemberDataImplCopyWithImpl<$Res>
    extends _$MemberDataCopyWithImpl<$Res, _$MemberDataImpl>
    implements _$$MemberDataImplCopyWith<$Res> {
  __$$MemberDataImplCopyWithImpl(
      _$MemberDataImpl _value, $Res Function(_$MemberDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? ward = freezed,
    Object? email = freezed,
    Object? telNumber = freezed,
  }) {
    return _then(_$MemberDataImpl(
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
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberDataImpl implements _MemberData {
  const _$MemberDataImpl(
      {required this.id,
      required this.name,
      required this.surname,
      this.ward,
      this.email,
      @JsonKey(name: 'tel_number') this.telNumber});

  factory _$MemberDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberDataImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String? ward;
  @override
  final String? email;
  @override
  @JsonKey(name: 'tel_number')
  final String? telNumber;

  @override
  String toString() {
    return 'MemberData(id: $id, name: $name, surname: $surname, ward: $ward, email: $email, telNumber: $telNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.ward, ward) || other.ward == ward) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telNumber, telNumber) ||
                other.telNumber == telNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, surname, ward, email, telNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberDataImplCopyWith<_$MemberDataImpl> get copyWith =>
      __$$MemberDataImplCopyWithImpl<_$MemberDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberDataImplToJson(
      this,
    );
  }
}

abstract class _MemberData implements MemberData {
  const factory _MemberData(
      {required final int id,
      required final String name,
      required final String surname,
      final String? ward,
      final String? email,
      @JsonKey(name: 'tel_number') final String? telNumber}) = _$MemberDataImpl;

  factory _MemberData.fromJson(Map<String, dynamic> json) =
      _$MemberDataImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get surname;
  @override
  String? get ward;
  @override
  String? get email;
  @override
  @JsonKey(name: 'tel_number')
  String? get telNumber;
  @override
  @JsonKey(ignore: true)
  _$$MemberDataImplCopyWith<_$MemberDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterMemberRequest _$RegisterMemberRequestFromJson(
    Map<String, dynamic> json) {
  return _RegisterMemberRequest.fromJson(json);
}

/// @nodoc
mixin _$RegisterMemberRequest {
  @JsonKey(name: 'id_number')
  String get idNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'tel_number')
  String? get telNumber => throw _privateConstructorUsedError;
  String? get ward => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int get municipalityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_method')
  String get verificationMethod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterMemberRequestCopyWith<RegisterMemberRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterMemberRequestCopyWith<$Res> {
  factory $RegisterMemberRequestCopyWith(RegisterMemberRequest value,
          $Res Function(RegisterMemberRequest) then) =
      _$RegisterMemberRequestCopyWithImpl<$Res, RegisterMemberRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_number') String idNumber,
      String name,
      String surname,
      String? email,
      @JsonKey(name: 'tel_number') String? telNumber,
      String? ward,
      String? address,
      String? town,
      @JsonKey(name: 'municipality_id') int municipalityId,
      @JsonKey(name: 'verification_method') String verificationMethod});
}

/// @nodoc
class _$RegisterMemberRequestCopyWithImpl<$Res,
        $Val extends RegisterMemberRequest>
    implements $RegisterMemberRequestCopyWith<$Res> {
  _$RegisterMemberRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
    Object? name = null,
    Object? surname = null,
    Object? email = freezed,
    Object? telNumber = freezed,
    Object? ward = freezed,
    Object? address = freezed,
    Object? town = freezed,
    Object? municipalityId = null,
    Object? verificationMethod = null,
  }) {
    return _then(_value.copyWith(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterMemberRequestImplCopyWith<$Res>
    implements $RegisterMemberRequestCopyWith<$Res> {
  factory _$$RegisterMemberRequestImplCopyWith(
          _$RegisterMemberRequestImpl value,
          $Res Function(_$RegisterMemberRequestImpl) then) =
      __$$RegisterMemberRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_number') String idNumber,
      String name,
      String surname,
      String? email,
      @JsonKey(name: 'tel_number') String? telNumber,
      String? ward,
      String? address,
      String? town,
      @JsonKey(name: 'municipality_id') int municipalityId,
      @JsonKey(name: 'verification_method') String verificationMethod});
}

/// @nodoc
class __$$RegisterMemberRequestImplCopyWithImpl<$Res>
    extends _$RegisterMemberRequestCopyWithImpl<$Res,
        _$RegisterMemberRequestImpl>
    implements _$$RegisterMemberRequestImplCopyWith<$Res> {
  __$$RegisterMemberRequestImplCopyWithImpl(_$RegisterMemberRequestImpl _value,
      $Res Function(_$RegisterMemberRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
    Object? name = null,
    Object? surname = null,
    Object? email = freezed,
    Object? telNumber = freezed,
    Object? ward = freezed,
    Object? address = freezed,
    Object? town = freezed,
    Object? municipalityId = null,
    Object? verificationMethod = null,
  }) {
    return _then(_$RegisterMemberRequestImpl(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      telNumber: freezed == telNumber
          ? _value.telNumber
          : telNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ward: freezed == ward
          ? _value.ward
          : ward // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterMemberRequestImpl implements _RegisterMemberRequest {
  const _$RegisterMemberRequestImpl(
      {@JsonKey(name: 'id_number') required this.idNumber,
      required this.name,
      required this.surname,
      this.email,
      @JsonKey(name: 'tel_number') this.telNumber,
      this.ward,
      this.address,
      this.town,
      @JsonKey(name: 'municipality_id') required this.municipalityId,
      @JsonKey(name: 'verification_method') required this.verificationMethod});

  factory _$RegisterMemberRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterMemberRequestImplFromJson(json);

  @override
  @JsonKey(name: 'id_number')
  final String idNumber;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String? email;
  @override
  @JsonKey(name: 'tel_number')
  final String? telNumber;
  @override
  final String? ward;
  @override
  final String? address;
  @override
  final String? town;
  @override
  @JsonKey(name: 'municipality_id')
  final int municipalityId;
  @override
  @JsonKey(name: 'verification_method')
  final String verificationMethod;

  @override
  String toString() {
    return 'RegisterMemberRequest(idNumber: $idNumber, name: $name, surname: $surname, email: $email, telNumber: $telNumber, ward: $ward, address: $address, town: $town, municipalityId: $municipalityId, verificationMethod: $verificationMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterMemberRequestImpl &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telNumber, telNumber) ||
                other.telNumber == telNumber) &&
            (identical(other.ward, ward) || other.ward == ward) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.town, town) || other.town == town) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idNumber, name, surname, email,
      telNumber, ward, address, town, municipalityId, verificationMethod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterMemberRequestImplCopyWith<_$RegisterMemberRequestImpl>
      get copyWith => __$$RegisterMemberRequestImplCopyWithImpl<
          _$RegisterMemberRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterMemberRequestImplToJson(
      this,
    );
  }
}

abstract class _RegisterMemberRequest implements RegisterMemberRequest {
  const factory _RegisterMemberRequest(
      {@JsonKey(name: 'id_number') required final String idNumber,
      required final String name,
      required final String surname,
      final String? email,
      @JsonKey(name: 'tel_number') final String? telNumber,
      final String? ward,
      final String? address,
      final String? town,
      @JsonKey(name: 'municipality_id') required final int municipalityId,
      @JsonKey(name: 'verification_method')
      required final String verificationMethod}) = _$RegisterMemberRequestImpl;

  factory _RegisterMemberRequest.fromJson(Map<String, dynamic> json) =
      _$RegisterMemberRequestImpl.fromJson;

  @override
  @JsonKey(name: 'id_number')
  String get idNumber;
  @override
  String get name;
  @override
  String get surname;
  @override
  String? get email;
  @override
  @JsonKey(name: 'tel_number')
  String? get telNumber;
  @override
  String? get ward;
  @override
  String? get address;
  @override
  String? get town;
  @override
  @JsonKey(name: 'municipality_id')
  int get municipalityId;
  @override
  @JsonKey(name: 'verification_method')
  String get verificationMethod;
  @override
  @JsonKey(ignore: true)
  _$$RegisterMemberRequestImplCopyWith<_$RegisterMemberRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RegisterMemberResponse _$RegisterMemberResponseFromJson(
    Map<String, dynamic> json) {
  return _RegisterMemberResponse.fromJson(json);
}

/// @nodoc
mixin _$RegisterMemberResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_required')
  bool? get verificationRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_to')
  String? get sentTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  int? get memberId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterMemberResponseCopyWith<RegisterMemberResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterMemberResponseCopyWith<$Res> {
  factory $RegisterMemberResponseCopyWith(RegisterMemberResponse value,
          $Res Function(RegisterMemberResponse) then) =
      _$RegisterMemberResponseCopyWithImpl<$Res, RegisterMemberResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'verification_required') bool? verificationRequired,
      @JsonKey(name: 'sent_to') String? sentTo,
      @JsonKey(name: 'member_id') int? memberId});
}

/// @nodoc
class _$RegisterMemberResponseCopyWithImpl<$Res,
        $Val extends RegisterMemberResponse>
    implements $RegisterMemberResponseCopyWith<$Res> {
  _$RegisterMemberResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? verificationRequired = freezed,
    Object? sentTo = freezed,
    Object? memberId = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      verificationRequired: freezed == verificationRequired
          ? _value.verificationRequired
          : verificationRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      sentTo: freezed == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterMemberResponseImplCopyWith<$Res>
    implements $RegisterMemberResponseCopyWith<$Res> {
  factory _$$RegisterMemberResponseImplCopyWith(
          _$RegisterMemberResponseImpl value,
          $Res Function(_$RegisterMemberResponseImpl) then) =
      __$$RegisterMemberResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'verification_required') bool? verificationRequired,
      @JsonKey(name: 'sent_to') String? sentTo,
      @JsonKey(name: 'member_id') int? memberId});
}

/// @nodoc
class __$$RegisterMemberResponseImplCopyWithImpl<$Res>
    extends _$RegisterMemberResponseCopyWithImpl<$Res,
        _$RegisterMemberResponseImpl>
    implements _$$RegisterMemberResponseImplCopyWith<$Res> {
  __$$RegisterMemberResponseImplCopyWithImpl(
      _$RegisterMemberResponseImpl _value,
      $Res Function(_$RegisterMemberResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? verificationRequired = freezed,
    Object? sentTo = freezed,
    Object? memberId = freezed,
  }) {
    return _then(_$RegisterMemberResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      verificationRequired: freezed == verificationRequired
          ? _value.verificationRequired
          : verificationRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      sentTo: freezed == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterMemberResponseImpl implements _RegisterMemberResponse {
  const _$RegisterMemberResponseImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'verification_required') this.verificationRequired,
      @JsonKey(name: 'sent_to') this.sentTo,
      @JsonKey(name: 'member_id') this.memberId});

  factory _$RegisterMemberResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterMemberResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'verification_required')
  final bool? verificationRequired;
  @override
  @JsonKey(name: 'sent_to')
  final String? sentTo;
  @override
  @JsonKey(name: 'member_id')
  final int? memberId;

  @override
  String toString() {
    return 'RegisterMemberResponse(success: $success, message: $message, verificationRequired: $verificationRequired, sentTo: $sentTo, memberId: $memberId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterMemberResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.verificationRequired, verificationRequired) ||
                other.verificationRequired == verificationRequired) &&
            (identical(other.sentTo, sentTo) || other.sentTo == sentTo) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, verificationRequired, sentTo, memberId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterMemberResponseImplCopyWith<_$RegisterMemberResponseImpl>
      get copyWith => __$$RegisterMemberResponseImplCopyWithImpl<
          _$RegisterMemberResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterMemberResponseImplToJson(
      this,
    );
  }
}

abstract class _RegisterMemberResponse implements RegisterMemberResponse {
  const factory _RegisterMemberResponse(
      {required final bool success,
      required final String message,
      @JsonKey(name: 'verification_required') final bool? verificationRequired,
      @JsonKey(name: 'sent_to') final String? sentTo,
      @JsonKey(name: 'member_id')
      final int? memberId}) = _$RegisterMemberResponseImpl;

  factory _RegisterMemberResponse.fromJson(Map<String, dynamic> json) =
      _$RegisterMemberResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'verification_required')
  bool? get verificationRequired;
  @override
  @JsonKey(name: 'sent_to')
  String? get sentTo;
  @override
  @JsonKey(name: 'member_id')
  int? get memberId;
  @override
  @JsonKey(ignore: true)
  _$$RegisterMemberResponseImplCopyWith<_$RegisterMemberResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VerifyRegistrationRequest _$VerifyRegistrationRequestFromJson(
    Map<String, dynamic> json) {
  return _VerifyRegistrationRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyRegistrationRequest {
  @JsonKey(name: 'id_number')
  String get idNumber => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_confirmation')
  String get passwordConfirmation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyRegistrationRequestCopyWith<VerifyRegistrationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyRegistrationRequestCopyWith<$Res> {
  factory $VerifyRegistrationRequestCopyWith(VerifyRegistrationRequest value,
          $Res Function(VerifyRegistrationRequest) then) =
      _$VerifyRegistrationRequestCopyWithImpl<$Res, VerifyRegistrationRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_number') String idNumber,
      String code,
      String password,
      @JsonKey(name: 'password_confirmation') String passwordConfirmation});
}

/// @nodoc
class _$VerifyRegistrationRequestCopyWithImpl<$Res,
        $Val extends VerifyRegistrationRequest>
    implements $VerifyRegistrationRequestCopyWith<$Res> {
  _$VerifyRegistrationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
    Object? code = null,
    Object? password = null,
    Object? passwordConfirmation = null,
  }) {
    return _then(_value.copyWith(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirmation: null == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyRegistrationRequestImplCopyWith<$Res>
    implements $VerifyRegistrationRequestCopyWith<$Res> {
  factory _$$VerifyRegistrationRequestImplCopyWith(
          _$VerifyRegistrationRequestImpl value,
          $Res Function(_$VerifyRegistrationRequestImpl) then) =
      __$$VerifyRegistrationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_number') String idNumber,
      String code,
      String password,
      @JsonKey(name: 'password_confirmation') String passwordConfirmation});
}

/// @nodoc
class __$$VerifyRegistrationRequestImplCopyWithImpl<$Res>
    extends _$VerifyRegistrationRequestCopyWithImpl<$Res,
        _$VerifyRegistrationRequestImpl>
    implements _$$VerifyRegistrationRequestImplCopyWith<$Res> {
  __$$VerifyRegistrationRequestImplCopyWithImpl(
      _$VerifyRegistrationRequestImpl _value,
      $Res Function(_$VerifyRegistrationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
    Object? code = null,
    Object? password = null,
    Object? passwordConfirmation = null,
  }) {
    return _then(_$VerifyRegistrationRequestImpl(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirmation: null == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyRegistrationRequestImpl implements _VerifyRegistrationRequest {
  const _$VerifyRegistrationRequestImpl(
      {@JsonKey(name: 'id_number') required this.idNumber,
      required this.code,
      required this.password,
      @JsonKey(name: 'password_confirmation')
      required this.passwordConfirmation});

  factory _$VerifyRegistrationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyRegistrationRequestImplFromJson(json);

  @override
  @JsonKey(name: 'id_number')
  final String idNumber;
  @override
  final String code;
  @override
  final String password;
  @override
  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;

  @override
  String toString() {
    return 'VerifyRegistrationRequest(idNumber: $idNumber, code: $code, password: $password, passwordConfirmation: $passwordConfirmation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyRegistrationRequestImpl &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirmation, passwordConfirmation) ||
                other.passwordConfirmation == passwordConfirmation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idNumber, code, password, passwordConfirmation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyRegistrationRequestImplCopyWith<_$VerifyRegistrationRequestImpl>
      get copyWith => __$$VerifyRegistrationRequestImplCopyWithImpl<
          _$VerifyRegistrationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyRegistrationRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyRegistrationRequest implements VerifyRegistrationRequest {
  const factory _VerifyRegistrationRequest(
          {@JsonKey(name: 'id_number') required final String idNumber,
          required final String code,
          required final String password,
          @JsonKey(name: 'password_confirmation')
          required final String passwordConfirmation}) =
      _$VerifyRegistrationRequestImpl;

  factory _VerifyRegistrationRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyRegistrationRequestImpl.fromJson;

  @override
  @JsonKey(name: 'id_number')
  String get idNumber;
  @override
  String get code;
  @override
  String get password;
  @override
  @JsonKey(name: 'password_confirmation')
  String get passwordConfirmation;
  @override
  @JsonKey(ignore: true)
  _$$VerifyRegistrationRequestImplCopyWith<_$VerifyRegistrationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VerifyRegistrationResponse _$VerifyRegistrationResponseFromJson(
    Map<String, dynamic> json) {
  return _VerifyRegistrationResponse.fromJson(json);
}

/// @nodoc
mixin _$VerifyRegistrationResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  UserData? get user => throw _privateConstructorUsedError;
  MemberData? get member => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyRegistrationResponseCopyWith<VerifyRegistrationResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyRegistrationResponseCopyWith<$Res> {
  factory $VerifyRegistrationResponseCopyWith(VerifyRegistrationResponse value,
          $Res Function(VerifyRegistrationResponse) then) =
      _$VerifyRegistrationResponseCopyWithImpl<$Res,
          VerifyRegistrationResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      UserData? user,
      MemberData? member,
      String? token});

  $UserDataCopyWith<$Res>? get user;
  $MemberDataCopyWith<$Res>? get member;
}

/// @nodoc
class _$VerifyRegistrationResponseCopyWithImpl<$Res,
        $Val extends VerifyRegistrationResponse>
    implements $VerifyRegistrationResponseCopyWith<$Res> {
  _$VerifyRegistrationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? user = freezed,
    Object? member = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberData?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberDataCopyWith<$Res>? get member {
    if (_value.member == null) {
      return null;
    }

    return $MemberDataCopyWith<$Res>(_value.member!, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerifyRegistrationResponseImplCopyWith<$Res>
    implements $VerifyRegistrationResponseCopyWith<$Res> {
  factory _$$VerifyRegistrationResponseImplCopyWith(
          _$VerifyRegistrationResponseImpl value,
          $Res Function(_$VerifyRegistrationResponseImpl) then) =
      __$$VerifyRegistrationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      UserData? user,
      MemberData? member,
      String? token});

  @override
  $UserDataCopyWith<$Res>? get user;
  @override
  $MemberDataCopyWith<$Res>? get member;
}

/// @nodoc
class __$$VerifyRegistrationResponseImplCopyWithImpl<$Res>
    extends _$VerifyRegistrationResponseCopyWithImpl<$Res,
        _$VerifyRegistrationResponseImpl>
    implements _$$VerifyRegistrationResponseImplCopyWith<$Res> {
  __$$VerifyRegistrationResponseImplCopyWithImpl(
      _$VerifyRegistrationResponseImpl _value,
      $Res Function(_$VerifyRegistrationResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? user = freezed,
    Object? member = freezed,
    Object? token = freezed,
  }) {
    return _then(_$VerifyRegistrationResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberData?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyRegistrationResponseImpl implements _VerifyRegistrationResponse {
  const _$VerifyRegistrationResponseImpl(
      {required this.success,
      required this.message,
      this.user,
      this.member,
      this.token});

  factory _$VerifyRegistrationResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$VerifyRegistrationResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final UserData? user;
  @override
  final MemberData? member;
  @override
  final String? token;

  @override
  String toString() {
    return 'VerifyRegistrationResponse(success: $success, message: $message, user: $user, member: $member, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyRegistrationResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, user, member, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyRegistrationResponseImplCopyWith<_$VerifyRegistrationResponseImpl>
      get copyWith => __$$VerifyRegistrationResponseImplCopyWithImpl<
          _$VerifyRegistrationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyRegistrationResponseImplToJson(
      this,
    );
  }
}

abstract class _VerifyRegistrationResponse
    implements VerifyRegistrationResponse {
  const factory _VerifyRegistrationResponse(
      {required final bool success,
      required final String message,
      final UserData? user,
      final MemberData? member,
      final String? token}) = _$VerifyRegistrationResponseImpl;

  factory _VerifyRegistrationResponse.fromJson(Map<String, dynamic> json) =
      _$VerifyRegistrationResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  UserData? get user;
  @override
  MemberData? get member;
  @override
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$$VerifyRegistrationResponseImplCopyWith<_$VerifyRegistrationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  String get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int? get municipalityId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {int id,
      String name,
      String email,
      @JsonKey(name: 'user_type') String userType,
      @JsonKey(name: 'municipality_id') int? municipalityId});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

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
    Object? userType = null,
    Object? municipalityId = freezed,
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
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
          _$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String email,
      @JsonKey(name: 'user_type') String userType,
      @JsonKey(name: 'municipality_id') int? municipalityId});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
      _$UserDataImpl _value, $Res Function(_$UserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? userType = null,
    Object? municipalityId = freezed,
  }) {
    return _then(_$UserDataImpl(
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
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl implements _UserData {
  const _$UserDataImpl(
      {required this.id,
      required this.name,
      required this.email,
      @JsonKey(name: 'user_type') required this.userType,
      @JsonKey(name: 'municipality_id') this.municipalityId});

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'user_type')
  final String userType;
  @override
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;

  @override
  String toString() {
    return 'UserData(id: $id, name: $name, email: $email, userType: $userType, municipalityId: $municipalityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, email, userType, municipalityId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  const factory _UserData(
          {required final int id,
          required final String name,
          required final String email,
          @JsonKey(name: 'user_type') required final String userType,
          @JsonKey(name: 'municipality_id') final int? municipalityId}) =
      _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) =
      _$UserDataImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'user_type')
  String get userType;
  @override
  @JsonKey(name: 'municipality_id')
  int? get municipalityId;
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResendCodeRequest _$ResendCodeRequestFromJson(Map<String, dynamic> json) {
  return _ResendCodeRequest.fromJson(json);
}

/// @nodoc
mixin _$ResendCodeRequest {
  @JsonKey(name: 'id_number')
  String get idNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_method')
  String get verificationMethod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResendCodeRequestCopyWith<ResendCodeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResendCodeRequestCopyWith<$Res> {
  factory $ResendCodeRequestCopyWith(
          ResendCodeRequest value, $Res Function(ResendCodeRequest) then) =
      _$ResendCodeRequestCopyWithImpl<$Res, ResendCodeRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_number') String idNumber,
      @JsonKey(name: 'verification_method') String verificationMethod});
}

/// @nodoc
class _$ResendCodeRequestCopyWithImpl<$Res, $Val extends ResendCodeRequest>
    implements $ResendCodeRequestCopyWith<$Res> {
  _$ResendCodeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
    Object? verificationMethod = null,
  }) {
    return _then(_value.copyWith(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResendCodeRequestImplCopyWith<$Res>
    implements $ResendCodeRequestCopyWith<$Res> {
  factory _$$ResendCodeRequestImplCopyWith(_$ResendCodeRequestImpl value,
          $Res Function(_$ResendCodeRequestImpl) then) =
      __$$ResendCodeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_number') String idNumber,
      @JsonKey(name: 'verification_method') String verificationMethod});
}

/// @nodoc
class __$$ResendCodeRequestImplCopyWithImpl<$Res>
    extends _$ResendCodeRequestCopyWithImpl<$Res, _$ResendCodeRequestImpl>
    implements _$$ResendCodeRequestImplCopyWith<$Res> {
  __$$ResendCodeRequestImplCopyWithImpl(_$ResendCodeRequestImpl _value,
      $Res Function(_$ResendCodeRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idNumber = null,
    Object? verificationMethod = null,
  }) {
    return _then(_$ResendCodeRequestImpl(
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResendCodeRequestImpl implements _ResendCodeRequest {
  const _$ResendCodeRequestImpl(
      {@JsonKey(name: 'id_number') required this.idNumber,
      @JsonKey(name: 'verification_method') required this.verificationMethod});

  factory _$ResendCodeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResendCodeRequestImplFromJson(json);

  @override
  @JsonKey(name: 'id_number')
  final String idNumber;
  @override
  @JsonKey(name: 'verification_method')
  final String verificationMethod;

  @override
  String toString() {
    return 'ResendCodeRequest(idNumber: $idNumber, verificationMethod: $verificationMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendCodeRequestImpl &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idNumber, verificationMethod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendCodeRequestImplCopyWith<_$ResendCodeRequestImpl> get copyWith =>
      __$$ResendCodeRequestImplCopyWithImpl<_$ResendCodeRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResendCodeRequestImplToJson(
      this,
    );
  }
}

abstract class _ResendCodeRequest implements ResendCodeRequest {
  const factory _ResendCodeRequest(
      {@JsonKey(name: 'id_number') required final String idNumber,
      @JsonKey(name: 'verification_method')
      required final String verificationMethod}) = _$ResendCodeRequestImpl;

  factory _ResendCodeRequest.fromJson(Map<String, dynamic> json) =
      _$ResendCodeRequestImpl.fromJson;

  @override
  @JsonKey(name: 'id_number')
  String get idNumber;
  @override
  @JsonKey(name: 'verification_method')
  String get verificationMethod;
  @override
  @JsonKey(ignore: true)
  _$$ResendCodeRequestImplCopyWith<_$ResendCodeRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResendCodeResponse _$ResendCodeResponseFromJson(Map<String, dynamic> json) {
  return _ResendCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$ResendCodeResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_to')
  String? get sentTo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResendCodeResponseCopyWith<ResendCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResendCodeResponseCopyWith<$Res> {
  factory $ResendCodeResponseCopyWith(
          ResendCodeResponse value, $Res Function(ResendCodeResponse) then) =
      _$ResendCodeResponseCopyWithImpl<$Res, ResendCodeResponse>;
  @useResult
  $Res call(
      {bool success, String message, @JsonKey(name: 'sent_to') String? sentTo});
}

/// @nodoc
class _$ResendCodeResponseCopyWithImpl<$Res, $Val extends ResendCodeResponse>
    implements $ResendCodeResponseCopyWith<$Res> {
  _$ResendCodeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? sentTo = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sentTo: freezed == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResendCodeResponseImplCopyWith<$Res>
    implements $ResendCodeResponseCopyWith<$Res> {
  factory _$$ResendCodeResponseImplCopyWith(_$ResendCodeResponseImpl value,
          $Res Function(_$ResendCodeResponseImpl) then) =
      __$$ResendCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success, String message, @JsonKey(name: 'sent_to') String? sentTo});
}

/// @nodoc
class __$$ResendCodeResponseImplCopyWithImpl<$Res>
    extends _$ResendCodeResponseCopyWithImpl<$Res, _$ResendCodeResponseImpl>
    implements _$$ResendCodeResponseImplCopyWith<$Res> {
  __$$ResendCodeResponseImplCopyWithImpl(_$ResendCodeResponseImpl _value,
      $Res Function(_$ResendCodeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? sentTo = freezed,
  }) {
    return _then(_$ResendCodeResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sentTo: freezed == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResendCodeResponseImpl implements _ResendCodeResponse {
  const _$ResendCodeResponseImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'sent_to') this.sentTo});

  factory _$ResendCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResendCodeResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'sent_to')
  final String? sentTo;

  @override
  String toString() {
    return 'ResendCodeResponse(success: $success, message: $message, sentTo: $sentTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendCodeResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sentTo, sentTo) || other.sentTo == sentTo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, sentTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendCodeResponseImplCopyWith<_$ResendCodeResponseImpl> get copyWith =>
      __$$ResendCodeResponseImplCopyWithImpl<_$ResendCodeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResendCodeResponseImplToJson(
      this,
    );
  }
}

abstract class _ResendCodeResponse implements ResendCodeResponse {
  const factory _ResendCodeResponse(
          {required final bool success,
          required final String message,
          @JsonKey(name: 'sent_to') final String? sentTo}) =
      _$ResendCodeResponseImpl;

  factory _ResendCodeResponse.fromJson(Map<String, dynamic> json) =
      _$ResendCodeResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'sent_to')
  String? get sentTo;
  @override
  @JsonKey(ignore: true)
  _$$ResendCodeResponseImplCopyWith<_$ResendCodeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
