// lib/editor/rendering/block_renderer.dart
import 'package:editor_app/editor/rendering/block_path_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wp_block.dart';
import '../models/wp_block_path.dart';
import '../registry/block_registry.dart';
import '../registry/block_view_registry.dart';
import '../state/document_controller.dart';
import 'block_unknown.dart';
import 'known_block_fallback.dart';

class BlockRenderer extends ConsumerWidget {
  const BlockRenderer({
    super.key,
    required this.block,
    required this.path,
    required this.viewRegistry,
  });

  final WpBlock block;
  final WpBlockPath path;
  final BlockViewRegistry viewRegistry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editor = ref.watch(editorControllerProvider);
    final controller = ref.read(editorControllerProvider.notifier);

    // Build the actual block view exactly as you already do:
    final customBuilder = viewRegistry.get(block.name);
    Widget child;
    if (customBuilder != null) {
      child = customBuilder(context, block);
    } else if (isKnownBlock(block.name)) {
      child = KnownBlockFallback(block: block, specTitle: block.name);
    } else {
      child = BlockUnknown(block: block);
    }

    final isSelected =
        editor.selectionPath.clientIds.isNotEmpty &&
        editor.selectionPath.clientIds.last == block.clientId;

    // Tap selects this block (updates breadcrumbs + inspector source of truth)
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.setSelectionPath(path);
        controller.focusBlock(block.clientId); // keep if you use focus
      },
      child: BlockPathScope(
        path: path,
        child: _BlockChrome(isSelected: isSelected, child: child),
      ),
    );
  }
}

class _BlockChrome extends StatelessWidget {
  const _BlockChrome({required this.isSelected, required this.child});

  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!isSelected) return child;

    // Minimal selection UI. You can swap this to your own chrome later.
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
