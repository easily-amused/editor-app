import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/wp_session.dart';

class SessionStorage {
  static const _key = 'wp_session_v2';
  final FlutterSecureStorage _storage;

  SessionStorage(this._storage);

  Future<WpSession?> read() async {
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.isEmpty) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return WpSession.fromJson(json);
  }

  Future<void> write(WpSession session) async {
    await _storage.write(key: _key, value: jsonEncode(session.toJson()));
  }

  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}
