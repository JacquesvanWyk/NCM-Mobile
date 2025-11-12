// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_template_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SmsTemplate _$SmsTemplateFromJson(Map<String, dynamic> json) {
  return _SmsTemplate.fromJson(json);
}

/// @nodoc
mixin _$SmsTemplate {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get placeholders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmsTemplateCopyWith<SmsTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsTemplateCopyWith<$Res> {
  factory $SmsTemplateCopyWith(
          SmsTemplate value, $Res Function(SmsTemplate) then) =
      _$SmsTemplateCopyWithImpl<$Res, SmsTemplate>;
  @useResult
  $Res call({int id, String name, String content, List<String> placeholders});
}

/// @nodoc
class _$SmsTemplateCopyWithImpl<$Res, $Val extends SmsTemplate>
    implements $SmsTemplateCopyWith<$Res> {
  _$SmsTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? content = null,
    Object? placeholders = null,
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      placeholders: null == placeholders
          ? _value.placeholders
          : placeholders // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsTemplateImplCopyWith<$Res>
    implements $SmsTemplateCopyWith<$Res> {
  factory _$$SmsTemplateImplCopyWith(
          _$SmsTemplateImpl value, $Res Function(_$SmsTemplateImpl) then) =
      __$$SmsTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String content, List<String> placeholders});
}

/// @nodoc
class __$$SmsTemplateImplCopyWithImpl<$Res>
    extends _$SmsTemplateCopyWithImpl<$Res, _$SmsTemplateImpl>
    implements _$$SmsTemplateImplCopyWith<$Res> {
  __$$SmsTemplateImplCopyWithImpl(
      _$SmsTemplateImpl _value, $Res Function(_$SmsTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? content = null,
    Object? placeholders = null,
  }) {
    return _then(_$SmsTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      placeholders: null == placeholders
          ? _value._placeholders
          : placeholders // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsTemplateImpl implements _SmsTemplate {
  const _$SmsTemplateImpl(
      {required this.id,
      required this.name,
      required this.content,
      required final List<String> placeholders})
      : _placeholders = placeholders;

  factory _$SmsTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsTemplateImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String content;
  final List<String> _placeholders;
  @override
  List<String> get placeholders {
    if (_placeholders is EqualUnmodifiableListView) return _placeholders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_placeholders);
  }

  @override
  String toString() {
    return 'SmsTemplate(id: $id, name: $name, content: $content, placeholders: $placeholders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._placeholders, _placeholders));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, content,
      const DeepCollectionEquality().hash(_placeholders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsTemplateImplCopyWith<_$SmsTemplateImpl> get copyWith =>
      __$$SmsTemplateImplCopyWithImpl<_$SmsTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsTemplateImplToJson(
      this,
    );
  }
}

abstract class _SmsTemplate implements SmsTemplate {
  const factory _SmsTemplate(
      {required final int id,
      required final String name,
      required final String content,
      required final List<String> placeholders}) = _$SmsTemplateImpl;

  factory _SmsTemplate.fromJson(Map<String, dynamic> json) =
      _$SmsTemplateImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get content;
  @override
  List<String> get placeholders;
  @override
  @JsonKey(ignore: true)
  _$$SmsTemplateImplCopyWith<_$SmsTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
