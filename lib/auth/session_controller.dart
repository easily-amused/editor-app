import 'dart:convert';

import 'package:editor_app/auth/models/wp_site_account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'models/wp_session.dart';
import 'storage/session_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final sessionStorageProvider = Provider<SessionStorage>((ref) {
  return SessionStorage(ref.watch(secureStorageProvider));
});

final sessionControllerProvider =
    AsyncNotifierProvider<SessionController, WpSession?>(SessionController.new);

class SessionController extends AsyncNotifier<WpSession?> {
  late final SessionStorage _storage = ref.read(sessionStorageProvider);

  @override
  Future<WpSession?> build() async {
    return _storage.read();
  }

  Future<void> addSite({
    required String siteUrl,
    required String username,
    required String appPassword,
    String? label,
  }) async {
    final normalizedUrl = _normalizeSiteUrl(siteUrl);

    final site = WpSiteAccount(
      id: const Uuid().v4(),
      siteUrl: normalizedUrl,
      username: username.trim(),
      appPassword: appPassword.trim(),
      label: label?.trim(),
      lastUsedAt: DateTime.now(),
    );

    // Verify *this* site account
    await _verifyWpCredentials(site);

    final cur = state.asData?.value;

    // Prevent duplicates by siteUrl+username (optional but recommended)
    final nextSites = [
      ...(cur?.sites ?? const <WpSiteAccount>[]).where((s) =>
          !(s.siteUrl == site.siteUrl && s.username == site.username)),
      site,
    ];

    final nextSession = WpSession(
      sites: nextSites,
      activeSiteId: site.id,
    );

    state = AsyncData(nextSession);
    await _storage.write(nextSession);
  }

  Future<void> setActiveSite(String siteId) async {
    final cur = state.asData?.value;
    if (cur == null) return;

    final next = cur.copyWith(activeSiteId: siteId);
    state = AsyncData(next);
    await _storage.write(next);
  }

  Future<void> disconnect() async {
    // optional: immediate UI update
    state = const AsyncData(null);
    await _storage.clear();
  }

  Future<void> _verifyWpCredentials(WpSiteAccount site) async {
    final uri = Uri.parse('${site.siteUrl}/wp-json/wp/v2/users/me');

    final authHeader = 'Basic ${base64Encode(
      utf8.encode('${site.username}:${site.appPassword}'),
    )}';

    final res = await http.get(
      uri,
      headers: {
        'Authorization': authHeader,
        'Accept': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception(
        'Failed to verify WordPress credentials (${res.statusCode}): ${_safeSnippet(res.body)}',
      );
    }
  }

  String _normalizeSiteUrl(String input) {
    var s = input.trim();

    if (!s.startsWith('http://') && !s.startsWith('https://')) {
      s = 'https://$s';
    }

    while (s.endsWith('/')) {
      s = s.substring(0, s.length - 1);
    }

    return s;
  }

  String _safeSnippet(String body) {
    final b = body.trim();
    if (b.isEmpty) return '(empty)';
    return b.length > 180 ? '${b.substring(0, 180)}…' : b;
  }
}
