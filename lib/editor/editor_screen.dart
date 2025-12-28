import 'package:editor_app/editor/models/wp_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../wp_api/models/wp_post_type.dart';
import 'models/wp_block.dart';
import 'models/wp_block_path.dart';
import 'registry/block_view_registry.dart';
import 'registry/block_view_registry_core.dart';
import 'registry/block_view_registry_custom.dart';
import 'state/document_controller.dart';
import 'state/editor_ui_controller.dart';
import 'wp_api/providers.dart';
import 'widgets/editor_inspector_panel.dart';
import 'rendering/editor_canvas.dart';

final BlockViewRegistry _viewRegistry = () {
  final merged = BlockViewRegistry();

  void absorb(BlockViewRegistry other) {
    for (final entry in other.all.entries) {
      merged.register(entry.key, entry.value);
    }
  }

  absorb(buildCoreBlockViewRegistry());
  absorb(buildCustomBlockViewRegistry());

  return merged;
}();

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key, required this.postType, required this.postId});

  final WpPostType postType;
  final int postId;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  ProviderSubscription<AsyncValue<WpDocument>>? _sub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.postId != widget.postId ||
        oldWidget.postType != widget.postType) {
      _sub?.close();

      // Optional but usually correct UX:
      ref.read(editorControllerProvider.notifier)
        ..setSelectionPath(const WpBlockPath(clientIds: []))
        ..focusBlock(null);
    }
  }

  @override
  void dispose() {
    _sub?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docProvider = initialDocumentProvider((
      restBase: widget.postType.restBase,
      postId: widget.postId,
    ));
    final docAsync = ref.watch(docProvider);
    final editor = ref.watch(editorControllerProvider);
    debugPrint(
      'Editor state postId=${editor.document.postId} blocks=${editor.document.blocks.length}',
    );

    final controller = ref.read(editorControllerProvider.notifier);
    final ui = ref.watch(editorUiControllerProvider);
    final uiController = ref.read(editorUiControllerProvider.notifier);
    final selectedBlock = controller.getSelectedBlock(editor.selectionPath);

    int? lastHydratedPostId;

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
      data: (apiDoc) {
        if (lastHydratedPostId != apiDoc.postId) {
          lastHydratedPostId = apiDoc.postId;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            ref.read(editorControllerProvider.notifier).hydrateFromApi(apiDoc);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              apiDoc.title.isNotEmpty ? apiDoc.title : 'Untitled',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
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
                },
                onSelectClientId: (clientId) {
                  final found = controller.findByClientId(clientId);
                  if (found == null) return;
                  controller.setSelectionPath(found.path);
                },
                labelForClientId: (clientId) {
                  final found = controller.findByClientId(clientId);
                  if (found == null) return clientId.substring(0, 6);
                  final name = found.block.name; // or a nicer label mapping
                  return name.startsWith('core/') ? name.substring(5) : name;
                },
              ),
            ),
          ),
          body: Stack(
            children: [
              if (editor.document.blocks.isNotEmpty)
                KeyedSubtree(
                  key: ValueKey('canvas-${apiDoc.postId}'),
                  child: BlockViewRegistryScope(
                    registry: _viewRegistry,
                    child: EditorCanvas(
                      blocks: editor.document.blocks,
                      viewRegistry: _viewRegistry,
                      documentKey: apiDoc.postId.toString(),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    key: ValueKey('raw-editor-${apiDoc.postId}'),
                    initialValue: editor.document.rawContent,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Content (raw)',
                    ),
                    onChanged: controller.updateRawContent,
                  ),
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
  final String Function(String clientId) labelForClientId;

  const _BreadcrumbBar({
    required this.selectionPath,
    required this.onSelectPost,
    required this.onSelectClientId,
    required this.labelForClientId,
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
                  _Crumb(label: 'Post', onTap: onSelectPost),
                  for (final id in ids) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.chevron_right, size: 18),
                    ),
                    _Crumb(
                      label: labelForClientId(id),
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
