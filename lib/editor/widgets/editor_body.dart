import 'package:flutter/material.dart';

import '../models/wp_block.dart';
import '../models/wp_block_path.dart';
import '../registry/block_view_registry.dart';
import '../rendering/editor_canvas.dart';
import 'editor_inspector_panel.dart';

class EditorBody extends StatelessWidget {
  const EditorBody({
    super.key,
    required this.postId,
    required this.blocks,
    required this.rawContent,
    required this.viewRegistry,
    required this.documentKey,
    required this.onRawChanged,
    required this.isInspectorOpen,
    required this.onCloseInspector,
    required this.selectedBlock,
    required this.selectionPath,
  });

  final int postId;
  final List<WpBlock> blocks;
  final String rawContent;

  final BlockViewRegistry viewRegistry;
  final String documentKey;

  final ValueChanged<String> onRawChanged;

  final bool isInspectorOpen;
  final VoidCallback onCloseInspector;
  final WpBlock? selectedBlock;
  final WpBlockPath selectionPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (blocks.isNotEmpty)
          KeyedSubtree(
            key: ValueKey('canvas-$postId'),
            child: EditorCanvas(
              blocks: blocks,
              viewRegistry: viewRegistry,
              documentKey: documentKey,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              key: ValueKey('raw-editor-$postId'),
              initialValue: rawContent,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Content (raw)',
              ),
              onChanged: onRawChanged,
            ),
          ),
        EditorInspectorPanel(
          isOpen: isInspectorOpen,
          onClose: onCloseInspector,
          selectedBlock: selectedBlock,
          selectionPath: selectionPath,
        ),
      ],
    );
  }
}
