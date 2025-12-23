// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wp_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WpBlock _$WpBlockFromJson(Map<String, dynamic> json) => _WpBlock(
  clientId: json['clientId'] as String,
  name: json['name'] as String,
  attributes:
      json['attributes'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  innerBlocks:
      (json['innerBlocks'] as List<dynamic>?)
          ?.map((e) => WpBlock.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WpBlock>[],
  innerContent:
      (json['innerContent'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  originalContent: json['originalContent'] as String?,
  isUnsupported: json['isUnsupported'] as bool? ?? false,
);

Map<String, dynamic> _$WpBlockToJson(_WpBlock instance) => <String, dynamic>{
  'clientId': instance.clientId,
  'name': instance.name,
  'attributes': instance.attributes,
  'innerBlocks': instance.innerBlocks,
  'innerContent': instance.innerContent,
  'originalContent': instance.originalContent,
  'isUnsupported': instance.isUnsupported,
};
