import 'package:json_annotation/json_annotation.dart';

/// Converter that handles boolean fields from Laravel API
/// Laravel returns booleans as "0"/"1" strings or actual booleans
class BoolConverter implements JsonConverter<bool, dynamic> {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) return json;
    if (json is String) {
      return json == '1' || json.toLowerCase() == 'true';
    }
    if (json is int) {
      return json == 1;
    }
    return false;
  }

  @override
  dynamic toJson(bool object) => object;
}