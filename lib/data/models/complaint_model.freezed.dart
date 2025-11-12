// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complaint_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComplaintModel _$ComplaintModelFromJson(Map<String, dynamic> json) {
  return _ComplaintModel.fromJson(json);
}

/// @nodoc
mixin _$ComplaintModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  int get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'complaint_category_id')
  int? get complaintCategoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_leader_id')
  int? get assignedLeaderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int get municipalityId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_address')
  String? get locationAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_latitude')
  double? get locationLatitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_longitude')
  double? get locationLongitude => throw _privateConstructorUsedError;
  List<String>? get photos => throw _privateConstructorUsedError;
  List<String>? get documents => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_method_preference')
  String get contactMethodPreference => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_anonymous')
  bool get isAnonymous => throw _privateConstructorUsedError;
  @JsonKey(name: 'resolved_at')
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'resolution_notes')
  String? get resolutionNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_reference_number')
  String? get externalReferenceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'escalated_to_department')
  String? get escalatedToDepartment => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_deadline')
  DateTime? get responseDeadline => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Relationships
  MemberModel? get member => throw _privateConstructorUsedError;
  ComplaintCategoryModel? get category => throw _privateConstructorUsedError;
  LeaderModel? get assignedLeader => throw _privateConstructorUsedError;
  MunicipalityModel? get municipality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplaintModelCopyWith<ComplaintModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintModelCopyWith<$Res> {
  factory $ComplaintModelCopyWith(
          ComplaintModel value, $Res Function(ComplaintModel) then) =
      _$ComplaintModelCopyWithImpl<$Res, ComplaintModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'member_id') int memberId,
      @JsonKey(name: 'complaint_category_id') int? complaintCategoryId,
      @JsonKey(name: 'assigned_leader_id') int? assignedLeaderId,
      @JsonKey(name: 'municipality_id') int municipalityId,
      String title,
      String description,
      String priority,
      String status,
      @JsonKey(name: 'location_address') String? locationAddress,
      @JsonKey(name: 'location_latitude') double? locationLatitude,
      @JsonKey(name: 'location_longitude') double? locationLongitude,
      List<String>? photos,
      List<String>? documents,
      @JsonKey(name: 'contact_method_preference')
      String contactMethodPreference,
      @JsonKey(name: 'is_anonymous') bool isAnonymous,
      @JsonKey(name: 'resolved_at') DateTime? resolvedAt,
      @JsonKey(name: 'resolution_notes') String? resolutionNotes,
      @JsonKey(name: 'external_reference_number')
      String? externalReferenceNumber,
      @JsonKey(name: 'escalated_to_department') String? escalatedToDepartment,
      @JsonKey(name: 'response_deadline') DateTime? responseDeadline,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      MemberModel? member,
      ComplaintCategoryModel? category,
      LeaderModel? assignedLeader,
      MunicipalityModel? municipality});

  $MemberModelCopyWith<$Res>? get member;
  $ComplaintCategoryModelCopyWith<$Res>? get category;
  $LeaderModelCopyWith<$Res>? get assignedLeader;
  $MunicipalityModelCopyWith<$Res>? get municipality;
}

/// @nodoc
class _$ComplaintModelCopyWithImpl<$Res, $Val extends ComplaintModel>
    implements $ComplaintModelCopyWith<$Res> {
  _$ComplaintModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = null,
    Object? complaintCategoryId = freezed,
    Object? assignedLeaderId = freezed,
    Object? municipalityId = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? status = null,
    Object? locationAddress = freezed,
    Object? locationLatitude = freezed,
    Object? locationLongitude = freezed,
    Object? photos = freezed,
    Object? documents = freezed,
    Object? contactMethodPreference = null,
    Object? isAnonymous = null,
    Object? resolvedAt = freezed,
    Object? resolutionNotes = freezed,
    Object? externalReferenceNumber = freezed,
    Object? escalatedToDepartment = freezed,
    Object? responseDeadline = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? member = freezed,
    Object? category = freezed,
    Object? assignedLeader = freezed,
    Object? municipality = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      complaintCategoryId: freezed == complaintCategoryId
          ? _value.complaintCategoryId
          : complaintCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      assignedLeaderId: freezed == assignedLeaderId
          ? _value.assignedLeaderId
          : assignedLeaderId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      locationAddress: freezed == locationAddress
          ? _value.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      locationLatitude: freezed == locationLatitude
          ? _value.locationLatitude
          : locationLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationLongitude: freezed == locationLongitude
          ? _value.locationLongitude
          : locationLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      documents: freezed == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      contactMethodPreference: null == contactMethodPreference
          ? _value.contactMethodPreference
          : contactMethodPreference // ignore: cast_nullable_to_non_nullable
              as String,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolutionNotes: freezed == resolutionNotes
          ? _value.resolutionNotes
          : resolutionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      externalReferenceNumber: freezed == externalReferenceNumber
          ? _value.externalReferenceNumber
          : externalReferenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      escalatedToDepartment: freezed == escalatedToDepartment
          ? _value.escalatedToDepartment
          : escalatedToDepartment // ignore: cast_nullable_to_non_nullable
              as String?,
      responseDeadline: freezed == responseDeadline
          ? _value.responseDeadline
          : responseDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberModel?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ComplaintCategoryModel?,
      assignedLeader: freezed == assignedLeader
          ? _value.assignedLeader
          : assignedLeader // ignore: cast_nullable_to_non_nullable
              as LeaderModel?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as MunicipalityModel?,
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
  $ComplaintCategoryModelCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $ComplaintCategoryModelCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaderModelCopyWith<$Res>? get assignedLeader {
    if (_value.assignedLeader == null) {
      return null;
    }

    return $LeaderModelCopyWith<$Res>(_value.assignedLeader!, (value) {
      return _then(_value.copyWith(assignedLeader: value) as $Val);
    });
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
abstract class _$$ComplaintModelImplCopyWith<$Res>
    implements $ComplaintModelCopyWith<$Res> {
  factory _$$ComplaintModelImplCopyWith(_$ComplaintModelImpl value,
          $Res Function(_$ComplaintModelImpl) then) =
      __$$ComplaintModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'member_id') int memberId,
      @JsonKey(name: 'complaint_category_id') int? complaintCategoryId,
      @JsonKey(name: 'assigned_leader_id') int? assignedLeaderId,
      @JsonKey(name: 'municipality_id') int municipalityId,
      String title,
      String description,
      String priority,
      String status,
      @JsonKey(name: 'location_address') String? locationAddress,
      @JsonKey(name: 'location_latitude') double? locationLatitude,
      @JsonKey(name: 'location_longitude') double? locationLongitude,
      List<String>? photos,
      List<String>? documents,
      @JsonKey(name: 'contact_method_preference')
      String contactMethodPreference,
      @JsonKey(name: 'is_anonymous') bool isAnonymous,
      @JsonKey(name: 'resolved_at') DateTime? resolvedAt,
      @JsonKey(name: 'resolution_notes') String? resolutionNotes,
      @JsonKey(name: 'external_reference_number')
      String? externalReferenceNumber,
      @JsonKey(name: 'escalated_to_department') String? escalatedToDepartment,
      @JsonKey(name: 'response_deadline') DateTime? responseDeadline,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      MemberModel? member,
      ComplaintCategoryModel? category,
      LeaderModel? assignedLeader,
      MunicipalityModel? municipality});

  @override
  $MemberModelCopyWith<$Res>? get member;
  @override
  $ComplaintCategoryModelCopyWith<$Res>? get category;
  @override
  $LeaderModelCopyWith<$Res>? get assignedLeader;
  @override
  $MunicipalityModelCopyWith<$Res>? get municipality;
}

/// @nodoc
class __$$ComplaintModelImplCopyWithImpl<$Res>
    extends _$ComplaintModelCopyWithImpl<$Res, _$ComplaintModelImpl>
    implements _$$ComplaintModelImplCopyWith<$Res> {
  __$$ComplaintModelImplCopyWithImpl(
      _$ComplaintModelImpl _value, $Res Function(_$ComplaintModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = null,
    Object? complaintCategoryId = freezed,
    Object? assignedLeaderId = freezed,
    Object? municipalityId = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? status = null,
    Object? locationAddress = freezed,
    Object? locationLatitude = freezed,
    Object? locationLongitude = freezed,
    Object? photos = freezed,
    Object? documents = freezed,
    Object? contactMethodPreference = null,
    Object? isAnonymous = null,
    Object? resolvedAt = freezed,
    Object? resolutionNotes = freezed,
    Object? externalReferenceNumber = freezed,
    Object? escalatedToDepartment = freezed,
    Object? responseDeadline = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? member = freezed,
    Object? category = freezed,
    Object? assignedLeader = freezed,
    Object? municipality = freezed,
  }) {
    return _then(_$ComplaintModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      complaintCategoryId: freezed == complaintCategoryId
          ? _value.complaintCategoryId
          : complaintCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      assignedLeaderId: freezed == assignedLeaderId
          ? _value.assignedLeaderId
          : assignedLeaderId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipalityId: null == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      locationAddress: freezed == locationAddress
          ? _value.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      locationLatitude: freezed == locationLatitude
          ? _value.locationLatitude
          : locationLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationLongitude: freezed == locationLongitude
          ? _value.locationLongitude
          : locationLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      documents: freezed == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      contactMethodPreference: null == contactMethodPreference
          ? _value.contactMethodPreference
          : contactMethodPreference // ignore: cast_nullable_to_non_nullable
              as String,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolutionNotes: freezed == resolutionNotes
          ? _value.resolutionNotes
          : resolutionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      externalReferenceNumber: freezed == externalReferenceNumber
          ? _value.externalReferenceNumber
          : externalReferenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      escalatedToDepartment: freezed == escalatedToDepartment
          ? _value.escalatedToDepartment
          : escalatedToDepartment // ignore: cast_nullable_to_non_nullable
              as String?,
      responseDeadline: freezed == responseDeadline
          ? _value.responseDeadline
          : responseDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberModel?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ComplaintCategoryModel?,
      assignedLeader: freezed == assignedLeader
          ? _value.assignedLeader
          : assignedLeader // ignore: cast_nullable_to_non_nullable
              as LeaderModel?,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as MunicipalityModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplaintModelImpl implements _ComplaintModel {
  const _$ComplaintModelImpl(
      {required this.id,
      @JsonKey(name: 'member_id') required this.memberId,
      @JsonKey(name: 'complaint_category_id') this.complaintCategoryId,
      @JsonKey(name: 'assigned_leader_id') this.assignedLeaderId,
      @JsonKey(name: 'municipality_id') required this.municipalityId,
      required this.title,
      required this.description,
      this.priority = 'medium',
      this.status = 'submitted',
      @JsonKey(name: 'location_address') this.locationAddress,
      @JsonKey(name: 'location_latitude') this.locationLatitude,
      @JsonKey(name: 'location_longitude') this.locationLongitude,
      final List<String>? photos,
      final List<String>? documents,
      @JsonKey(name: 'contact_method_preference')
      this.contactMethodPreference = 'phone',
      @JsonKey(name: 'is_anonymous') this.isAnonymous = false,
      @JsonKey(name: 'resolved_at') this.resolvedAt,
      @JsonKey(name: 'resolution_notes') this.resolutionNotes,
      @JsonKey(name: 'external_reference_number') this.externalReferenceNumber,
      @JsonKey(name: 'escalated_to_department') this.escalatedToDepartment,
      @JsonKey(name: 'response_deadline') this.responseDeadline,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.member,
      this.category,
      this.assignedLeader,
      this.municipality})
      : _photos = photos,
        _documents = documents;

  factory _$ComplaintModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'member_id')
  final int memberId;
  @override
  @JsonKey(name: 'complaint_category_id')
  final int? complaintCategoryId;
  @override
  @JsonKey(name: 'assigned_leader_id')
  final int? assignedLeaderId;
  @override
  @JsonKey(name: 'municipality_id')
  final int municipalityId;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final String priority;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'location_address')
  final String? locationAddress;
  @override
  @JsonKey(name: 'location_latitude')
  final double? locationLatitude;
  @override
  @JsonKey(name: 'location_longitude')
  final double? locationLongitude;
  final List<String>? _photos;
  @override
  List<String>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _documents;
  @override
  List<String>? get documents {
    final value = _documents;
    if (value == null) return null;
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'contact_method_preference')
  final String contactMethodPreference;
  @override
  @JsonKey(name: 'is_anonymous')
  final bool isAnonymous;
  @override
  @JsonKey(name: 'resolved_at')
  final DateTime? resolvedAt;
  @override
  @JsonKey(name: 'resolution_notes')
  final String? resolutionNotes;
  @override
  @JsonKey(name: 'external_reference_number')
  final String? externalReferenceNumber;
  @override
  @JsonKey(name: 'escalated_to_department')
  final String? escalatedToDepartment;
  @override
  @JsonKey(name: 'response_deadline')
  final DateTime? responseDeadline;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
// Relationships
  @override
  final MemberModel? member;
  @override
  final ComplaintCategoryModel? category;
  @override
  final LeaderModel? assignedLeader;
  @override
  final MunicipalityModel? municipality;

  @override
  String toString() {
    return 'ComplaintModel(id: $id, memberId: $memberId, complaintCategoryId: $complaintCategoryId, assignedLeaderId: $assignedLeaderId, municipalityId: $municipalityId, title: $title, description: $description, priority: $priority, status: $status, locationAddress: $locationAddress, locationLatitude: $locationLatitude, locationLongitude: $locationLongitude, photos: $photos, documents: $documents, contactMethodPreference: $contactMethodPreference, isAnonymous: $isAnonymous, resolvedAt: $resolvedAt, resolutionNotes: $resolutionNotes, externalReferenceNumber: $externalReferenceNumber, escalatedToDepartment: $escalatedToDepartment, responseDeadline: $responseDeadline, createdAt: $createdAt, updatedAt: $updatedAt, member: $member, category: $category, assignedLeader: $assignedLeader, municipality: $municipality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.complaintCategoryId, complaintCategoryId) ||
                other.complaintCategoryId == complaintCategoryId) &&
            (identical(other.assignedLeaderId, assignedLeaderId) ||
                other.assignedLeaderId == assignedLeaderId) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.locationAddress, locationAddress) ||
                other.locationAddress == locationAddress) &&
            (identical(other.locationLatitude, locationLatitude) ||
                other.locationLatitude == locationLatitude) &&
            (identical(other.locationLongitude, locationLongitude) ||
                other.locationLongitude == locationLongitude) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(
                    other.contactMethodPreference, contactMethodPreference) ||
                other.contactMethodPreference == contactMethodPreference) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.resolutionNotes, resolutionNotes) ||
                other.resolutionNotes == resolutionNotes) &&
            (identical(
                    other.externalReferenceNumber, externalReferenceNumber) ||
                other.externalReferenceNumber == externalReferenceNumber) &&
            (identical(other.escalatedToDepartment, escalatedToDepartment) ||
                other.escalatedToDepartment == escalatedToDepartment) &&
            (identical(other.responseDeadline, responseDeadline) ||
                other.responseDeadline == responseDeadline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.assignedLeader, assignedLeader) ||
                other.assignedLeader == assignedLeader) &&
            (identical(other.municipality, municipality) ||
                other.municipality == municipality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        memberId,
        complaintCategoryId,
        assignedLeaderId,
        municipalityId,
        title,
        description,
        priority,
        status,
        locationAddress,
        locationLatitude,
        locationLongitude,
        const DeepCollectionEquality().hash(_photos),
        const DeepCollectionEquality().hash(_documents),
        contactMethodPreference,
        isAnonymous,
        resolvedAt,
        resolutionNotes,
        externalReferenceNumber,
        escalatedToDepartment,
        responseDeadline,
        createdAt,
        updatedAt,
        member,
        category,
        assignedLeader,
        municipality
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintModelImplCopyWith<_$ComplaintModelImpl> get copyWith =>
      __$$ComplaintModelImplCopyWithImpl<_$ComplaintModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintModelImplToJson(
      this,
    );
  }
}

abstract class _ComplaintModel implements ComplaintModel {
  const factory _ComplaintModel(
      {required final int id,
      @JsonKey(name: 'member_id') required final int memberId,
      @JsonKey(name: 'complaint_category_id') final int? complaintCategoryId,
      @JsonKey(name: 'assigned_leader_id') final int? assignedLeaderId,
      @JsonKey(name: 'municipality_id') required final int municipalityId,
      required final String title,
      required final String description,
      final String priority,
      final String status,
      @JsonKey(name: 'location_address') final String? locationAddress,
      @JsonKey(name: 'location_latitude') final double? locationLatitude,
      @JsonKey(name: 'location_longitude') final double? locationLongitude,
      final List<String>? photos,
      final List<String>? documents,
      @JsonKey(name: 'contact_method_preference')
      final String contactMethodPreference,
      @JsonKey(name: 'is_anonymous') final bool isAnonymous,
      @JsonKey(name: 'resolved_at') final DateTime? resolvedAt,
      @JsonKey(name: 'resolution_notes') final String? resolutionNotes,
      @JsonKey(name: 'external_reference_number')
      final String? externalReferenceNumber,
      @JsonKey(name: 'escalated_to_department')
      final String? escalatedToDepartment,
      @JsonKey(name: 'response_deadline') final DateTime? responseDeadline,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final MemberModel? member,
      final ComplaintCategoryModel? category,
      final LeaderModel? assignedLeader,
      final MunicipalityModel? municipality}) = _$ComplaintModelImpl;

  factory _ComplaintModel.fromJson(Map<String, dynamic> json) =
      _$ComplaintModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'member_id')
  int get memberId;
  @override
  @JsonKey(name: 'complaint_category_id')
  int? get complaintCategoryId;
  @override
  @JsonKey(name: 'assigned_leader_id')
  int? get assignedLeaderId;
  @override
  @JsonKey(name: 'municipality_id')
  int get municipalityId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get priority;
  @override
  String get status;
  @override
  @JsonKey(name: 'location_address')
  String? get locationAddress;
  @override
  @JsonKey(name: 'location_latitude')
  double? get locationLatitude;
  @override
  @JsonKey(name: 'location_longitude')
  double? get locationLongitude;
  @override
  List<String>? get photos;
  @override
  List<String>? get documents;
  @override
  @JsonKey(name: 'contact_method_preference')
  String get contactMethodPreference;
  @override
  @JsonKey(name: 'is_anonymous')
  bool get isAnonymous;
  @override
  @JsonKey(name: 'resolved_at')
  DateTime? get resolvedAt;
  @override
  @JsonKey(name: 'resolution_notes')
  String? get resolutionNotes;
  @override
  @JsonKey(name: 'external_reference_number')
  String? get externalReferenceNumber;
  @override
  @JsonKey(name: 'escalated_to_department')
  String? get escalatedToDepartment;
  @override
  @JsonKey(name: 'response_deadline')
  DateTime? get responseDeadline;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override // Relationships
  MemberModel? get member;
  @override
  ComplaintCategoryModel? get category;
  @override
  LeaderModel? get assignedLeader;
  @override
  MunicipalityModel? get municipality;
  @override
  @JsonKey(ignore: true)
  _$$ComplaintModelImplCopyWith<_$ComplaintModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplaintCategoryModel _$ComplaintCategoryModelFromJson(
    Map<String, dynamic> json) {
  return _ComplaintCategoryModel.fromJson(json);
}

/// @nodoc
mixin _$ComplaintCategoryModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  @JsonKey(name: 'priority_level')
  String get priorityLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time_hours')
  int get responseTimeHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplaintCategoryModelCopyWith<ComplaintCategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintCategoryModelCopyWith<$Res> {
  factory $ComplaintCategoryModelCopyWith(ComplaintCategoryModel value,
          $Res Function(ComplaintCategoryModel) then) =
      _$ComplaintCategoryModelCopyWithImpl<$Res, ComplaintCategoryModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String? icon,
      String color,
      String? department,
      @JsonKey(name: 'priority_level') String priorityLevel,
      @JsonKey(name: 'response_time_hours') int responseTimeHours,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ComplaintCategoryModelCopyWithImpl<$Res,
        $Val extends ComplaintCategoryModel>
    implements $ComplaintCategoryModelCopyWith<$Res> {
  _$ComplaintCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = null,
    Object? department = freezed,
    Object? priorityLevel = null,
    Object? responseTimeHours = null,
    Object? isActive = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      priorityLevel: null == priorityLevel
          ? _value.priorityLevel
          : priorityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      responseTimeHours: null == responseTimeHours
          ? _value.responseTimeHours
          : responseTimeHours // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$ComplaintCategoryModelImplCopyWith<$Res>
    implements $ComplaintCategoryModelCopyWith<$Res> {
  factory _$$ComplaintCategoryModelImplCopyWith(
          _$ComplaintCategoryModelImpl value,
          $Res Function(_$ComplaintCategoryModelImpl) then) =
      __$$ComplaintCategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String? icon,
      String color,
      String? department,
      @JsonKey(name: 'priority_level') String priorityLevel,
      @JsonKey(name: 'response_time_hours') int responseTimeHours,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ComplaintCategoryModelImplCopyWithImpl<$Res>
    extends _$ComplaintCategoryModelCopyWithImpl<$Res,
        _$ComplaintCategoryModelImpl>
    implements _$$ComplaintCategoryModelImplCopyWith<$Res> {
  __$$ComplaintCategoryModelImplCopyWithImpl(
      _$ComplaintCategoryModelImpl _value,
      $Res Function(_$ComplaintCategoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = null,
    Object? department = freezed,
    Object? priorityLevel = null,
    Object? responseTimeHours = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ComplaintCategoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      priorityLevel: null == priorityLevel
          ? _value.priorityLevel
          : priorityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      responseTimeHours: null == responseTimeHours
          ? _value.responseTimeHours
          : responseTimeHours // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$ComplaintCategoryModelImpl implements _ComplaintCategoryModel {
  const _$ComplaintCategoryModelImpl(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.color = '#007bff',
      this.department,
      @JsonKey(name: 'priority_level') this.priorityLevel = 'medium',
      @JsonKey(name: 'response_time_hours') this.responseTimeHours = 72,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ComplaintCategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintCategoryModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  @JsonKey()
  final String color;
  @override
  final String? department;
  @override
  @JsonKey(name: 'priority_level')
  final String priorityLevel;
  @override
  @JsonKey(name: 'response_time_hours')
  final int responseTimeHours;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ComplaintCategoryModel(id: $id, name: $name, description: $description, icon: $icon, color: $color, department: $department, priorityLevel: $priorityLevel, responseTimeHours: $responseTimeHours, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintCategoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.priorityLevel, priorityLevel) ||
                other.priorityLevel == priorityLevel) &&
            (identical(other.responseTimeHours, responseTimeHours) ||
                other.responseTimeHours == responseTimeHours) &&
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
      description,
      icon,
      color,
      department,
      priorityLevel,
      responseTimeHours,
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintCategoryModelImplCopyWith<_$ComplaintCategoryModelImpl>
      get copyWith => __$$ComplaintCategoryModelImplCopyWithImpl<
          _$ComplaintCategoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintCategoryModelImplToJson(
      this,
    );
  }
}

abstract class _ComplaintCategoryModel implements ComplaintCategoryModel {
  const factory _ComplaintCategoryModel(
          {required final int id,
          required final String name,
          final String? description,
          final String? icon,
          final String color,
          final String? department,
          @JsonKey(name: 'priority_level') final String priorityLevel,
          @JsonKey(name: 'response_time_hours') final int responseTimeHours,
          @JsonKey(name: 'is_active') final bool isActive,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$ComplaintCategoryModelImpl;

  factory _ComplaintCategoryModel.fromJson(Map<String, dynamic> json) =
      _$ComplaintCategoryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  String get color;
  @override
  String? get department;
  @override
  @JsonKey(name: 'priority_level')
  String get priorityLevel;
  @override
  @JsonKey(name: 'response_time_hours')
  int get responseTimeHours;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ComplaintCategoryModelImplCopyWith<_$ComplaintCategoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
