// lib/editor/rendering/block_path_scope.dart
import 'package:flutter/widgets.dart';
import '../models/wp_block_path.dart';

class BlockPathScope extends InheritedWidget {
  const BlockPathScope({
    super.key,
    required this.path,
    required super.child,
  });

  final WpBlockPath path;

  static WpBlockPath of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<BlockPathScope>();
    assert(scope != null, 'BlockPathScope not found in widget tree.');
    return scope!.path;
  }

  @override
  bool updateShouldNotify(BlockPathScope oldWidget) => oldWidget.path != path;
}
