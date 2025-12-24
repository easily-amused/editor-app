// auth/models/wp_session.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'wp_site_account.dart';

part 'wp_session.freezed.dart';
part 'wp_session.g.dart';

@freezed
sealed class WpSession with _$WpSession {
  const factory WpSession({
    required List<WpSiteAccount> sites,
    required String? activeSiteId,
  }) = _WpSession;

  factory WpSession.fromJson(Map<String, dynamic> json) =>
      _$WpSessionFromJson(json);
}

extension WpSessionX on WpSession {
  WpSiteAccount? get activeSite {
    if (sites.isEmpty) return null;
    if (activeSiteId == null) return sites.first;
    return sites.firstWhere(
      (s) => s.id == activeSiteId,
      orElse: () => sites.first,
    );
  }
}
