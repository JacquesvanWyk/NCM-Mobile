// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PollModel _$PollModelFromJson(Map<String, dynamic> json) {
  return _PollModel.fromJson(json);
}

/// @nodoc
mixin _$PollModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'poll_type')
  String get pollType => throw _privateConstructorUsedError;
  String get options =>
      throw _privateConstructorUsedError; // JSON string from API Platform
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'starts_at')
  DateTime get startsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime get endsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_public')
  bool get isPublic => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_voted')
  bool get hasVoted => throw _privateConstructorUsedError;
  List<dynamic> get results => throw _privateConstructorUsedError;
  String? get municipality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollModelCopyWith<PollModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollModelCopyWith<$Res> {
  factory $PollModelCopyWith(PollModel value, $Res Function(PollModel) then) =
      _$PollModelCopyWithImpl<$Res, PollModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      @JsonKey(name: 'poll_type') String pollType,
      String options,
      String status,
      @JsonKey(name: 'starts_at') DateTime startsAt,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'is_public') bool isPublic,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'has_voted') bool hasVoted,
      List<dynamic> results,
      String? municipality});
}

/// @nodoc
class _$PollModelCopyWithImpl<$Res, $Val extends PollModel>
    implements $PollModelCopyWith<$Res> {
  _$PollModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? pollType = null,
    Object? options = null,
    Object? status = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? isPublic = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasVoted = null,
    Object? results = null,
    Object? municipality = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pollType: null == pollType
          ? _value.pollType
          : pollType // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasVoted: null == hasVoted
          ? _value.hasVoted
          : hasVoted // ignore: cast_nullable_to_non_nullable
              as bool,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollModelImplCopyWith<$Res>
    implements $PollModelCopyWith<$Res> {
  factory _$$PollModelImplCopyWith(
          _$PollModelImpl value, $Res Function(_$PollModelImpl) then) =
      __$$PollModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      @JsonKey(name: 'poll_type') String pollType,
      String options,
      String status,
      @JsonKey(name: 'starts_at') DateTime startsAt,
      @JsonKey(name: 'ends_at') DateTime endsAt,
      @JsonKey(name: 'is_public') bool isPublic,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'has_voted') bool hasVoted,
      List<dynamic> results,
      String? municipality});
}

/// @nodoc
class __$$PollModelImplCopyWithImpl<$Res>
    extends _$PollModelCopyWithImpl<$Res, _$PollModelImpl>
    implements _$$PollModelImplCopyWith<$Res> {
  __$$PollModelImplCopyWithImpl(
      _$PollModelImpl _value, $Res Function(_$PollModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? pollType = null,
    Object? options = null,
    Object? status = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? isPublic = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasVoted = null,
    Object? results = null,
    Object? municipality = freezed,
  }) {
    return _then(_$PollModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pollType: null == pollType
          ? _value.pollType
          : pollType // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startsAt: null == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endsAt: null == endsAt
          ? _value.endsAt
          : endsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasVoted: null == hasVoted
          ? _value.hasVoted
          : hasVoted // ignore: cast_nullable_to_non_nullable
              as bool,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollModelImpl implements _PollModel {
  const _$PollModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      @JsonKey(name: 'poll_type') required this.pollType,
      required this.options,
      required this.status,
      @JsonKey(name: 'starts_at') required this.startsAt,
      @JsonKey(name: 'ends_at') required this.endsAt,
      @JsonKey(name: 'is_public') required this.isPublic,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'has_voted') this.hasVoted = false,
      final List<dynamic> results = const [],
      this.municipality})
      : _results = results;

  factory _$PollModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'poll_type')
  final String pollType;
  @override
  final String options;
// JSON string from API Platform
  @override
  final String status;
  @override
  @JsonKey(name: 'starts_at')
  final DateTime startsAt;
  @override
  @JsonKey(name: 'ends_at')
  final DateTime endsAt;
  @override
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'has_voted')
  final bool hasVoted;
  final List<dynamic> _results;
  @override
  @JsonKey()
  List<dynamic> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  final String? municipality;

  @override
  String toString() {
    return 'PollModel(id: $id, title: $title, description: $description, pollType: $pollType, options: $options, status: $status, startsAt: $startsAt, endsAt: $endsAt, isPublic: $isPublic, createdAt: $createdAt, updatedAt: $updatedAt, hasVoted: $hasVoted, results: $results, municipality: $municipality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pollType, pollType) ||
                other.pollType == pollType) &&
            (identical(other.options, options) || other.options == options) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.hasVoted, hasVoted) ||
                other.hasVoted == hasVoted) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.municipality, municipality) ||
                other.municipality == municipality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      pollType,
      options,
      status,
      startsAt,
      endsAt,
      isPublic,
      createdAt,
      updatedAt,
      hasVoted,
      const DeepCollectionEquality().hash(_results),
      municipality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollModelImplCopyWith<_$PollModelImpl> get copyWith =>
      __$$PollModelImplCopyWithImpl<_$PollModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollModelImplToJson(
      this,
    );
  }
}

abstract class _PollModel implements PollModel {
  const factory _PollModel(
      {required final int id,
      required final String title,
      required final String description,
      @JsonKey(name: 'poll_type') required final String pollType,
      required final String options,
      required final String status,
      @JsonKey(name: 'starts_at') required final DateTime startsAt,
      @JsonKey(name: 'ends_at') required final DateTime endsAt,
      @JsonKey(name: 'is_public') required final bool isPublic,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      @JsonKey(name: 'has_voted') final bool hasVoted,
      final List<dynamic> results,
      final String? municipality}) = _$PollModelImpl;

  factory _PollModel.fromJson(Map<String, dynamic> json) =
      _$PollModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'poll_type')
  String get pollType;
  @override
  String get options;
  @override // JSON string from API Platform
  String get status;
  @override
  @JsonKey(name: 'starts_at')
  DateTime get startsAt;
  @override
  @JsonKey(name: 'ends_at')
  DateTime get endsAt;
  @override
  @JsonKey(name: 'is_public')
  bool get isPublic;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'has_voted')
  bool get hasVoted;
  @override
  List<dynamic> get results;
  @override
  String? get municipality;
  @override
  @JsonKey(ignore: true)
  _$$PollModelImplCopyWith<_$PollModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollOptionModel _$PollOptionModelFromJson(Map<String, dynamic> json) {
  return _PollOptionModel.fromJson(json);
}

/// @nodoc
mixin _$PollOptionModel {
  int get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get voteCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollOptionModelCopyWith<PollOptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollOptionModelCopyWith<$Res> {
  factory $PollOptionModelCopyWith(
          PollOptionModel value, $Res Function(PollOptionModel) then) =
      _$PollOptionModelCopyWithImpl<$Res, PollOptionModel>;
  @useResult
  $Res call({int id, String text, int voteCount});
}

/// @nodoc
class _$PollOptionModelCopyWithImpl<$Res, $Val extends PollOptionModel>
    implements $PollOptionModelCopyWith<$Res> {
  _$PollOptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? voteCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollOptionModelImplCopyWith<$Res>
    implements $PollOptionModelCopyWith<$Res> {
  factory _$$PollOptionModelImplCopyWith(_$PollOptionModelImpl value,
          $Res Function(_$PollOptionModelImpl) then) =
      __$$PollOptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String text, int voteCount});
}

/// @nodoc
class __$$PollOptionModelImplCopyWithImpl<$Res>
    extends _$PollOptionModelCopyWithImpl<$Res, _$PollOptionModelImpl>
    implements _$$PollOptionModelImplCopyWith<$Res> {
  __$$PollOptionModelImplCopyWithImpl(
      _$PollOptionModelImpl _value, $Res Function(_$PollOptionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? voteCount = null,
  }) {
    return _then(_$PollOptionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollOptionModelImpl implements _PollOptionModel {
  const _$PollOptionModelImpl(
      {required this.id, required this.text, this.voteCount = 0});

  factory _$PollOptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollOptionModelImplFromJson(json);

  @override
  final int id;
  @override
  final String text;
  @override
  @JsonKey()
  final int voteCount;

  @override
  String toString() {
    return 'PollOptionModel(id: $id, text: $text, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollOptionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, voteCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollOptionModelImplCopyWith<_$PollOptionModelImpl> get copyWith =>
      __$$PollOptionModelImplCopyWithImpl<_$PollOptionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollOptionModelImplToJson(
      this,
    );
  }
}

abstract class _PollOptionModel implements PollOptionModel {
  const factory _PollOptionModel(
      {required final int id,
      required final String text,
      final int voteCount}) = _$PollOptionModelImpl;

  factory _PollOptionModel.fromJson(Map<String, dynamic> json) =
      _$PollOptionModelImpl.fromJson;

  @override
  int get id;
  @override
  String get text;
  @override
  int get voteCount;
  @override
  @JsonKey(ignore: true)
  _$$PollOptionModelImplCopyWith<_$PollOptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollResponseRequest _$PollResponseRequestFromJson(Map<String, dynamic> json) {
  return _PollResponseRequest.fromJson(json);
}

/// @nodoc
mixin _$PollResponseRequest {
  Map<String, dynamic> get response => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollResponseRequestCopyWith<PollResponseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollResponseRequestCopyWith<$Res> {
  factory $PollResponseRequestCopyWith(
          PollResponseRequest value, $Res Function(PollResponseRequest) then) =
      _$PollResponseRequestCopyWithImpl<$Res, PollResponseRequest>;
  @useResult
  $Res call({Map<String, dynamic> response});
}

/// @nodoc
class _$PollResponseRequestCopyWithImpl<$Res, $Val extends PollResponseRequest>
    implements $PollResponseRequestCopyWith<$Res> {
  _$PollResponseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollResponseRequestImplCopyWith<$Res>
    implements $PollResponseRequestCopyWith<$Res> {
  factory _$$PollResponseRequestImplCopyWith(_$PollResponseRequestImpl value,
          $Res Function(_$PollResponseRequestImpl) then) =
      __$$PollResponseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> response});
}

/// @nodoc
class __$$PollResponseRequestImplCopyWithImpl<$Res>
    extends _$PollResponseRequestCopyWithImpl<$Res, _$PollResponseRequestImpl>
    implements _$$PollResponseRequestImplCopyWith<$Res> {
  __$$PollResponseRequestImplCopyWithImpl(_$PollResponseRequestImpl _value,
      $Res Function(_$PollResponseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$PollResponseRequestImpl(
      response: null == response
          ? _value._response
          : response // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollResponseRequestImpl implements _PollResponseRequest {
  const _$PollResponseRequestImpl(
      {required final Map<String, dynamic> response})
      : _response = response;

  factory _$PollResponseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollResponseRequestImplFromJson(json);

  final Map<String, dynamic> _response;
  @override
  Map<String, dynamic> get response {
    if (_response is EqualUnmodifiableMapView) return _response;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_response);
  }

  @override
  String toString() {
    return 'PollResponseRequest(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollResponseRequestImpl &&
            const DeepCollectionEquality().equals(other._response, _response));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollResponseRequestImplCopyWith<_$PollResponseRequestImpl> get copyWith =>
      __$$PollResponseRequestImplCopyWithImpl<_$PollResponseRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollResponseRequestImplToJson(
      this,
    );
  }
}

abstract class _PollResponseRequest implements PollResponseRequest {
  const factory _PollResponseRequest(
          {required final Map<String, dynamic> response}) =
      _$PollResponseRequestImpl;

  factory _PollResponseRequest.fromJson(Map<String, dynamic> json) =
      _$PollResponseRequestImpl.fromJson;

  @override
  Map<String, dynamic> get response;
  @override
  @JsonKey(ignore: true)
  _$$PollResponseRequestImplCopyWith<_$PollResponseRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
