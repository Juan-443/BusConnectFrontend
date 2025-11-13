// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigModelImpl _$$ConfigModelImplFromJson(Map<String, dynamic> json) =>
    _$ConfigModelImpl(
      id: (json['id'] as num).toInt(),
      key: json['key'] as String,
      value: json['value'] as String,
      description: json['description'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$ConfigModelImplToJson(_$ConfigModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
      'description': instance.description,
      'updatedAt': instance.updatedAt,
    };

_$ConfigCreateRequestImpl _$$ConfigCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ConfigCreateRequestImpl(
  key: json['key'] as String,
  value: json['value'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$ConfigCreateRequestImplToJson(
  _$ConfigCreateRequestImpl instance,
) => <String, dynamic>{
  'key': instance.key,
  'value': instance.value,
  'description': instance.description,
};

_$ConfigUpdateRequestImpl _$$ConfigUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ConfigUpdateRequestImpl(
  value: json['value'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$ConfigUpdateRequestImplToJson(
  _$ConfigUpdateRequestImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'description': instance.description,
};
