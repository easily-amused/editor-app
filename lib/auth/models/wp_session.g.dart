// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wp_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WpSession _$WpSessionFromJson(Map<String, dynamic> json) => _WpSession(
  sites: (json['sites'] as List<dynamic>)
      .map((e) => WpSiteAccount.fromJson(e as Map<String, dynamic>))
      .toList(),
  activeSiteId: json['activeSiteId'] as String?,
);

Map<String, dynamic> _$WpSessionToJson(_WpSession instance) =>
    <String, dynamic>{
      'sites': instance.sites,
      'activeSiteId': instance.activeSiteId,
    };
