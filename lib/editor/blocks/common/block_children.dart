import 'package:flutter/widgets.dart';

import '../../models/wp_block.dart';
import '../../models/wp_block_path.dart';
import '../../registry/block_view_registry.dart';
import '../../rendering/block_renderer.dart';

class BlockChildren extends StatelessWidget {
  const BlockChildren({
    super.key,
    required this.parentPath,
    required this.children,
    required this.viewRegistry,
    this.padding = const EdgeInsets.only(left: 12),
    this.spacing = 8,
  });

  final WpBlockPath parentPath;
  final List<WpBlock> children;
  final BlockViewRegistry viewRegistry;
  final EdgeInsets padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            _ChildBlock(
              block: children[i],
              parentPath: parentPath,
              viewRegistry: viewRegistry,
            ),
            if (i != children.length - 1) SizedBox(height: spacing),
          ],
        ],
      ),
    );
  }
}

class _ChildBlock extends StatelessWidget {
  const _ChildBlock({
    required this.block,
    required this.parentPath,
    required this.viewRegistry,
  });

  final WpBlock block;
  final WpBlockPath parentPath;
  final BlockViewRegistry viewRegistry;

  @override
  Widget build(BuildContext context) {
    final childPath = WpBlockPath(
      clientIds: [...parentPath.clientIds, block.clientId],
    );

    return BlockRenderer(
      block: block,
      path: childPath,
      viewRegistry: viewRegistry,
    );
  }
}
