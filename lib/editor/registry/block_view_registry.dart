import 'package:flutter/widgets.dart';
import '../models/wp_block.dart';

/// Builder signature for rendering a block.
/// This is intentionally UI-only and does not know about editor state.
typedef BlockViewBuilder = Widget Function(
  BuildContext context,
  WpBlock block,
);

class BlockViewRegistry {
  final Map<String, BlockViewBuilder> _builders = {};

  void register(String blockName, BlockViewBuilder builder) {
    _builders[blockName] = builder;
  }

  BlockViewBuilder? get(String blockName) => _builders[blockName];

  bool canRender(String blockName) => _builders.containsKey(blockName);

  Map<String, BlockViewBuilder> get all =>
      Map<String, BlockViewBuilder>.unmodifiable(_builders);
}

class BlockViewRegistryScope extends InheritedWidget {
  const BlockViewRegistryScope({
    super.key,
    required this.registry,
    required super.child,
  });

  final BlockViewRegistry registry;

  static BlockViewRegistry of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<BlockViewRegistryScope>();
    assert(scope != null, 'No BlockViewRegistryScope found in context.');
    return scope!.registry;
  }

  @override
  bool updateShouldNotify(BlockViewRegistryScope oldWidget) =>
      !identical(oldWidget.registry, registry);
}
