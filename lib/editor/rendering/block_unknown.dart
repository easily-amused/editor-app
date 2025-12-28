// lib/editor/rendering/block_unknown.dart
import 'package:flutter/widgets.dart';

import '../models/wp_block.dart';

class BlockUnknown extends StatelessWidget {
  const BlockUnknown({
    super.key,
    required this.block,
  });

  final WpBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unknown block',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(block.name),
              const SizedBox(height: 8),

              if (block.attributes.isNotEmpty)
                Text(
                  _attrsPreview(block.attributes),
                ),

              // We intentionally DO NOT recurse into children here.
              // Unknown blocks should be treated as opaque blobs.
            ],
          ),
        ),
      ),
    );
  }

  String _attrsPreview(Map<String, dynamic> attrs) {
    final keys = attrs.keys.take(6).toList();
    final pairs = keys.map((k) => '$k: ${attrs[k]}').join(', ');
    return 'attrs: {$pairs${attrs.length > 6 ? ', …' : ''}}';
  }
}
