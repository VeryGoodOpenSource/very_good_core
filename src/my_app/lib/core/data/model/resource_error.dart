import 'package:json_annotation/json_annotation.dart';

part 'resource_error.g.dart';

@JsonSerializable()
class ResourceError {
  ResourceError(this.type, this.message);
  final String type;
  final String message;

  static const ResourceError Function(Map<String, dynamic> json)
      fromJsonFactory = _$ResourceErrorFromJson;

  Map<String, dynamic> toJson() => _$ResourceErrorToJson(this);
}
