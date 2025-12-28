// lib/editor/rendering/known_block_fallback.dart
import 'package:flutter/widgets.dart';

import '../models/wp_block.dart';
import '../registry/block_view_registry.dart';
import 'block_path_scope.dart';
import 'block_renderer.dart';

class KnownBlockFallback extends StatelessWidget {
  const KnownBlockFallback({
    super.key,
    required this.block,
    required this.specTitle,
  });

  final WpBlock block;
  final String specTitle;

  @override
  Widget build(BuildContext context) {
    final attrsPreview = _attrsPreview(block.attributes);
    final path = BlockPathScope.of(context);

    // NOTE: We intentionally keep this UI super plain.
    // Later you can wrap with your BlockFrame selection UI.
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
              Text('$specTitle  (not implemented)'),
              const SizedBox(height: 8),
              if (attrsPreview.isNotEmpty) Text(attrsPreview),

              // Optional: if your model supports inner blocks, render them.
              // If your WpBlock uses a different field name, adjust here.
              if (block.innerBlocks.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text('Children:'),
                const SizedBox(height: 8),
                for (final child in block.innerBlocks)
                  BlockRenderer(
                    path: path,
                    block: child,
                    viewRegistry: _resolveViewRegistry(context),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _attrsPreview(Map<String, dynamic> attrs) {
    if (attrs.isEmpty) return '';
    // Keep preview short and safe.
    final keys = attrs.keys.take(6).toList();
    final pairs = keys.map((k) => '$k: ${attrs[k]}').join(', ');
    return 'attrs: {$pairs${attrs.length > 6 ? ', …' : ''}}';
  }

  /// This is a simple way to retrieve the registry without wiring it through every call.
  /// You can replace this with Provider/inherited widget later.
  BlockViewRegistry _resolveViewRegistry(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<BlockViewRegistryScope>();
    return inherited!.registry;
  }
}
