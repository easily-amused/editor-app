// auth/models/wp_site_account.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wp_site_account.freezed.dart';
part 'wp_site_account.g.dart';

@freezed
sealed class WpSiteAccount with _$WpSiteAccount {
  const factory WpSiteAccount({
    required String id,
    required String siteUrl,
    required String username,
    required String appPassword,
    String? label,
    DateTime? lastUsedAt,
  }) = _WpSiteAccount;

  factory WpSiteAccount.fromJson(Map<String, dynamic> json) =>
      _$WpSiteAccountFromJson(json);
}
