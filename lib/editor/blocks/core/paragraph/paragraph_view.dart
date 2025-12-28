import 'package:flutter/material.dart';

import '../../../models/wp_block.dart';

class ParagraphView extends StatelessWidget {
  const ParagraphView({
    super.key,
    required this.block,
    this.isSelected = false,
    this.onSelect,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
  });

  final WpBlock block;

  /// Pass selection state from your editor selection system.
  final bool isSelected;

  /// Called when the paragraph is tapped. Your renderer can pass `() => select(path)`.
  final VoidCallback? onSelect;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {

    // Gutenberg: core/paragraph -> attributes.content (string, usually HTML-ish)
    final content = _readStringAttr(block, 'content') ?? '';

    final plainText = _toPlainText(content);

    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.08)
              : null,
          border: isSelected
              ? Border.all(color: theme.colorScheme.primary, width: 1)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          // Keep an actual line height even if empty so the block is tappable/selectable.
          plainText.isEmpty ? ' ' : plainText,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }

  String? _readStringAttr(WpBlock block, String key) {
    final attrs = block.attributes;
    if (attrs == null) return null;

    // Common: attributes is Map<String, dynamic>
    if (attrs is Map<String, dynamic>) {
      final v = attrs[key];
      if (v == null) return null;
      if (v is String) return v;
      return v.toString();
    }

    // If you use an attributes object with a `toJson()` method (Freezed style),
    // we try that without hard dependency.
    // try {
    //   final dynamic dyn = attrs;
    //   final dynamic json = dyn.toJson?.call();
    //   if (json is Map<String, dynamic>) {
    //     final v = json[key];
    //     if (v == null) return null;
    //     if (v is String) return v;
    //     return v.toString();
    //   }
    // } catch (_) {
    //   // ignore
    // }

    // return null;
  }


  String _toPlainText(String html) {
    if (html.isEmpty) return '';

    return html
        // common line breaks
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
        // strip all tags
        .replaceAll(RegExp(r'<[^>]+>'), '')
        // unescape a few common entities (MVP)
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .trimRight();
  }
}
