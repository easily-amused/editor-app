// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wp_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WpDocument _$WpDocumentFromJson(Map<String, dynamic> json) => _WpDocument(
  blocks:
      (json['blocks'] as List<dynamic>?)
          ?.map((e) => WpBlock.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WpBlock>[],
  meta: json['meta'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$WpDocumentToJson(_WpDocument instance) =>
    <String, dynamic>{'blocks': instance.blocks, 'meta': instance.meta};
