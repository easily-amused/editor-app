import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'block_view_registry.dart';

/// App-specific or experimental block views go here.
BlockViewRegistry buildCustomBlockViewRegistry() {
  final registry = BlockViewRegistry();

  registry.register('app/raw', (context, block) {
    final text = (block.attributes['content'] ?? '').toString();
    return Text(text); // temporary - you can swap to TextFormField next
  });

  registry.register('app/unparsed_gutenberg', (context, block) {
    final raw = (block.attributes['content'] ?? '').toString();
    final names = _extractGutenbergBlockNames(raw);
    // debugPrint('names found: ${names.join(', ')}');

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gutenberg markup detected (not parsed yet)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(
            names.isEmpty
                ? 'No block markers found.'
                : 'Blocks found (${names.length}):\n${names.join(', ')}',
          ),

          const SizedBox(height: 12),
          const Text('Raw preview:'),
          const SizedBox(height: 6),
          Text(raw.length > 500 ? '${raw.substring(0, 500)}…' : raw),
        ],
      ),
    );
  });

  return registry;
}

/// Extracts Gutenberg block names from comment markers.
/// Example: <!-- wp:group -->, <!-- wp:paragraph {"dropCap":true} -->
List<String> _extractGutenbergBlockNames(String raw) {
  final re = RegExp(
    r'<!--\s*wp:([a-zA-Z0-9_-]+)(?:\s+\{.*?\})?\s*-->',
    dotAll: true,
  );
  final matches = re.allMatches(raw);

  // Convert `group` -> `core/group`
  final names = <String>{};
  for (final m in matches) {
    final shortName = m.group(1);
    if (shortName == null || shortName.isEmpty) continue;
    names.add('core/$shortName');
  }

  // Stable order
  final list = names.toList();
  return list;
}
