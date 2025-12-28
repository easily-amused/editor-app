import 'package:flutter/widgets.dart';

import '../../../models/wp_block.dart';
import '../../../registry/block_view_registry.dart';
import 'column_view.dart';

class ColumnsView extends StatelessWidget {
  const ColumnsView({
    super.key,
    required this.block,
    required this.viewRegistry,
  });

  final WpBlock block;
  final BlockViewRegistry viewRegistry;

  @override
  Widget build(BuildContext context) {
    final columns = block.innerBlocks;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < columns.length; i++) ...[
              Expanded(
                child: ColumnView(
                  block: columns[i],
                  viewRegistry: viewRegistry,
                ),
              ),
              if (i != columns.length - 1) const SizedBox(width: 12),
            ],
          ],
        ),
      ),
    );
  }
}
