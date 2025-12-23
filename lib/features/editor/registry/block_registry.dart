import 'package:collection/collection.dart';

class BlockSupports {
  final bool richText;
  final bool media;
  final bool layout;
  final bool resize;
  final bool dropZones;
  const BlockSupports({
    this.richText = false,
    this.media = false,
    this.layout = false,
    this.resize = false,
    this.dropZones = false,
  });
}

class BlockSpec {
  final String name;
  final bool isContainer;
  final Set<String> allowedChildBlocks;
  final Set<String> allowedParentBlocks;
  final Map<String, dynamic> defaultAttributes;
  final BlockSupports supports;
  final String title;
  final String category;
  const BlockSpec({
    required this.name,
    required this.title,
    required this.category,
    required this.isContainer,
    this.allowedChildBlocks = const <String>{},
    this.allowedParentBlocks = const <String>{},
    this.defaultAttributes = const <String, dynamic>{},
    this.supports = const BlockSupports(),
  });
  bool get allowsAnyChildren => isContainer && allowedChildBlocks.isEmpty;
  bool canHaveChild(String childName) {
    if (!isContainer) return false;
    if (allowsAnyChildren) return true;
    return allowedChildBlocks.contains(childName);
  }

  bool canBeChildOf(String parentName) {
    if (allowedParentBlocks.isEmpty) return true;
    return allowedParentBlocks.contains(parentName);
  }
}

abstract class CoreBlockNames {
  static const paragraph = 'core/paragraph';
  static const heading = 'core/heading';
  static const image = 'core/image';
  static const quote = 'core/quote';
  static const list = 'core/list';
  static const group = 'core/group';
  static const columns = 'core/columns';
  static const column = 'core/column';
  static const spacer = 'core/spacer';
  static const separator = 'core/separator';
}

final Map<String, BlockSpec> blockRegistry = <String, BlockSpec>{
  //---- TEXT ----
  CoreBlockNames.paragraph: const BlockSpec(
    name: CoreBlockNames.paragraph,
    title: 'Paragraph',
    category: 'text',
    isContainer: false,
    supports: BlockSupports(richText: true),
    defaultAttributes: <String, dynamic>{'content': ''},
  ),

  CoreBlockNames.heading: const BlockSpec(
    name: CoreBlockNames.heading,
    title: 'Heading',
    category: 'text',
    isContainer: false,
    supports: BlockSupports(richText: true),
    defaultAttributes: <String, dynamic>{'content': ''},
  ),

  CoreBlockNames.list: const BlockSpec(
    name: CoreBlockNames.list,
    title: 'List',
    category: 'text',
    isContainer: false,
    supports: BlockSupports(richText: true),
    defaultAttributes: <String, dynamic>{'ordered': false, 'values': ''},
  ),

  CoreBlockNames.quote: const BlockSpec(
    name: CoreBlockNames.quote,
    title: 'Quote',
    category: 'text',
    isContainer: true,

    supports: BlockSupports(layout: false, dropZones: true),
    defaultAttributes: <String, dynamic>{},
  ),

  //---- MEDIA ----
  CoreBlockNames.image: const BlockSpec(
    name: CoreBlockNames.image,
    title: 'Image',
    category: 'media',
    isContainer: false,
    supports: BlockSupports(media: true),
    defaultAttributes: <String, dynamic>{
      'id': null,
      'url': null,
      'alt': '',
      'caption': '',
    },
  ),

  //---- DESIGN ----
  CoreBlockNames.spacer: const BlockSpec(
    name: CoreBlockNames.spacer,
    title: 'Spacer',
    category: 'design',
    isContainer: false,
    defaultAttributes: <String, dynamic>{'height': 24},
  ),

  CoreBlockNames.separator: const BlockSpec(
    name: CoreBlockNames.separator,
    title: 'Separator',
    category: 'design',
    isContainer: false,
    defaultAttributes: <String, dynamic>{},
  ),

  //---- LAYOUT ----
  CoreBlockNames.group: const BlockSpec(
    name: CoreBlockNames.group,
    title: 'Group',
    category: 'layout',
    isContainer: true,
    supports: BlockSupports(layout: true, dropZones: true),
    defaultAttributes: <String, dynamic>{
      'layout': <String, dynamic>{'type': 'constrained'},
    },
  ),

  CoreBlockNames.columns: const BlockSpec(
    name: CoreBlockNames.columns,
    title: 'Columns',
    category: 'layout',
    isContainer: true,

    allowedChildBlocks: <String>{CoreBlockNames.column},
    supports: BlockSupports(layout: true, resize: true, dropZones: true),
    defaultAttributes: <String, dynamic>{
      'columnWidths': <double>[0.5, 0.5],
      'isStackedOnMobile': true,
    },
  ),

  CoreBlockNames.column: const BlockSpec(
    name: CoreBlockNames.column,
    title: 'Column',
    category: 'layout',
    isContainer: true,

    allowedParentBlocks: <String>{CoreBlockNames.columns},
    supports: BlockSupports(layout: true, dropZones: true),
    defaultAttributes: <String, dynamic>{},
  ),
};
BlockSpec? getBlockSpec(String name) => blockRegistry[name];
bool isKnownBlock(String name) => blockRegistry.containsKey(name);
bool isContainerBlock(String name) => blockRegistry[name]?.isContainer ?? false;
bool canInsertChild({required String parentName, required String childName}) {
  final parent = getBlockSpec(parentName);
  final child = getBlockSpec(childName);
  if (parent == null) return true;
  if (child == null) return false;
  if (!parent.canHaveChild(childName)) return false;
  if (!child.canBeChildOf(parentName)) return false;
  return true;
}

List<BlockSpec> getInserterOptions({String? parentName}) {
  final specs = blockRegistry.values.toList()
    ..sort((a, b) => a.title.compareTo(b.title));
  if (parentName == null) return specs;
  return specs
      .where(
        (spec) => canInsertChild(parentName: parentName, childName: spec.name),
      )
      .toList();
}

bool supportsResize(String name) =>
    blockRegistry[name]?.supports.resize ?? false;
bool supportsDropZones(String name) =>
    blockRegistry[name]?.supports.dropZones ?? false;

Map<String, dynamic> getDefaultAttributes(String name) =>
    Map<String, dynamic>.from(
      blockRegistry[name]?.defaultAttributes ?? const <String, dynamic>{},
    );
List<String> getInserterCategories() {
  final cats = blockRegistry.values.map((s) => s.category).toSet().toList()
    ..sort();
  return cats;
}

List<BlockSpec> getBlocksInCategory(String category) => blockRegistry.values
    .where((s) => s.category == category)
    .sortedBy((s) => s.title);
