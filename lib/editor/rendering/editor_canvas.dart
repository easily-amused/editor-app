// lib/editor/rendering/editor_canvas.dart
import 'package:flutter/widgets.dart';

import '../models/wp_block.dart';
import '../models/wp_block_path.dart';
import '../registry/block_view_registry.dart';
import 'block_renderer.dart';

class EditorCanvas extends StatelessWidget {
  const EditorCanvas({
    super.key,
    required this.blocks,
    required this.viewRegistry,
    required this.documentKey,
  });

  final List<WpBlock> blocks;
  final BlockViewRegistry viewRegistry;

  /// Something that changes per loaded post (e.g. postId).
  final String documentKey;

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) {
      return const Center(child: Text('No blocks yet'));
    }

    return ListView.builder(
      key: PageStorageKey('editor-list-$documentKey'), // resets scroll/state per doc
      padding: const EdgeInsets.all(16),
      itemCount: blocks.length,
      itemBuilder: (context, index) {
        final block = blocks[index];

        // Root-level path: just this block’s clientId.
        final path = WpBlockPath(clientIds: [block.clientId]);

        return KeyedSubtree(
          key: ValueKey('$documentKey:${block.clientId}'),
          child: BlockRenderer(
            block: block,
            path: path,
            viewRegistry: viewRegistry,
          ),
        );
      },
    );
  }
}
