// lib/editor/wp_api/parsers/legacy_dart_comment_parser.dart
import 'package:uuid/uuid.dart';
import '../../models/wp_block.dart';

class LegacyDartCommentParser {
  LegacyDartCommentParser({Uuid? uuid}) : _uuid = uuid ?? const Uuid();
  final Uuid _uuid;

  List<WpBlock> parse(String raw) {
    return _parseGutenbergCommentTree(raw);
  }

  List<WpBlock> _parseGutenbergCommentTree(String raw) {
    final root = <WpBlock>[];
    final stack = <_OpenFrame>[];

    final markerRe = RegExp(
      r'<!--\s*(/)?wp:([a-zA-Z0-9_-]+(?:/[a-zA-Z0-9_-]+)?)'
      r'(?:\s+(\{.*?\}))?'
      r'\s*-->',
      dotAll: true,
    );

    for (final m in markerRe.allMatches(raw)) {
      final isClosing = (m.group(1) ?? '').isNotEmpty;
      final rawName = (m.group(2) ?? '').trim();
      final attrsJson = m.group(3);

      if (rawName.isEmpty) continue;

      final name = _normalizeBlockName(rawName);

      if (!isClosing) {
        final block = WpBlock(
          clientId: _uuid.v4(),
          name: name,
          attributes: <String, dynamic>{
            if (attrsJson != null && attrsJson.trim().isNotEmpty) '_attrsJson': attrsJson.trim(),
          },
          innerBlocks: const [],
        );

        stack.add(
          _OpenFrame(
            name: name,
            block: block,
            contentStart: m.end,
          ),
        );
        continue;
      }

      final closeIndex = stack.lastIndexWhere((frame) => frame.name == name);
      if (closeIndex == -1) continue;

      final frame = stack.removeAt(closeIndex);

      while (stack.length > closeIndex) {
        final orphan = stack.removeLast();
        frame.children.add(orphan.finalize());
      }

      frame.innerHtml = raw.substring(frame.contentStart, m.start);
      final completed = frame.finalize();

      if (stack.isEmpty) {
        root.add(completed);
      } else {
        stack.last.children.add(completed);
      }
    }

    while (stack.isNotEmpty) {
      final frame = stack.removeLast();
      final completed = frame.finalize();

      if (stack.isEmpty) {
        root.add(completed);
      } else {
        stack.last.children.add(completed);
      }
    }

    return root;
  }

  String _normalizeBlockName(String rawName) {
    if (rawName.contains('/')) return rawName;
    return 'core/$rawName';
  }
}

class _OpenFrame {
  _OpenFrame({
    required this.name,
    required this.block,
    required this.contentStart,
  });

  final String name;
  final WpBlock block;
  final int contentStart;

  final List<WpBlock> children = <WpBlock>[];
  String innerHtml = '';

  WpBlock finalize() {
    final attrs = Map<String, dynamic>.from(block.attributes);
    if (innerHtml.trim().isNotEmpty) {
      attrs['_innerHtml'] = innerHtml;
    }
    return block.copyWith(attributes: attrs, innerBlocks: children);
  }
}
