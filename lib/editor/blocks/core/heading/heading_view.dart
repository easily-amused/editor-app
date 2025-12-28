import 'package:flutter/material.dart';

import '../../../models/wp_block.dart';

class HeadingView extends StatelessWidget {
  const HeadingView({super.key, required this.block});

  final WpBlock block;

  @override
  Widget build(BuildContext context) {
    // Helpful during bring-up; yank later.
    // debugPrint('Heading attrs: ${block.attributes}');

    final level = _readHeadingLevel(block) ?? 2;
    final innerHtml = _readInnerHtml(block) ?? '';
    final text = _extractText(innerHtml);

    final typography = _typography(block);
    final align = _textAlign(block);

    final levelBase = _levelBaseStyle(context, level);
    final tyStyle = _typographyToTextStyle(context, typography);

    // Gutenberg-ish behavior: typography overrides base level style when present.
    final style = levelBase.merge(tyStyle);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text.isEmpty ? ' ' : text,
        style: style,
        textAlign: align,
      ),
    );
  }

  // --- Reading helpers (match your current parsed shape) ---

  int? _readHeadingLevel(WpBlock block) {
    final attrs = block.attributes;
    if (attrs is! Map<String, dynamic>) return null;

    final json = attrs['_attrsJson'];
    if (json is! Map<String, dynamic>) return null;

    final level = json['level'];
    if (level is int) return level;
    return int.tryParse(level?.toString() ?? '');
  }

  String? _readInnerHtml(WpBlock block) {
    final attrs = block.attributes;
    if (attrs is! Map<String, dynamic>) return null;

    final inner = attrs['_innerHtml'];
    if (inner is String) return inner;
    return inner?.toString();
  }

  Map<String, dynamic>? _typography(WpBlock block) {
    final attrs = block.attributes;
    if (attrs is! Map<String, dynamic>) return null;

    final json = attrs['_attrsJson'];
    if (json is! Map<String, dynamic>) return null;

    final style = json['style'];
    if (style is! Map<String, dynamic>) return null;

    final typography = style['typography'];
    return typography is Map<String, dynamic> ? typography : null;
  }

  TextAlign _textAlign(WpBlock block) {
    final attrs = block.attributes;
    if (attrs is! Map<String, dynamic>) return TextAlign.left;

    final json = attrs['_attrsJson'];
    if (json is! Map<String, dynamic>) return TextAlign.left;

    final align = json['textAlign']?.toString();
    switch (align) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  // --- Styling ---

  TextStyle _levelBaseStyle(BuildContext context, int level) {
    final textTheme = Theme.of(context).textTheme;

    // Prefer theme styles over hardcoded sizes.
    return switch (level) {
      1 => textTheme.headlineLarge ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      2 => textTheme.headlineMedium ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      3 => textTheme.headlineSmall ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      4 => textTheme.titleLarge ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      5 => textTheme.titleMedium ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      _ => textTheme.titleSmall ?? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    };
  }

  TextStyle? _typographyToTextStyle(BuildContext context, Map<String, dynamic>? typography) {
    if (typography == null) return null;

    final base = Theme.of(context).textTheme.headlineMedium;

    final fontSize = _parseCssSize(typography['fontSize']);
    final letterSpacing = _parseCssSize(typography['letterSpacing']);
    final height = _parseLineHeight(typography['lineHeight']);
    final fontWeight = _parseFontWeight(typography['fontWeight']);
    final fontStyle = typography['fontStyle']?.toString() == 'italic'
        ? FontStyle.italic
        : FontStyle.normal;

    return (base ?? const TextStyle()).copyWith(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  // --- Text extraction (MVP) ---

  String _extractText(String html) {
    return html.replaceAll(RegExp(r'<[^>]+>'), '').trim();
  }

  // --- CSS parsing ---

  double? _parseCssSize(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();

    final s = value.toString().trim();

    // Bail on Gutenberg var/preset tokens for now (e.g., "var:preset|spacing|50")
    if (s.startsWith('var:') || s.contains('|')) return null;

    double? numPart(String str) => double.tryParse(str.replaceAll(RegExp(r'[a-zA-Z]'), ''));

    if (s.endsWith('rem') || s.endsWith('em')) {
      final n = numPart(s);
      return n == null ? null : n * 16.0;
    }

    if (s.endsWith('px')) {
      return double.tryParse(s.replaceAll('px', ''));
    }

    return double.tryParse(s);
  }

  double? _parseLineHeight(dynamic value) {
    if (value == null) return null;
    final s = value.toString().trim();

    if (s.startsWith('var:') || s.contains('|')) return null;

    return double.tryParse(s);
  }

  FontWeight? _parseFontWeight(dynamic value) {
    if (value == null) return null;
    final s = value.toString().trim();

    return switch (s) {
      '100' => FontWeight.w100,
      '200' => FontWeight.w200,
      '300' => FontWeight.w300,
      '400' => FontWeight.w400,
      '500' => FontWeight.w500,
      '600' => FontWeight.w600,
      '700' => FontWeight.w700,
      '800' => FontWeight.w800,
      '900' => FontWeight.w900,
      _ => null,
    };
  }
}
