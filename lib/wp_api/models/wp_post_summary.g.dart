// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wp_post_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WpPostSummary _$WpPostSummaryFromJson(Map<String, dynamic> json) =>
    _WpPostSummary(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      modified: json['modified'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$WpPostSummaryToJson(_WpPostSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'modified': instance.modified,
      'status': instance.status,
    };
