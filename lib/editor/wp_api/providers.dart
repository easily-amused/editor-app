import 'package:flutter/foundation.dart';

import 'package:editor_app/editor/wp_api/editor_js_parser.dart';
import 'package:riverpod/riverpod.dart';

import '../../wp_api/models/wp_post_type.dart';
import '../../wp_api/wp_api_providers.dart';
import '../models/wp_document.dart';
import 'document_source.dart';

import 'package:flutter_js/flutter_js.dart';

import 'document_source.dart';
import './parsers/derived_attribute_enricher.dart';

/// JS runtime used to run Gutenberg's default block parser (headless).
final gutenbergJsRuntimeProvider = Provider<JavascriptRuntime>((ref) {
  final runtime = getJavascriptRuntime();
  ref.onDispose(runtime.dispose);
  return runtime;
});

final gutenbergJsParserProvider = Provider<GutenbergJsParser>((ref) {
  final runtime = ref.watch(gutenbergJsRuntimeProvider);
  return GutenbergJsParser(runtime);
});

final documentSourceProvider = Provider<DocumentSource>((ref) {
  final parser = ref.watch(gutenbergJsParserProvider);
  return DocumentSource(gutenbergParser: parser);
});

final initialDocumentProvider =
    FutureProvider.family<WpDocument, ({String restBase, int postId})>((
      ref,
      args,
    ) async {
      final api = ref.read(wpApiClientProvider);
      if (api == null) {
        throw StateError('No active WP session: wpApiClientProvider is null');
      }

      final Map<String, dynamic> json = await api.getRestJson(
        '/wp/v2/${args.restBase}/${args.postId}',
        query: const {'context': 'edit'},
      );

      final titleMap = json['title'];
      final title = switch (titleMap) {
        final Map m =>
          (m['raw'] as String?) ?? (m['rendered'] as String?) ?? '',
        _ => '',
      };

      final contentMap = json['content'];
      final rawContent = switch (contentMap) {
        final Map m =>
          (m['raw'] as String?) ?? (m['rendered'] as String?) ?? '',
        _ => '',
      };

      final source = ref.read(documentSourceProvider);
      return source.fromWpApi(
        postId: args.postId,
        postTypeRestBase: args.restBase,
        title: title,
        rawContent: rawContent,
        meta: json,
      );
    });
