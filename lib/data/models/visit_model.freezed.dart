// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitModel _$VisitModelFromJson(Map<String, dynamic> json) {
  return _VisitModel.fromJson(json);
}

/// @nodoc
mixin _$VisitModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  int get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'field_worker_id')
  int? get fieldWorkerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'leader_id')
  int? get leaderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'municipality_id')
  int? get municipalityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'visit_type')
  String get visitType => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_date')
  DateTime? get scheduledDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_date')
  DateTime? get actualDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'visit_date')
  DateTime? get visitDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_latitude')
  double? get locationLatitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_longitude')
  double? get locationLongitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_address')
  String? get locationAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentiment_score')
  int? get sentimentScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_satisfaction')
  String? get memberSatisfaction => throw _privateConstructorUsedError;
  @JsonKey(name: 'issues_identified')
  List<String>? get issuesIdentified => throw _privateConstructorUsedError;
  @JsonKey(name: 'follow_up_required')
  bool get followUpRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'follow_up_date')
  DateTime? get followUpDate => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get purpose => throw _privateConstructorUsedError;
  String? get outcome => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Relationships
  MemberModel? get member => throw _privateConstructorUsedError;
  LeaderModel? get leader => throw _privateConstructorUsedError;
  @JsonKey(name: 'field_worker')
  dynamic get fieldWorker => throw _privateConstructorUsedError;
  MunicipalityModel? get municipality => throw _privateConstructorUsedError;
  @JsonKey(name: 'visit_notes')
  List<VisitNoteModel>? get visitNotes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitModelCopyWith<VisitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitModelCopyWith<$Res> {
  factory $VisitModelCopyWith(
          VisitModel value, $Res Function(VisitModel) then) =
      _$VisitModelCopyWithImpl<$Res, VisitModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'member_id') int memberId,
      @JsonKey(name: 'field_worker_id') int? fieldWorkerId,
      @JsonKey(name: 'leader_id') int? leaderId,
      @JsonKey(name: 'municipality_id') int? municipalityId,
      @JsonKey(name: 'visit_type') String visitType,
      @JsonKey(name: 'scheduled_date') DateTime? scheduledDate,
      @JsonKey(name: 'actual_date') DateTime? actualDate,
      @JsonKey(name: 'visit_date') DateTime? visitDate,
      @JsonKey(name: 'duration_minutes') int? durationMinutes,
      @JsonKey(name: 'location_latitude') double? locationLatitude,
      @JsonKey(name: 'location_longitude') double? locationLongitude,
      @JsonKey(name: 'location_address') String? locationAddress,
      @JsonKey(name: 'sentiment_score') int? sentimentScore,
      @JsonKey(name: 'member_satisfaction') String? memberSatisfaction,
      @JsonKey(name: 'issues_identified') List<String>? issuesIdentified,
      @JsonKey(name: 'follow_up_required') bool followUpRequired,
      @JsonKey(name: 'follow_up_date') DateTime? followUpDate,
      String? summary,
      String? purpose,
      String? outcome,
      String? notes,
      String status,
      String priority,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      MemberModel? member,
      LeaderModel? leader,
      @JsonKey(name: 'field_worker') dynamic fieldWorker,
      MunicipalityModel? municipality,
      @JsonKey(name: 'visit_notes') List<VisitNoteModel>? visitNotes});

  $MemberModelCopyWith<$Res>? get member;
  $LeaderModelCopyWith<$Res>? get leader;
  $MunicipalityModelCopyWith<$Res>? get municipality;
}

/// @nodoc
class _$VisitModelCopyWithImpl<$Res, $Val extends VisitModel>
    implements $VisitModelCopyWith<$Res> {
  _$VisitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = null,
    Object? fieldWorkerId = freezed,
    Object? leaderId = freezed,
    Object? municipalityId = freezed,
    Object? visitType = null,
    Object? scheduledDate = freezed,
    Object? actualDate = freezed,
    Object? visitDate = freezed,
    Object? durationMinutes = freezed,
    Object? locationLatitude = freezed,
    Object? locationLongitude = freezed,
    Object? locationAddress = freezed,
    Object? sentimentScore = freezed,
    Object? memberSatisfaction = freezed,
    Object? issuesIdentified = freezed,
    Object? followUpRequired = null,
    Object? followUpDate = freezed,
    Object? summary = freezed,
    Object? purpose = freezed,
    Object? outcome = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? priority = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? member = freezed,
    Object? leader = freezed,
    Object? fieldWorker = freezed,
    Object? municipality = freezed,
    Object? visitNotes = freezed,
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
      fieldWorkerId: freezed == fieldWorkerId
          ? _value.fieldWorkerId
          : fieldWorkerId // ignore: cast_nullable_to_non_nullable
              as int?,
      leaderId: freezed == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
      visitType: null == visitType
          ? _value.visitType
          : visitType // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualDate: freezed == actualDate
          ? _value.actualDate
          : actualDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      visitDate: freezed == visitDate
          ? _value.visitDate
          : visitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      locationLatitude: freezed == locationLatitude
          ? _value.locationLatitude
          : locationLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationLongitude: freezed == locationLongitude
          ? _value.locationLongitude
          : locationLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationAddress: freezed == locationAddress
          ? _value.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      sentimentScore: freezed == sentimentScore
          ? _value.sentimentScore
          : sentimentScore // ignore: cast_nullable_to_non_nullable
              as int?,
      memberSatisfaction: freezed == memberSatisfaction
          ? _value.memberSatisfaction
          : memberSatisfaction // ignore: cast_nullable_to_non_nullable
              as String?,
      issuesIdentified: freezed == issuesIdentified
          ? _value.issuesIdentified
          : issuesIdentified // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      followUpRequired: null == followUpRequired
          ? _value.followUpRequired
          : followUpRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      followUpDate: freezed == followUpDate
          ? _value.followUpDate
          : followUpDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      purpose: freezed == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String?,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
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
      leader: freezed == leader
          ? _value.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as LeaderModel?,
      fieldWorker: freezed == fieldWorker
          ? _value.fieldWorker
          : fieldWorker // ignore: cast_nullable_to_non_nullable
              as dynamic,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as MunicipalityModel?,
      visitNotes: freezed == visitNotes
          ? _value.visitNotes
          : visitNotes // ignore: cast_nullable_to_non_nullable
              as List<VisitNoteModel>?,
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
abstract class _$$VisitModelImplCopyWith<$Res>
    implements $VisitModelCopyWith<$Res> {
  factory _$$VisitModelImplCopyWith(
          _$VisitModelImpl value, $Res Function(_$VisitModelImpl) then) =
      __$$VisitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'member_id') int memberId,
      @JsonKey(name: 'field_worker_id') int? fieldWorkerId,
      @JsonKey(name: 'leader_id') int? leaderId,
      @JsonKey(name: 'municipality_id') int? municipalityId,
      @JsonKey(name: 'visit_type') String visitType,
      @JsonKey(name: 'scheduled_date') DateTime? scheduledDate,
      @JsonKey(name: 'actual_date') DateTime? actualDate,
      @JsonKey(name: 'visit_date') DateTime? visitDate,
      @JsonKey(name: 'duration_minutes') int? durationMinutes,
      @JsonKey(name: 'location_latitude') double? locationLatitude,
      @JsonKey(name: 'location_longitude') double? locationLongitude,
      @JsonKey(name: 'location_address') String? locationAddress,
      @JsonKey(name: 'sentiment_score') int? sentimentScore,
      @JsonKey(name: 'member_satisfaction') String? memberSatisfaction,
      @JsonKey(name: 'issues_identified') List<String>? issuesIdentified,
      @JsonKey(name: 'follow_up_required') bool followUpRequired,
      @JsonKey(name: 'follow_up_date') DateTime? followUpDate,
      String? summary,
      String? purpose,
      String? outcome,
      String? notes,
      String status,
      String priority,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      MemberModel? member,
      LeaderModel? leader,
      @JsonKey(name: 'field_worker') dynamic fieldWorker,
      MunicipalityModel? municipality,
      @JsonKey(name: 'visit_notes') List<VisitNoteModel>? visitNotes});

  @override
  $MemberModelCopyWith<$Res>? get member;
  @override
  $LeaderModelCopyWith<$Res>? get leader;
  @override
  $MunicipalityModelCopyWith<$Res>? get municipality;
}

/// @nodoc
class __$$VisitModelImplCopyWithImpl<$Res>
    extends _$VisitModelCopyWithImpl<$Res, _$VisitModelImpl>
    implements _$$VisitModelImplCopyWith<$Res> {
  __$$VisitModelImplCopyWithImpl(
      _$VisitModelImpl _value, $Res Function(_$VisitModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = null,
    Object? fieldWorkerId = freezed,
    Object? leaderId = freezed,
    Object? municipalityId = freezed,
    Object? visitType = null,
    Object? scheduledDate = freezed,
    Object? actualDate = freezed,
    Object? visitDate = freezed,
    Object? durationMinutes = freezed,
    Object? locationLatitude = freezed,
    Object? locationLongitude = freezed,
    Object? locationAddress = freezed,
    Object? sentimentScore = freezed,
    Object? memberSatisfaction = freezed,
    Object? issuesIdentified = freezed,
    Object? followUpRequired = null,
    Object? followUpDate = freezed,
    Object? summary = freezed,
    Object? purpose = freezed,
    Object? outcome = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? priority = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? member = freezed,
    Object? leader = freezed,
    Object? fieldWorker = freezed,
    Object? municipality = freezed,
    Object? visitNotes = freezed,
  }) {
    return _then(_$VisitModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      fieldWorkerId: freezed == fieldWorkerId
          ? _value.fieldWorkerId
          : fieldWorkerId // ignore: cast_nullable_to_non_nullable
              as int?,
      leaderId: freezed == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as int?,
      municipalityId: freezed == municipalityId
          ? _value.municipalityId
          : municipalityId // ignore: cast_nullable_to_non_nullable
              as int?,
      visitType: null == visitType
          ? _value.visitType
          : visitType // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualDate: freezed == actualDate
          ? _value.actualDate
          : actualDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      visitDate: freezed == visitDate
          ? _value.visitDate
          : visitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      locationLatitude: freezed == locationLatitude
          ? _value.locationLatitude
          : locationLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationLongitude: freezed == locationLongitude
          ? _value.locationLongitude
          : locationLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locationAddress: freezed == locationAddress
          ? _value.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      sentimentScore: freezed == sentimentScore
          ? _value.sentimentScore
          : sentimentScore // ignore: cast_nullable_to_non_nullable
              as int?,
      memberSatisfaction: freezed == memberSatisfaction
          ? _value.memberSatisfaction
          : memberSatisfaction // ignore: cast_nullable_to_non_nullable
              as String?,
      issuesIdentified: freezed == issuesIdentified
          ? _value._issuesIdentified
          : issuesIdentified // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      followUpRequired: null == followUpRequired
          ? _value.followUpRequired
          : followUpRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      followUpDate: freezed == followUpDate
          ? _value.followUpDate
          : followUpDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      purpose: freezed == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String?,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
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
      leader: freezed == leader
          ? _value.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as LeaderModel?,
      fieldWorker: freezed == fieldWorker
          ? _value.fieldWorker
          : fieldWorker // ignore: cast_nullable_to_non_nullable
              as dynamic,
      municipality: freezed == municipality
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as MunicipalityModel?,
      visitNotes: freezed == visitNotes
          ? _value._visitNotes
          : visitNotes // ignore: cast_nullable_to_non_nullable
              as List<VisitNoteModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitModelImpl implements _VisitModel {
  const _$VisitModelImpl(
      {required this.id,
      @JsonKey(name: 'member_id') this.memberId = 0,
      @JsonKey(name: 'field_worker_id') this.fieldWorkerId,
      @JsonKey(name: 'leader_id') this.leaderId,
      @JsonKey(name: 'municipality_id') this.municipalityId,
      @JsonKey(name: 'visit_type') this.visitType = 'Door-to-Door',
      @JsonKey(name: 'scheduled_date') this.scheduledDate,
      @JsonKey(name: 'actual_date') this.actualDate,
      @JsonKey(name: 'visit_date') this.visitDate,
      @JsonKey(name: 'duration_minutes') this.durationMinutes,
      @JsonKey(name: 'location_latitude') this.locationLatitude,
      @JsonKey(name: 'location_longitude') this.locationLongitude,
      @JsonKey(name: 'location_address') this.locationAddress,
      @JsonKey(name: 'sentiment_score') this.sentimentScore,
      @JsonKey(name: 'member_satisfaction') this.memberSatisfaction,
      @JsonKey(name: 'issues_identified') final List<String>? issuesIdentified,
      @JsonKey(name: 'follow_up_required') this.followUpRequired = false,
      @JsonKey(name: 'follow_up_date') this.followUpDate,
      this.summary,
      this.purpose,
      this.outcome,
      this.notes,
      this.status = 'scheduled',
      this.priority = 'medium',
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.member,
      this.leader,
      @JsonKey(name: 'field_worker') this.fieldWorker,
      this.municipality,
      @JsonKey(name: 'visit_notes') final List<VisitNoteModel>? visitNotes})
      : _issuesIdentified = issuesIdentified,
        _visitNotes = visitNotes;

  factory _$VisitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'member_id')
  final int memberId;
  @override
  @JsonKey(name: 'field_worker_id')
  final int? fieldWorkerId;
  @override
  @JsonKey(name: 'leader_id')
  final int? leaderId;
  @override
  @JsonKey(name: 'municipality_id')
  final int? municipalityId;
  @override
  @JsonKey(name: 'visit_type')
  final String visitType;
  @override
  @JsonKey(name: 'scheduled_date')
  final DateTime? scheduledDate;
  @override
  @JsonKey(name: 'actual_date')
  final DateTime? actualDate;
  @override
  @JsonKey(name: 'visit_date')
  final DateTime? visitDate;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  @JsonKey(name: 'location_latitude')
  final double? locationLatitude;
  @override
  @JsonKey(name: 'location_longitude')
  final double? locationLongitude;
  @override
  @JsonKey(name: 'location_address')
  final String? locationAddress;
  @override
  @JsonKey(name: 'sentiment_score')
  final int? sentimentScore;
  @override
  @JsonKey(name: 'member_satisfaction')
  final String? memberSatisfaction;
  final List<String>? _issuesIdentified;
  @override
  @JsonKey(name: 'issues_identified')
  List<String>? get issuesIdentified {
    final value = _issuesIdentified;
    if (value == null) return null;
    if (_issuesIdentified is EqualUnmodifiableListView)
      return _issuesIdentified;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'follow_up_required')
  final bool followUpRequired;
  @override
  @JsonKey(name: 'follow_up_date')
  final DateTime? followUpDate;
  @override
  final String? summary;
  @override
  final String? purpose;
  @override
  final String? outcome;
  @override
  final String? notes;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String priority;
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
  final LeaderModel? leader;
  @override
  @JsonKey(name: 'field_worker')
  final dynamic fieldWorker;
  @override
  final MunicipalityModel? municipality;
  final List<VisitNoteModel>? _visitNotes;
  @override
  @JsonKey(name: 'visit_notes')
  List<VisitNoteModel>? get visitNotes {
    final value = _visitNotes;
    if (value == null) return null;
    if (_visitNotes is EqualUnmodifiableListView) return _visitNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VisitModel(id: $id, memberId: $memberId, fieldWorkerId: $fieldWorkerId, leaderId: $leaderId, municipalityId: $municipalityId, visitType: $visitType, scheduledDate: $scheduledDate, actualDate: $actualDate, visitDate: $visitDate, durationMinutes: $durationMinutes, locationLatitude: $locationLatitude, locationLongitude: $locationLongitude, locationAddress: $locationAddress, sentimentScore: $sentimentScore, memberSatisfaction: $memberSatisfaction, issuesIdentified: $issuesIdentified, followUpRequired: $followUpRequired, followUpDate: $followUpDate, summary: $summary, purpose: $purpose, outcome: $outcome, notes: $notes, status: $status, priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt, member: $member, leader: $leader, fieldWorker: $fieldWorker, municipality: $municipality, visitNotes: $visitNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.fieldWorkerId, fieldWorkerId) ||
                other.fieldWorkerId == fieldWorkerId) &&
            (identical(other.leaderId, leaderId) ||
                other.leaderId == leaderId) &&
            (identical(other.municipalityId, municipalityId) ||
                other.municipalityId == municipalityId) &&
            (identical(other.visitType, visitType) ||
                other.visitType == visitType) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.actualDate, actualDate) ||
                other.actualDate == actualDate) &&
            (identical(other.visitDate, visitDate) ||
                other.visitDate == visitDate) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.locationLatitude, locationLatitude) ||
                other.locationLatitude == locationLatitude) &&
            (identical(other.locationLongitude, locationLongitude) ||
                other.locationLongitude == locationLongitude) &&
            (identical(other.locationAddress, locationAddress) ||
                other.locationAddress == locationAddress) &&
            (identical(other.sentimentScore, sentimentScore) ||
                other.sentimentScore == sentimentScore) &&
            (identical(other.memberSatisfaction, memberSatisfaction) ||
                other.memberSatisfaction == memberSatisfaction) &&
            const DeepCollectionEquality()
                .equals(other._issuesIdentified, _issuesIdentified) &&
            (identical(other.followUpRequired, followUpRequired) ||
                other.followUpRequired == followUpRequired) &&
            (identical(other.followUpDate, followUpDate) ||
                other.followUpDate == followUpDate) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.leader, leader) || other.leader == leader) &&
            const DeepCollectionEquality()
                .equals(other.fieldWorker, fieldWorker) &&
            (identical(other.municipality, municipality) ||
                other.municipality == municipality) &&
            const DeepCollectionEquality()
                .equals(other._visitNotes, _visitNotes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        memberId,
        fieldWorkerId,
        leaderId,
        municipalityId,
        visitType,
        scheduledDate,
        actualDate,
        visitDate,
        durationMinutes,
        locationLatitude,
        locationLongitude,
        locationAddress,
        sentimentScore,
        memberSatisfaction,
        const DeepCollectionEquality().hash(_issuesIdentified),
        followUpRequired,
        followUpDate,
        summary,
        purpose,
        outcome,
        notes,
        status,
        priority,
        createdAt,
        updatedAt,
        member,
        leader,
        const DeepCollectionEquality().hash(fieldWorker),
        municipality,
        const DeepCollectionEquality().hash(_visitNotes)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitModelImplCopyWith<_$VisitModelImpl> get copyWith =>
      __$$VisitModelImplCopyWithImpl<_$VisitModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitModelImplToJson(
      this,
    );
  }
}

abstract class _VisitModel implements VisitModel {
  const factory _VisitModel(
      {required final int id,
      @JsonKey(name: 'member_id') final int memberId,
      @JsonKey(name: 'field_worker_id') final int? fieldWorkerId,
      @JsonKey(name: 'leader_id') final int? leaderId,
      @JsonKey(name: 'municipality_id') final int? municipalityId,
      @JsonKey(name: 'visit_type') final String visitType,
      @JsonKey(name: 'scheduled_date') final DateTime? scheduledDate,
      @JsonKey(name: 'actual_date') final DateTime? actualDate,
      @JsonKey(name: 'visit_date') final DateTime? visitDate,
      @JsonKey(name: 'duration_minutes') final int? durationMinutes,
      @JsonKey(name: 'location_latitude') final double? locationLatitude,
      @JsonKey(name: 'location_longitude') final double? locationLongitude,
      @JsonKey(name: 'location_address') final String? locationAddress,
      @JsonKey(name: 'sentiment_score') final int? sentimentScore,
      @JsonKey(name: 'member_satisfaction') final String? memberSatisfaction,
      @JsonKey(name: 'issues_identified') final List<String>? issuesIdentified,
      @JsonKey(name: 'follow_up_required') final bool followUpRequired,
      @JsonKey(name: 'follow_up_date') final DateTime? followUpDate,
      final String? summary,
      final String? purpose,
      final String? outcome,
      final String? notes,
      final String status,
      final String priority,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final MemberModel? member,
      final LeaderModel? leader,
      @JsonKey(name: 'field_worker') final dynamic fieldWorker,
      final MunicipalityModel? municipality,
      @JsonKey(name: 'visit_notes')
      final List<VisitNoteModel>? visitNotes}) = _$VisitModelImpl;

  factory _VisitModel.fromJson(Map<String, dynamic> json) =
      _$VisitModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'member_id')
  int get memberId;
  @override
  @JsonKey(name: 'field_worker_id')
  int? get fieldWorkerId;
  @override
  @JsonKey(name: 'leader_id')
  int? get leaderId;
  @override
  @JsonKey(name: 'municipality_id')
  int? get municipalityId;
  @override
  @JsonKey(name: 'visit_type')
  String get visitType;
  @override
  @JsonKey(name: 'scheduled_date')
  DateTime? get scheduledDate;
  @override
  @JsonKey(name: 'actual_date')
  DateTime? get actualDate;
  @override
  @JsonKey(name: 'visit_date')
  DateTime? get visitDate;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  @JsonKey(name: 'location_latitude')
  double? get locationLatitude;
  @override
  @JsonKey(name: 'location_longitude')
  double? get locationLongitude;
  @override
  @JsonKey(name: 'location_address')
  String? get locationAddress;
  @override
  @JsonKey(name: 'sentiment_score')
  int? get sentimentScore;
  @override
  @JsonKey(name: 'member_satisfaction')
  String? get memberSatisfaction;
  @override
  @JsonKey(name: 'issues_identified')
  List<String>? get issuesIdentified;
  @override
  @JsonKey(name: 'follow_up_required')
  bool get followUpRequired;
  @override
  @JsonKey(name: 'follow_up_date')
  DateTime? get followUpDate;
  @override
  String? get summary;
  @override
  String? get purpose;
  @override
  String? get outcome;
  @override
  String? get notes;
  @override
  String get status;
  @override
  String get priority;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override // Relationships
  MemberModel? get member;
  @override
  LeaderModel? get leader;
  @override
  @JsonKey(name: 'field_worker')
  dynamic get fieldWorker;
  @override
  MunicipalityModel? get municipality;
  @override
  @JsonKey(name: 'visit_notes')
  List<VisitNoteModel>? get visitNotes;
  @override
  @JsonKey(ignore: true)
  _$$VisitModelImplCopyWith<_$VisitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VisitNoteModel _$VisitNoteModelFromJson(Map<String, dynamic> json) {
  return _VisitNoteModel.fromJson(json);
}

/// @nodoc
mixin _$VisitNoteModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'visit_id')
  int get visitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'field_worker_id')
  int get fieldWorkerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'note_type')
  String get noteType => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_private')
  bool get isPrivate => throw _privateConstructorUsedError;
  List<String>? get attachments => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitNoteModelCopyWith<VisitNoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitNoteModelCopyWith<$Res> {
  factory $VisitNoteModelCopyWith(
          VisitNoteModel value, $Res Function(VisitNoteModel) then) =
      _$VisitNoteModelCopyWithImpl<$Res, VisitNoteModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'visit_id') int visitId,
      @JsonKey(name: 'field_worker_id') int fieldWorkerId,
      @JsonKey(name: 'note_type') String noteType,
      String content,
      @JsonKey(name: 'is_private') bool isPrivate,
      List<String>? attachments,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$VisitNoteModelCopyWithImpl<$Res, $Val extends VisitNoteModel>
    implements $VisitNoteModelCopyWith<$Res> {
  _$VisitNoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitId = null,
    Object? fieldWorkerId = null,
    Object? noteType = null,
    Object? content = null,
    Object? isPrivate = null,
    Object? attachments = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      visitId: null == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as int,
      fieldWorkerId: null == fieldWorkerId
          ? _value.fieldWorkerId
          : fieldWorkerId // ignore: cast_nullable_to_non_nullable
              as int,
      noteType: null == noteType
          ? _value.noteType
          : noteType // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$VisitNoteModelImplCopyWith<$Res>
    implements $VisitNoteModelCopyWith<$Res> {
  factory _$$VisitNoteModelImplCopyWith(_$VisitNoteModelImpl value,
          $Res Function(_$VisitNoteModelImpl) then) =
      __$$VisitNoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'visit_id') int visitId,
      @JsonKey(name: 'field_worker_id') int fieldWorkerId,
      @JsonKey(name: 'note_type') String noteType,
      String content,
      @JsonKey(name: 'is_private') bool isPrivate,
      List<String>? attachments,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$VisitNoteModelImplCopyWithImpl<$Res>
    extends _$VisitNoteModelCopyWithImpl<$Res, _$VisitNoteModelImpl>
    implements _$$VisitNoteModelImplCopyWith<$Res> {
  __$$VisitNoteModelImplCopyWithImpl(
      _$VisitNoteModelImpl _value, $Res Function(_$VisitNoteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitId = null,
    Object? fieldWorkerId = null,
    Object? noteType = null,
    Object? content = null,
    Object? isPrivate = null,
    Object? attachments = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$VisitNoteModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      visitId: null == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as int,
      fieldWorkerId: null == fieldWorkerId
          ? _value.fieldWorkerId
          : fieldWorkerId // ignore: cast_nullable_to_non_nullable
              as int,
      noteType: null == noteType
          ? _value.noteType
          : noteType // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
class _$VisitNoteModelImpl implements _VisitNoteModel {
  const _$VisitNoteModelImpl(
      {this.id = 0,
      @JsonKey(name: 'visit_id') this.visitId = 0,
      @JsonKey(name: 'field_worker_id') this.fieldWorkerId = 0,
      @JsonKey(name: 'note_type') this.noteType = 'General',
      this.content = '',
      @JsonKey(name: 'is_private') this.isPrivate = false,
      final List<String>? attachments,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _attachments = attachments;

  factory _$VisitNoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitNoteModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'visit_id')
  final int visitId;
  @override
  @JsonKey(name: 'field_worker_id')
  final int fieldWorkerId;
  @override
  @JsonKey(name: 'note_type')
  final String noteType;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  final List<String>? _attachments;
  @override
  List<String>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'VisitNoteModel(id: $id, visitId: $visitId, fieldWorkerId: $fieldWorkerId, noteType: $noteType, content: $content, isPrivate: $isPrivate, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitNoteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visitId, visitId) || other.visitId == visitId) &&
            (identical(other.fieldWorkerId, fieldWorkerId) ||
                other.fieldWorkerId == fieldWorkerId) &&
            (identical(other.noteType, noteType) ||
                other.noteType == noteType) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
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
      visitId,
      fieldWorkerId,
      noteType,
      content,
      isPrivate,
      const DeepCollectionEquality().hash(_attachments),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitNoteModelImplCopyWith<_$VisitNoteModelImpl> get copyWith =>
      __$$VisitNoteModelImplCopyWithImpl<_$VisitNoteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitNoteModelImplToJson(
      this,
    );
  }
}

abstract class _VisitNoteModel implements VisitNoteModel {
  const factory _VisitNoteModel(
          {final int id,
          @JsonKey(name: 'visit_id') final int visitId,
          @JsonKey(name: 'field_worker_id') final int fieldWorkerId,
          @JsonKey(name: 'note_type') final String noteType,
          final String content,
          @JsonKey(name: 'is_private') final bool isPrivate,
          final List<String>? attachments,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$VisitNoteModelImpl;

  factory _VisitNoteModel.fromJson(Map<String, dynamic> json) =
      _$VisitNoteModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'visit_id')
  int get visitId;
  @override
  @JsonKey(name: 'field_worker_id')
  int get fieldWorkerId;
  @override
  @JsonKey(name: 'note_type')
  String get noteType;
  @override
  String get content;
  @override
  @JsonKey(name: 'is_private')
  bool get isPrivate;
  @override
  List<String>? get attachments;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$VisitNoteModelImplCopyWith<_$VisitNoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VisitStatsModel _$VisitStatsModelFromJson(Map<String, dynamic> json) {
  return _VisitStatsModel.fromJson(json);
}

/// @nodoc
mixin _$VisitStatsModel {
  @JsonKey(name: 'total_visits')
  int get totalVisits => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_sentiment')
  double? get averageSentiment => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentiment_distribution')
  List<SentimentDistribution>? get sentimentDistribution =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'satisfaction_distribution')
  List<SatisfactionDistribution>? get satisfactionDistribution =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitStatsModelCopyWith<VisitStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitStatsModelCopyWith<$Res> {
  factory $VisitStatsModelCopyWith(
          VisitStatsModel value, $Res Function(VisitStatsModel) then) =
      _$VisitStatsModelCopyWithImpl<$Res, VisitStatsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_visits') int totalVisits,
      @JsonKey(name: 'average_sentiment') double? averageSentiment,
      @JsonKey(name: 'sentiment_distribution')
      List<SentimentDistribution>? sentimentDistribution,
      @JsonKey(name: 'satisfaction_distribution')
      List<SatisfactionDistribution>? satisfactionDistribution});
}

/// @nodoc
class _$VisitStatsModelCopyWithImpl<$Res, $Val extends VisitStatsModel>
    implements $VisitStatsModelCopyWith<$Res> {
  _$VisitStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVisits = null,
    Object? averageSentiment = freezed,
    Object? sentimentDistribution = freezed,
    Object? satisfactionDistribution = freezed,
  }) {
    return _then(_value.copyWith(
      totalVisits: null == totalVisits
          ? _value.totalVisits
          : totalVisits // ignore: cast_nullable_to_non_nullable
              as int,
      averageSentiment: freezed == averageSentiment
          ? _value.averageSentiment
          : averageSentiment // ignore: cast_nullable_to_non_nullable
              as double?,
      sentimentDistribution: freezed == sentimentDistribution
          ? _value.sentimentDistribution
          : sentimentDistribution // ignore: cast_nullable_to_non_nullable
              as List<SentimentDistribution>?,
      satisfactionDistribution: freezed == satisfactionDistribution
          ? _value.satisfactionDistribution
          : satisfactionDistribution // ignore: cast_nullable_to_non_nullable
              as List<SatisfactionDistribution>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitStatsModelImplCopyWith<$Res>
    implements $VisitStatsModelCopyWith<$Res> {
  factory _$$VisitStatsModelImplCopyWith(_$VisitStatsModelImpl value,
          $Res Function(_$VisitStatsModelImpl) then) =
      __$$VisitStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_visits') int totalVisits,
      @JsonKey(name: 'average_sentiment') double? averageSentiment,
      @JsonKey(name: 'sentiment_distribution')
      List<SentimentDistribution>? sentimentDistribution,
      @JsonKey(name: 'satisfaction_distribution')
      List<SatisfactionDistribution>? satisfactionDistribution});
}

/// @nodoc
class __$$VisitStatsModelImplCopyWithImpl<$Res>
    extends _$VisitStatsModelCopyWithImpl<$Res, _$VisitStatsModelImpl>
    implements _$$VisitStatsModelImplCopyWith<$Res> {
  __$$VisitStatsModelImplCopyWithImpl(
      _$VisitStatsModelImpl _value, $Res Function(_$VisitStatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVisits = null,
    Object? averageSentiment = freezed,
    Object? sentimentDistribution = freezed,
    Object? satisfactionDistribution = freezed,
  }) {
    return _then(_$VisitStatsModelImpl(
      totalVisits: null == totalVisits
          ? _value.totalVisits
          : totalVisits // ignore: cast_nullable_to_non_nullable
              as int,
      averageSentiment: freezed == averageSentiment
          ? _value.averageSentiment
          : averageSentiment // ignore: cast_nullable_to_non_nullable
              as double?,
      sentimentDistribution: freezed == sentimentDistribution
          ? _value._sentimentDistribution
          : sentimentDistribution // ignore: cast_nullable_to_non_nullable
              as List<SentimentDistribution>?,
      satisfactionDistribution: freezed == satisfactionDistribution
          ? _value._satisfactionDistribution
          : satisfactionDistribution // ignore: cast_nullable_to_non_nullable
              as List<SatisfactionDistribution>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitStatsModelImpl implements _VisitStatsModel {
  const _$VisitStatsModelImpl(
      {@JsonKey(name: 'total_visits') required this.totalVisits,
      @JsonKey(name: 'average_sentiment') this.averageSentiment,
      @JsonKey(name: 'sentiment_distribution')
      final List<SentimentDistribution>? sentimentDistribution,
      @JsonKey(name: 'satisfaction_distribution')
      final List<SatisfactionDistribution>? satisfactionDistribution})
      : _sentimentDistribution = sentimentDistribution,
        _satisfactionDistribution = satisfactionDistribution;

  factory _$VisitStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitStatsModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_visits')
  final int totalVisits;
  @override
  @JsonKey(name: 'average_sentiment')
  final double? averageSentiment;
  final List<SentimentDistribution>? _sentimentDistribution;
  @override
  @JsonKey(name: 'sentiment_distribution')
  List<SentimentDistribution>? get sentimentDistribution {
    final value = _sentimentDistribution;
    if (value == null) return null;
    if (_sentimentDistribution is EqualUnmodifiableListView)
      return _sentimentDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SatisfactionDistribution>? _satisfactionDistribution;
  @override
  @JsonKey(name: 'satisfaction_distribution')
  List<SatisfactionDistribution>? get satisfactionDistribution {
    final value = _satisfactionDistribution;
    if (value == null) return null;
    if (_satisfactionDistribution is EqualUnmodifiableListView)
      return _satisfactionDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VisitStatsModel(totalVisits: $totalVisits, averageSentiment: $averageSentiment, sentimentDistribution: $sentimentDistribution, satisfactionDistribution: $satisfactionDistribution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitStatsModelImpl &&
            (identical(other.totalVisits, totalVisits) ||
                other.totalVisits == totalVisits) &&
            (identical(other.averageSentiment, averageSentiment) ||
                other.averageSentiment == averageSentiment) &&
            const DeepCollectionEquality()
                .equals(other._sentimentDistribution, _sentimentDistribution) &&
            const DeepCollectionEquality().equals(
                other._satisfactionDistribution, _satisfactionDistribution));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalVisits,
      averageSentiment,
      const DeepCollectionEquality().hash(_sentimentDistribution),
      const DeepCollectionEquality().hash(_satisfactionDistribution));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitStatsModelImplCopyWith<_$VisitStatsModelImpl> get copyWith =>
      __$$VisitStatsModelImplCopyWithImpl<_$VisitStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitStatsModelImplToJson(
      this,
    );
  }
}

abstract class _VisitStatsModel implements VisitStatsModel {
  const factory _VisitStatsModel(
          {@JsonKey(name: 'total_visits') required final int totalVisits,
          @JsonKey(name: 'average_sentiment') final double? averageSentiment,
          @JsonKey(name: 'sentiment_distribution')
          final List<SentimentDistribution>? sentimentDistribution,
          @JsonKey(name: 'satisfaction_distribution')
          final List<SatisfactionDistribution>? satisfactionDistribution}) =
      _$VisitStatsModelImpl;

  factory _VisitStatsModel.fromJson(Map<String, dynamic> json) =
      _$VisitStatsModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_visits')
  int get totalVisits;
  @override
  @JsonKey(name: 'average_sentiment')
  double? get averageSentiment;
  @override
  @JsonKey(name: 'sentiment_distribution')
  List<SentimentDistribution>? get sentimentDistribution;
  @override
  @JsonKey(name: 'satisfaction_distribution')
  List<SatisfactionDistribution>? get satisfactionDistribution;
  @override
  @JsonKey(ignore: true)
  _$$VisitStatsModelImplCopyWith<_$VisitStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SentimentDistribution _$SentimentDistributionFromJson(
    Map<String, dynamic> json) {
  return _SentimentDistribution.fromJson(json);
}

/// @nodoc
mixin _$SentimentDistribution {
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_score')
  double get avgScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentiment_category')
  String get sentimentCategory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SentimentDistributionCopyWith<SentimentDistribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentimentDistributionCopyWith<$Res> {
  factory $SentimentDistributionCopyWith(SentimentDistribution value,
          $Res Function(SentimentDistribution) then) =
      _$SentimentDistributionCopyWithImpl<$Res, SentimentDistribution>;
  @useResult
  $Res call(
      {int total,
      @JsonKey(name: 'avg_score') double avgScore,
      @JsonKey(name: 'sentiment_category') String sentimentCategory});
}

/// @nodoc
class _$SentimentDistributionCopyWithImpl<$Res,
        $Val extends SentimentDistribution>
    implements $SentimentDistributionCopyWith<$Res> {
  _$SentimentDistributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? avgScore = null,
    Object? sentimentCategory = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      avgScore: null == avgScore
          ? _value.avgScore
          : avgScore // ignore: cast_nullable_to_non_nullable
              as double,
      sentimentCategory: null == sentimentCategory
          ? _value.sentimentCategory
          : sentimentCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentimentDistributionImplCopyWith<$Res>
    implements $SentimentDistributionCopyWith<$Res> {
  factory _$$SentimentDistributionImplCopyWith(
          _$SentimentDistributionImpl value,
          $Res Function(_$SentimentDistributionImpl) then) =
      __$$SentimentDistributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      @JsonKey(name: 'avg_score') double avgScore,
      @JsonKey(name: 'sentiment_category') String sentimentCategory});
}

/// @nodoc
class __$$SentimentDistributionImplCopyWithImpl<$Res>
    extends _$SentimentDistributionCopyWithImpl<$Res,
        _$SentimentDistributionImpl>
    implements _$$SentimentDistributionImplCopyWith<$Res> {
  __$$SentimentDistributionImplCopyWithImpl(_$SentimentDistributionImpl _value,
      $Res Function(_$SentimentDistributionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? avgScore = null,
    Object? sentimentCategory = null,
  }) {
    return _then(_$SentimentDistributionImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      avgScore: null == avgScore
          ? _value.avgScore
          : avgScore // ignore: cast_nullable_to_non_nullable
              as double,
      sentimentCategory: null == sentimentCategory
          ? _value.sentimentCategory
          : sentimentCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentimentDistributionImpl implements _SentimentDistribution {
  const _$SentimentDistributionImpl(
      {required this.total,
      @JsonKey(name: 'avg_score') required this.avgScore,
      @JsonKey(name: 'sentiment_category') required this.sentimentCategory});

  factory _$SentimentDistributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentimentDistributionImplFromJson(json);

  @override
  final int total;
  @override
  @JsonKey(name: 'avg_score')
  final double avgScore;
  @override
  @JsonKey(name: 'sentiment_category')
  final String sentimentCategory;

  @override
  String toString() {
    return 'SentimentDistribution(total: $total, avgScore: $avgScore, sentimentCategory: $sentimentCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentimentDistributionImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.avgScore, avgScore) ||
                other.avgScore == avgScore) &&
            (identical(other.sentimentCategory, sentimentCategory) ||
                other.sentimentCategory == sentimentCategory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, total, avgScore, sentimentCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentimentDistributionImplCopyWith<_$SentimentDistributionImpl>
      get copyWith => __$$SentimentDistributionImplCopyWithImpl<
          _$SentimentDistributionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentimentDistributionImplToJson(
      this,
    );
  }
}

abstract class _SentimentDistribution implements SentimentDistribution {
  const factory _SentimentDistribution(
      {required final int total,
      @JsonKey(name: 'avg_score') required final double avgScore,
      @JsonKey(name: 'sentiment_category')
      required final String sentimentCategory}) = _$SentimentDistributionImpl;

  factory _SentimentDistribution.fromJson(Map<String, dynamic> json) =
      _$SentimentDistributionImpl.fromJson;

  @override
  int get total;
  @override
  @JsonKey(name: 'avg_score')
  double get avgScore;
  @override
  @JsonKey(name: 'sentiment_category')
  String get sentimentCategory;
  @override
  @JsonKey(ignore: true)
  _$$SentimentDistributionImplCopyWith<_$SentimentDistributionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SatisfactionDistribution _$SatisfactionDistributionFromJson(
    Map<String, dynamic> json) {
  return _SatisfactionDistribution.fromJson(json);
}

/// @nodoc
mixin _$SatisfactionDistribution {
  @JsonKey(name: 'member_satisfaction')
  String get memberSatisfaction => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SatisfactionDistributionCopyWith<SatisfactionDistribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SatisfactionDistributionCopyWith<$Res> {
  factory $SatisfactionDistributionCopyWith(SatisfactionDistribution value,
          $Res Function(SatisfactionDistribution) then) =
      _$SatisfactionDistributionCopyWithImpl<$Res, SatisfactionDistribution>;
  @useResult
  $Res call(
      {@JsonKey(name: 'member_satisfaction') String memberSatisfaction,
      int count});
}

/// @nodoc
class _$SatisfactionDistributionCopyWithImpl<$Res,
        $Val extends SatisfactionDistribution>
    implements $SatisfactionDistributionCopyWith<$Res> {
  _$SatisfactionDistributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberSatisfaction = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      memberSatisfaction: null == memberSatisfaction
          ? _value.memberSatisfaction
          : memberSatisfaction // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SatisfactionDistributionImplCopyWith<$Res>
    implements $SatisfactionDistributionCopyWith<$Res> {
  factory _$$SatisfactionDistributionImplCopyWith(
          _$SatisfactionDistributionImpl value,
          $Res Function(_$SatisfactionDistributionImpl) then) =
      __$$SatisfactionDistributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'member_satisfaction') String memberSatisfaction,
      int count});
}

/// @nodoc
class __$$SatisfactionDistributionImplCopyWithImpl<$Res>
    extends _$SatisfactionDistributionCopyWithImpl<$Res,
        _$SatisfactionDistributionImpl>
    implements _$$SatisfactionDistributionImplCopyWith<$Res> {
  __$$SatisfactionDistributionImplCopyWithImpl(
      _$SatisfactionDistributionImpl _value,
      $Res Function(_$SatisfactionDistributionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberSatisfaction = null,
    Object? count = null,
  }) {
    return _then(_$SatisfactionDistributionImpl(
      memberSatisfaction: null == memberSatisfaction
          ? _value.memberSatisfaction
          : memberSatisfaction // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SatisfactionDistributionImpl implements _SatisfactionDistribution {
  const _$SatisfactionDistributionImpl(
      {@JsonKey(name: 'member_satisfaction') required this.memberSatisfaction,
      required this.count});

  factory _$SatisfactionDistributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SatisfactionDistributionImplFromJson(json);

  @override
  @JsonKey(name: 'member_satisfaction')
  final String memberSatisfaction;
  @override
  final int count;

  @override
  String toString() {
    return 'SatisfactionDistribution(memberSatisfaction: $memberSatisfaction, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfactionDistributionImpl &&
            (identical(other.memberSatisfaction, memberSatisfaction) ||
                other.memberSatisfaction == memberSatisfaction) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, memberSatisfaction, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfactionDistributionImplCopyWith<_$SatisfactionDistributionImpl>
      get copyWith => __$$SatisfactionDistributionImplCopyWithImpl<
          _$SatisfactionDistributionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SatisfactionDistributionImplToJson(
      this,
    );
  }
}

abstract class _SatisfactionDistribution implements SatisfactionDistribution {
  const factory _SatisfactionDistribution(
      {@JsonKey(name: 'member_satisfaction')
      required final String memberSatisfaction,
      required final int count}) = _$SatisfactionDistributionImpl;

  factory _SatisfactionDistribution.fromJson(Map<String, dynamic> json) =
      _$SatisfactionDistributionImpl.fromJson;

  @override
  @JsonKey(name: 'member_satisfaction')
  String get memberSatisfaction;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$SatisfactionDistributionImplCopyWith<_$SatisfactionDistributionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
