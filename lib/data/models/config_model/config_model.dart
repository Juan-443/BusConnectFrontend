
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
class ConfigModel with _$ConfigModel {
  const factory ConfigModel({
    required int id,
    required String key,
    required String value,
    String? description,
    String? updatedAt,
  }) = _ConfigModel;

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);
}

@freezed
class ConfigCreateRequest with _$ConfigCreateRequest {
  const factory ConfigCreateRequest({
    required String key,
    required String value,
    String? description,
  }) = _ConfigCreateRequest;

  factory ConfigCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfigCreateRequestFromJson(json);
}

@freezed
class ConfigUpdateRequest with _$ConfigUpdateRequest {
  const factory ConfigUpdateRequest({
    String? value,
    String? description,
  }) = _ConfigUpdateRequest;

  factory ConfigUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfigUpdateRequestFromJson(json);
}

typedef ConfigResponse = ConfigModel;