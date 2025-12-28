// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wp_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WpDocument _$WpDocumentFromJson(Map<String, dynamic> json) => _WpDocument(
  postId: (json['postId'] as num).toInt(),
  postTypeRestBase: json['postTypeRestBase'] as String,
  title: json['title'] as String,
  rawContent: json['rawContent'] as String,
  blocks:
      (json['blocks'] as List<dynamic>?)
          ?.map((e) => WpBlock.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WpBlock>[],
  meta: json['meta'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$WpDocumentToJson(_WpDocument instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'postTypeRestBase': instance.postTypeRestBase,
      'title': instance.title,
      'rawContent': instance.rawContent,
      'blocks': instance.blocks,
      'meta': instance.meta,
    };
