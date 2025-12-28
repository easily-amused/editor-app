// lib/editor/wp_api/parsers/derived_attribute_enricher.dart
import '../../models/wp_block.dart';

class DerivedAttributeEnricher {
  List<WpBlock> enrichAll(List<WpBlock> blocks) => blocks.map(_enrichBlock).toList();

  WpBlock _enrichBlock(WpBlock block) {
    final children = block.innerBlocks.map(_enrichBlock).toList();
    final attrs = Map<String, dynamic>.from(block.attributes);

    if (block.name == 'core/paragraph') {
      final inner = (attrs['_innerHtml'] ?? '').toString();
      final text = _htmlToPlainText(inner);
      attrs.putIfAbsent('content', () => text);
    }

    if (block.name == 'core/heading') {
      final inner = (attrs['_innerHtml'] ?? '').toString();
      final text = _htmlToPlainText(inner);
      attrs.putIfAbsent('content', () => text);

      final level = _inferHeadingLevel(inner);
      if (level != null) attrs.putIfAbsent('level', () => level);
    }

    return block.copyWith(attributes: attrs, innerBlocks: children);
  }

  String _htmlToPlainText(String html) {
    var s = html;
    s = s.replaceAll(RegExp(r'<!--.*?-->', dotAll: true), '');
    s = s.replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n');
    s = s.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
    s = s.replaceAll(RegExp(r'<[^>]+>'), '');
    s = s
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'");
    s = s.replaceAll(RegExp(r'\r'), '');
    s = s.replaceAll(RegExp(r'\n\s+\n'), '\n\n');
    return s.trim();
  }

  int? _inferHeadingLevel(String html) {
    final m = RegExp(r'<h([1-6])\b', caseSensitive: false).firstMatch(html);
    if (m == null) return null;
    return int.tryParse(m.group(1) ?? '');
  }
}
