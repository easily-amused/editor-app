import 'package:flutter/widgets.dart';

import '../../../models/wp_block.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.block});

  final WpBlock block;

  @override
  Widget build(BuildContext context) {
    final inner = (block.attributes['_innerHtml'] ?? '').toString();
    final src = RegExp(
      r'<img[^>]*\ssrc="([^"]+)"',
      caseSensitive: false,
    ).firstMatch(inner)?.group(1);

    final url = ((block.attributes['url'] ?? '') as String).isNotEmpty
        ? block.attributes['url'].toString()
        : (src ?? '');

    final alt =
        RegExp(
          r'<img[^>]*\salt="([^"]*)"',
          caseSensitive: false,
        ).firstMatch(inner)?.group(1) ??
        '';

    if (url.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(url),
            if (alt.isNotEmpty) ...[const SizedBox(height: 4), Text(alt)],
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const SizedBox(height: 140),
      ),
    );
  }
}
