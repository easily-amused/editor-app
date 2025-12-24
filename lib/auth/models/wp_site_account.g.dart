// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wp_site_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WpSiteAccount _$WpSiteAccountFromJson(Map<String, dynamic> json) =>
    _WpSiteAccount(
      id: json['id'] as String,
      siteUrl: json['siteUrl'] as String,
      username: json['username'] as String,
      appPassword: json['appPassword'] as String,
      label: json['label'] as String?,
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
    );

Map<String, dynamic> _$WpSiteAccountToJson(_WpSiteAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteUrl': instance.siteUrl,
      'username': instance.username,
      'appPassword': instance.appPassword,
      'label': instance.label,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
    };
