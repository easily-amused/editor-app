import 'package:uuid/uuid.dart';

import '../models/wp_block.dart';
import '../models/wp_document.dart';

import 'editor_js_parser.dart';
import 'parsers/derived_attribute_enricher.dart';
import 'parsers/legacy_dart_parser.dart';
import 'parsers/wp_block_mapper.dart';

class DocumentSource {
  DocumentSource({
    required GutenbergJsParser gutenbergParser,
    LegacyDartCommentParser? legacyParser,
    DerivedAttributeEnricher? enricher,
    Uuid? uuid,
  })  : _gutenberg = gutenbergParser,
        _legacy = legacyParser ?? LegacyDartCommentParser(uuid: uuid),
        _enricher = enricher ?? DerivedAttributeEnricher(),
        _uuid = uuid ?? const Uuid();

  final GutenbergJsParser _gutenberg;
  final LegacyDartCommentParser _legacy;
  final DerivedAttributeEnricher _enricher;
  final Uuid _uuid;

  Future<WpDocument> fromWpApi({
    required int postId,
    required String postTypeRestBase,
    required String title,
    required String rawContent,
    Map<String, dynamic> meta = const {},
  }) async {
    final blocks = await parseBlocksFromRaw(rawContent);

    return WpDocument(
      postId: postId,
      postTypeRestBase: postTypeRestBase,
      title: title,
      rawContent: rawContent,
      blocks: blocks,
      meta: meta,
    );
  }

  Future<List<WpBlock>> parseBlocksFromRaw(String raw) async {
    final input = raw.trim();
    if (input.isEmpty) return const [];

    // Classic content (no Gutenberg markers): keep your current behavior
    if (!_looksLikeGutenberg(input)) {
      return [
        WpBlock(
          clientId: _uuid.v4(),
          name: 'app/raw',
          attributes: {'content': input},
          innerBlocks: const [],
        ),
      ];
    }

    // 1) Try WordPress default parser (JS)
    try {
      final gb = await _gutenberg.parseBlocks(input); // List<dynamic> maps
      final mapped = gb.map((b) => wpBlockFromGutenberg(b, uuid: _uuid)).toList();

      if (mapped.isNotEmpty) {
        return _enricher.enrichAll(mapped);
      }
    } catch (_) {
      // swallow and fallback
    }

    // 2) Fallback: your existing Dart parser
    final legacy = _legacy.parse(input);
    if (legacy.isNotEmpty) {
      return _enricher.enrichAll(legacy);
    }

    // 3) Safe fallback
    return [
      WpBlock(
        clientId: _uuid.v4(),
        name: 'app/unparsed_gutenberg',
        attributes: {'content': input},
        innerBlocks: const [],
      ),
    ];
  }

  bool _looksLikeGutenberg(String raw) => raw.contains('<!-- wp:');
}
