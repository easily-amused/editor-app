import 'dart:convert';
import 'package:http/http.dart' as http;

import '../auth/models/wp_site_account.dart';

class WpApiClient {
  WpApiClient(this._site, {http.Client? httpClient})
      : _http = httpClient ?? http.Client();

  final WpSiteAccount _site;
  final http.Client _http;

  Uri _uri(String path, [Map<String, String>? query]) {
    final base = Uri.parse(_site.siteUrl);

    return Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
      path: path.startsWith('/') ? path : '/$path',
      queryParameters: query,
    );
  }

  Map<String, String> _authHeaders() {
    final raw = '${_site.username}:${_site.appPassword}';
    final encoded = base64Encode(utf8.encode(raw));

    return {
      'Authorization': 'Basic $encoded',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<http.Response> get(String path, {Map<String, String>? query}) {
    return _http.get(_uri(path, query), headers: _authHeaders());
  }

  Future<http.Response> post(String path, {Object? body}) {
    return _http.post(
      _uri(path),
      headers: _authHeaders(),
      body: body == null ? null : jsonEncode(body),
    );
  }

  Future<http.Response> put(String path, {Object? body}) {
    return _http.put(
      _uri(path),
      headers: _authHeaders(),
      body: body == null ? null : jsonEncode(body),
    );
  }

  Future<dynamic> getJson(String path, {Map<String, String>? query}) async {
    final res = await get(path, query: query);

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('WP GET failed (${res.statusCode}): ${res.body}');
    }

    return jsonDecode(res.body);
  }

  void dispose() => _http.close();
}
