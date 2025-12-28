import 'package:editor_app/editor/blocks/core/paragraph/paragraph_view.dart';
import 'package:flutter/widgets.dart';

import '../registry/block_registry.dart';
import 'block_view_registry.dart';

import '../blocks/core/group/group_view.dart';
import '../blocks/core/columns/columns_view.dart';
import '../blocks/core/columns/column_view.dart';
import '../blocks/core/heading/heading_view.dart';
import '../blocks/core/image/image_view.dart';
import '../blocks/core/cover/cover_view.dart';

BlockViewRegistry buildCoreBlockViewRegistry() {
  final registry = BlockViewRegistry();

  registry.register(CoreBlockNames.paragraph, (context, block) {
    return ParagraphView(block: block);
  });

  registry.register(CoreBlockNames.heading, (context, block) {
    return HeadingView(block: block);
  });

  registry.register(CoreBlockNames.group, (context, block) {
    final views = BlockViewRegistryScope.of(context);
    return GroupView(block: block, viewRegistry: views);
  });

  registry.register(CoreBlockNames.columns, (context, block) {
    final views = BlockViewRegistryScope.of(context);
    return ColumnsView(block: block, viewRegistry: views);
  });

  registry.register(CoreBlockNames.column, (context, block) {
    final views = BlockViewRegistryScope.of(context);
    return ColumnView(block: block, viewRegistry: views);
  });

  registry.register(CoreBlockNames.image, (context, block) {
    return ImageView(block: block);
  });

  registry.register(CoreBlockNames.cover, (context, block) {
    final views = BlockViewRegistryScope.of(context);
    return CoverView(block: block, viewRegistry: views);
  });

  return registry;
}
