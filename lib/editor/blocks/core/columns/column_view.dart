import '../../../rendering/block_path_scope.dart';
import 'package:flutter/widgets.dart';

import '../../../models/wp_block.dart';
import '../../../registry/block_view_registry.dart';
import '../../common/block_children.dart';

class ColumnView extends StatelessWidget {
  const ColumnView({
    super.key,
    required this.block,
    required this.viewRegistry,
  });

  final WpBlock block;
  final BlockViewRegistry viewRegistry;

  @override
  Widget build(BuildContext context) {
    final path = BlockPathScope.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlockChildren(
          parentPath: path,
          children: block.innerBlocks,
          viewRegistry: viewRegistry,
        ),
      ),
    );
  }
}
