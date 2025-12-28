import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'package:editor_app/wp_api/models/wp_post_type.dart';
import 'package:http/http.dart' as http;

import '../auth/models/wp_site_account.dart';

class WpApiClient {
  WpApiClient(this._site, {http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  final WpSiteAccount _site;
  final http.Client _http;

  Uri _uri(String path, [Map<String, String>? query]) {
    final base = Uri.parse(_site.siteUrl);

    final basePath = base.path.endsWith('/')
        ? base.path.substring(0, base.path.length - 1)
        : base.path;

    final reqPath = path.startsWith('/') ? path : '/$path';

    return base.replace(path: '$basePath$reqPath', queryParameters: query);
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
    debugPrint('fetching ${_uri(path, query).toString()}');
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

  Future<dynamic> getRestJson(
    String restPath, {
    Map<String, String>? query,
  }) async {
    final p = restPath.startsWith('/') ? restPath : '/$restPath';
    return getJson('/wp-json$p', query: query);
  }

  Future<Map<String, dynamic>> getPost({
    required WpPostType postType,
    required int postId,
  }) async {
    final restBase = postType.restBase;

    final json = await getRestJson(
      '/wp/v2/$restBase/$postId',
      query: const {'context': 'edit'},
    );

    return (json as Map).cast<String, dynamic>();
  }

  /// Update a post (title/content/status/etc).
  /// Pass Gutenberg block markup string into `content`.
  Future<Map<String, dynamic>> updatePost({
    required WpPostType postType,
    required int postId,
    String? title,
    String? content,
    String? status, // 'draft' | 'publish' | etc
  }) async {
    final restBase = postType.restBase;

    final body = <String, dynamic>{
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
    };

    final res = await put('/wp-json/wp/v2/$restBase/$postId', body: body);

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('WP PUT failed (${res.statusCode}): ${res.body}');
    }

    final json = jsonDecode(res.body);
    return (json as Map).cast<String, dynamic>();
  }

  void dispose() => _http.close();
}
