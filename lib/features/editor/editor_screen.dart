import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/wp_block.dart';
import 'models/wp_document.dart';
import 'models/wp_block_path.dart';
import 'registry/block_registry.dart';
import 'state/document_controller.dart';
import 'state/editor_ui_controller.dart';
import 'wp_api/providers.dart';
import 'widgets/editor_inspector_panel.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key});

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late final ProviderSubscription<AsyncValue<WpDocument>> _docSub;
  @override
  void initState() {
    super.initState();

    _docSub = ref.listenManual<AsyncValue<WpDocument>>(
      initialDocumentProvider,
      (prev, next) {
        next.whenData((apiDoc) {
          ref.read(editorControllerProvider.notifier).hydrateFromApi(apiDoc);
        });
      },
    );
  }

  @override
  void dispose() {
    _docSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docAsync = ref.watch(initialDocumentProvider);
    final editor = ref.watch(editorControllerProvider);
    final controller = ref.read(editorControllerProvider.notifier);

    final ui = ref.watch(editorUiControllerProvider);
    final uiController = ref.read(editorUiControllerProvider.notifier);

    // Determine selected block (null => Post settings)
    WpBlock? selectedBlock;
    final ids = editor.selectionPath.clientIds;
    if (ids.isNotEmpty) {
      final selectedId = ids.last;
      final found = controller.findByClientId(selectedId);
      selectedBlock = found?.block;
      // if (ids.length <= 1) selectedBlock = null;
    }

    return docAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: const Text('Editor')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Failed to load document: $e'),
        ),
      ),
      data: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Editor'),
            actions: [
              IconButton(
                tooltip: 'Toggle settings',
                onPressed: uiController.toggleInspector,
                icon: Icon(
                  ui.isInspectorOpen ? Icons.tune : Icons.tune_outlined,
                ),
              ),
              IconButton(
                tooltip: editor.isLayoutMode
                    ? 'Switch to Edit Mode'
                    : 'Switch to Layout Mode',
                onPressed: () => controller.setLayoutMode(!editor.isLayoutMode),
                icon: Icon(editor.isLayoutMode ? Icons.grid_view : Icons.edit),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(44),
              child: _BreadcrumbBar(
                selectionPath: editor.selectionPath,
                onSelectPost: () {
                  controller.setSelectionPath(const WpBlockPath(clientIds: []));
                  controller.focusBlock(null);
                  // uiController.openInspector();
                },
                onSelectClientId: (clientId) {
                  debugPrint('i selected: ${clientId}');
                  final found = controller.findByClientId(clientId);
                  if (found == null) return;
                  controller.setSelectionPath(found.path);
                },
              ),
            ),
          ),
          body: Stack(
            children: [
              _DocumentView(
                document: editor.document,
                selectionPath: editor.selectionPath,
                isLayoutMode: editor.isLayoutMode,
                focusedClientId: editor.focusedClientId,
                onSelectBlock: controller.setSelectionPath,
                onFocusBlock: controller.focusBlock,
                onUpdateAttributes: controller.updateBlockAttributes,
              ),

              EditorInspectorPanel(
                isOpen: ui.isInspectorOpen,
                onClose: uiController.closeInspector,
                selectedBlock: selectedBlock,
                selectionPath: editor.selectionPath,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BreadcrumbBar extends StatelessWidget {
  final WpBlockPath selectionPath;
  final VoidCallback onSelectPost;
  final void Function(String clientId) onSelectClientId;

  const _BreadcrumbBar({
    required this.selectionPath,
    required this.onSelectPost,
    required this.onSelectClientId,
  });

  @override
  Widget build(BuildContext context) {
    final ids = selectionPath.clientIds;

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 44,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
      ),
      child: ids.isEmpty
          ? Text(
              'Tap a block to select',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _Crumb(
                    label: 'Post',
                    onTap: onSelectPost, // ✅ clears selection
                  ),
                  for (final id in ids) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.chevron_right, size: 18),
                    ),
                    _Crumb(
                      label: _shortId(id),
                      onTap: () => onSelectClientId(id),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  static String _shortId(String id) => id.length <= 6 ? id : id.substring(0, 6);
}

class _Crumb extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _Crumb({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _DocumentView extends StatelessWidget {
  final WpDocument document;
  final WpBlockPath selectionPath;
  final bool isLayoutMode;
  final String? focusedClientId;

  final void Function(WpBlockPath path) onSelectBlock;
  final void Function(String? clientId) onFocusBlock;
  final void Function({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  })
  onUpdateAttributes;

  const _DocumentView({
    required this.document,
    required this.selectionPath,
    required this.isLayoutMode,
    required this.focusedClientId,
    required this.onSelectBlock,
    required this.onFocusBlock,
    required this.onUpdateAttributes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
      children: [
        for (final block in document.blocks)
          _BlockNode(
            block: block,
            parentPath: const WpBlockPath(clientIds: []),
            selectionPath: selectionPath,
            isLayoutMode: isLayoutMode,
            focusedClientId: focusedClientId,
            onSelectBlock: onSelectBlock,
            onFocusBlock: onFocusBlock,
            onUpdateAttributes: onUpdateAttributes,
          ),
      ],
    );
  }
}

class _BlockNode extends StatelessWidget {
  final WpBlock block;
  final WpBlockPath parentPath;
  final WpBlockPath selectionPath;
  final bool isLayoutMode;
  final String? focusedClientId;

  final void Function(WpBlockPath path) onSelectBlock;
  final void Function(String? clientId) onFocusBlock;
  final void Function({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  })
  onUpdateAttributes;

  const _BlockNode({
    required this.block,
    required this.parentPath,
    required this.selectionPath,
    required this.isLayoutMode,
    required this.focusedClientId,
    required this.onSelectBlock,
    required this.onFocusBlock,
    required this.onUpdateAttributes,
  });

  @override
  Widget build(BuildContext context) {
    final path = WpBlockPath(
      clientIds: [...parentPath.clientIds, block.clientId],
    );
    final isSelected =
        selectionPath.clientIds.isNotEmpty &&
        selectionPath.clientIds.last == block.clientId;

    final spec = getBlockSpec(block.name);

    final cardBorder = Border.all(
      color: isSelected
          ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
          : Theme.of(context).dividerColor.withOpacity(0.2),
      width: isSelected ? 2 : 1,
    );

    // Layout chrome for containers in Layout Mode
    final showContainerChrome =
        isLayoutMode && (spec?.isContainer ?? block.innerBlocks.isNotEmpty);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            onSelectBlock(path);
            // If leaf text block, focus it for typing behavior (handled inside leaf widget).
            if ((spec?.supports.richText ?? false) == true) {
              onFocusBlock(block.clientId);
            } else {
              onFocusBlock(null);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: cardBorder,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BlockHeader(
                  name: block.name,
                  isContainer:
                      spec?.isContainer ?? block.innerBlocks.isNotEmpty,
                  showContainerChrome: showContainerChrome,
                ),
                const SizedBox(height: 8),

                // Render leaf or container body
                if ((spec?.isContainer ?? false) ||
                    block.innerBlocks.isNotEmpty)
                  _ContainerBody(
                    block: block,
                    path: path,
                    selectionPath: selectionPath,
                    isLayoutMode: isLayoutMode,
                    focusedClientId: focusedClientId,
                    onSelectBlock: onSelectBlock,
                    onFocusBlock: onFocusBlock,
                    onUpdateAttributes: onUpdateAttributes,
                  )
                else
                  _LeafBody(
                    block: block,
                    isFocused: focusedClientId == block.clientId,
                    onFocusBlock: onFocusBlock,
                    onUpdateAttributes: onUpdateAttributes,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BlockHeader extends StatelessWidget {
  final String name;
  final bool isContainer;
  final bool showContainerChrome;

  const _BlockHeader({
    required this.name,
    required this.isContainer,
    required this.showContainerChrome,
  });

  @override
  Widget build(BuildContext context) {
    final title = blockRegistry[name]?.title ?? name;

    return Row(
      children: [
        Icon(
          isContainer ? Icons.widgets_outlined : Icons.notes_outlined,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        if (showContainerChrome)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
            ),
            child: Text(
              'Layout',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}

class _ContainerBody extends StatelessWidget {
  final WpBlock block;
  final WpBlockPath path;
  final WpBlockPath selectionPath;
  final bool isLayoutMode;
  final String? focusedClientId;

  final void Function(WpBlockPath path) onSelectBlock;
  final void Function(String? clientId) onFocusBlock;
  final void Function({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  })
  onUpdateAttributes;

  const _ContainerBody({
    required this.block,
    required this.path,
    required this.selectionPath,
    required this.isLayoutMode,
    required this.focusedClientId,
    required this.onSelectBlock,
    required this.onFocusBlock,
    required this.onUpdateAttributes,
  });

  @override
  Widget build(BuildContext context) {
    // Special case: core/columns render horizontally (mobile can stack later).
    if (block.name == CoreBlockNames.columns) {
      return _ColumnsView(
        columnsBlock: block,
        path: path,
        selectionPath: selectionPath,
        isLayoutMode: isLayoutMode,
        focusedClientId: focusedClientId,
        onSelectBlock: onSelectBlock,
        onFocusBlock: onFocusBlock,
        onUpdateAttributes: onUpdateAttributes,
      );
    }

    // Generic container: vertical stack.
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          for (final child in block.innerBlocks)
            _BlockNode(
              block: child,
              parentPath: path,
              selectionPath: selectionPath,
              isLayoutMode: isLayoutMode,
              focusedClientId: focusedClientId,
              onSelectBlock: onSelectBlock,
              onFocusBlock: onFocusBlock,
              onUpdateAttributes: onUpdateAttributes,
            ),
        ],
      ),
    );
  }
}

class _ColumnsView extends StatelessWidget {
  final WpBlock columnsBlock;
  final WpBlockPath path;
  final WpBlockPath selectionPath;
  final bool isLayoutMode;
  final String? focusedClientId;

  final void Function(WpBlockPath path) onSelectBlock;
  final void Function(String? clientId) onFocusBlock;
  final void Function({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  })
  onUpdateAttributes;

  const _ColumnsView({
    required this.columnsBlock,
    required this.path,
    required this.selectionPath,
    required this.isLayoutMode,
    required this.focusedClientId,
    required this.onSelectBlock,
    required this.onFocusBlock,
    required this.onUpdateAttributes,
  });

  @override
  Widget build(BuildContext context) {
    final widthsRaw = columnsBlock.attributes['gutesColumnWidths'];
    final widths = (widthsRaw is List)
        ? widthsRaw.whereType<num>().map((e) => e.toDouble()).toList()
        : null;

    final children = columnsBlock.innerBlocks;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 520; // tweak threshold
        final useCompact = isLayoutMode || isNarrow; // your rule

        if (useCompact) {
          return _ColumnsCompactView(
            columnsBlock: columnsBlock,
            path: path,
            selectionPath: selectionPath,
            isLayoutMode: isLayoutMode,
            focusedClientId: focusedClientId,
            onSelectBlock: onSelectBlock,
            onFocusBlock: onFocusBlock,
            onUpdateAttributes: onUpdateAttributes,
          );
        }

        // Existing wide/full view
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < children.length; i++) ...[
              Expanded(
                flex: _widthToFlex(widths, i),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.15),
                    ),
                  ),
                  child: _BlockNode(
                    block: children[i],
                    parentPath: path,
                    selectionPath: selectionPath,
                    isLayoutMode: isLayoutMode,
                    focusedClientId: focusedClientId,
                    onSelectBlock: onSelectBlock,
                    onFocusBlock: onFocusBlock,
                    onUpdateAttributes: onUpdateAttributes,
                  ),
                ),
              ),
              if (i != children.length - 1) const SizedBox(width: 10),
            ],
          ],
        );
      },
    );
  }

  int _widthToFlex(List<double>? widths, int i) {
    if (widths == null || widths.length <= i) return 1;
    // Scale to a reasonable flex range
    final w = widths[i].clamp(0.05, 0.95);
    return (w * 1000).round();
  }
}

class _ColumnsCompactView extends StatelessWidget {
  final WpBlock columnsBlock;
  final WpBlockPath path;
  final WpBlockPath selectionPath;
  final bool isLayoutMode;
  final String? focusedClientId;

  final void Function(WpBlockPath path) onSelectBlock;
  final void Function(String? clientId) onFocusBlock;
  final void Function({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  })
  onUpdateAttributes;

  const _ColumnsCompactView({
    required this.columnsBlock,
    required this.path,
    required this.selectionPath,
    required this.isLayoutMode,
    required this.focusedClientId,
    required this.onSelectBlock,
    required this.onFocusBlock,
    required this.onUpdateAttributes,
  });

  @override
  Widget build(BuildContext context) {
    final columns = columnsBlock.innerBlocks;

    return Column(
      children: [
        for (int i = 0; i < columns.length; i++) ...[
          _ColumnPanel(
            columnBlock: columns[i],
            columnIndex: i,
            parentPath: path,
            selectionPath: selectionPath,
            onSelectBlock: onSelectBlock,
          ),
          if (i != columns.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _ColumnPanel extends StatelessWidget {
  final WpBlock columnBlock;
  final int columnIndex;
  final WpBlockPath parentPath;
  final WpBlockPath selectionPath;
  final void Function(WpBlockPath path) onSelectBlock;

  const _ColumnPanel({
    required this.columnBlock,
    required this.columnIndex,
    required this.parentPath,
    required this.selectionPath,
    required this.onSelectBlock,
  });

  @override
  Widget build(BuildContext context) {
    final columnPath = WpBlockPath(
      clientIds: [...parentPath.clientIds, columnBlock.clientId],
    );

    final isSelected =
        selectionPath.clientIds.isNotEmpty &&
        selectionPath.clientIds.last == columnBlock.clientId;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
              : Theme.of(context).dividerColor.withOpacity(0.15),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column header
          Row(
            children: [
              const Icon(Icons.view_column, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Column ${columnIndex + 1}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              IconButton(
                tooltip: 'Select column',
                onPressed: () => onSelectBlock(columnPath),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Icon-only summary of inner blocks
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final child in columnBlock.innerBlocks)
                _BlockIconChip(
                  block: child,
                  path: WpBlockPath(
                    clientIds: [...columnPath.clientIds, child.clientId],
                  ),
                  isSelected:
                      selectionPath.clientIds.isNotEmpty &&
                      selectionPath.clientIds.last == child.clientId,
                  onTap: () => onSelectBlock(
                    WpBlockPath(
                      clientIds: [...columnPath.clientIds, child.clientId],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BlockIconChip extends StatelessWidget {
  final WpBlock block;
  final WpBlockPath path;
  final bool isSelected;
  final VoidCallback onTap;

  const _BlockIconChip({
    required this.block,
    required this.path,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final spec = getBlockSpec(block.name);
    final icon = _iconForBlock(
      block.name,
      isContainer: spec?.isContainer ?? block.innerBlocks.isNotEmpty,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
                : Theme.of(context).dividerColor.withOpacity(0.25),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(
              blockRegistry[block.name]?.title ?? block.name,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForBlock(String name, {required bool isContainer}) {
    if (isContainer) return Icons.widgets_outlined;
    if (name == CoreBlockNames.paragraph) return Icons.notes_outlined;
    if (name == CoreBlockNames.heading) return Icons.title;
    if (name == CoreBlockNames.image) return Icons.image_outlined;
    if (name == CoreBlockNames.list) return Icons.format_list_bulleted;
    return Icons.extension_outlined;
  }
}

class _LeafBody extends StatelessWidget {
  final WpBlock block;
  final bool isFocused;

  final void Function(String? clientId) onFocusBlock;
  final void Function({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  })
  onUpdateAttributes;

  const _LeafBody({
    required this.block,
    required this.isFocused,
    required this.onFocusBlock,
    required this.onUpdateAttributes,
  });

  @override
  Widget build(BuildContext context) {
    // MVP: support paragraph + heading content editing via TextField.
    final isParagraph = block.name == CoreBlockNames.paragraph;
    final isHeading = block.name == CoreBlockNames.heading;

    if (!isParagraph && !isHeading) {
      return Text(
        'Unsupported leaf: ${block.name}',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    final content = (block.attributes['content'] as String?) ?? '';

    return TextFormField(
      key: ValueKey('leaf-${block.clientId}-${block.name}'),
      initialValue: content,
      maxLines: null,
      textInputAction: TextInputAction.newline,
      style: isHeading
          ? Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)
          : Theme.of(context).textTheme.bodyLarge,
      decoration: const InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: 'Type…',
      ),
      onTap: () => onFocusBlock(block.clientId),
      onChanged: (value) {
        onUpdateAttributes(
          clientId: block.clientId,
          attributesPatch: {'content': value},
        );
      },
    );
  }
}
