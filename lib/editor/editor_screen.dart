import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

import '../wp_api/models/wp_post_type.dart';
import 'editor_providers.dart';
import 'models/wp_document.dart';
import 'models/wp_block_path.dart';
import 'registry/block_view_registry.dart';
import 'state/document_controller.dart';
import 'state/editor_ui_controller.dart';
import 'widgets/editor_app_bar.dart';
import 'widgets/editor_body.dart';
import 'widgets/editor_scaffold.dart';
import 'wp_api/providers.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key, required this.postType, required this.postId});

  final WpPostType postType;
  final int postId;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  ProviderSubscription<AsyncValue<WpDocument>>? _docSub;

  ProviderListenable<AsyncValue<WpDocument>> _docProviderForWidget() {
    return initialDocumentProvider((
      restBase: widget.postType.restBase,
      postId: widget.postId,
    ));
  }

  void _attachDocListener() {
    _docSub?.close();

    final docProvider = _docProviderForWidget();

    _docSub = ref.listenManual<AsyncValue<WpDocument>>(docProvider, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (apiDoc) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            ref.read(editorControllerProvider.notifier).hydrateFromApi(apiDoc);
          });
        },
      );
    }, fireImmediately: true);
  }

  @override
  void initState() {
    super.initState();
    _attachDocListener();
  }

  @override
  void didUpdateWidget(covariant EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final changed =
        oldWidget.postId != widget.postId ||
        oldWidget.postType.restBase != widget.postType.restBase;

    if (changed) {
      _attachDocListener();

      ref.read(editorControllerProvider.notifier)
        ..setSelectionPath(const WpBlockPath(clientIds: []))
        ..focusBlock(null);
    }
  }

  @override
  void dispose() {
    _docSub?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docAsync = ref.watch(_docProviderForWidget());
    // ...
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
        final editor = ref.watch(editorControllerProvider);
        final controller = ref.read(editorControllerProvider.notifier);

        final ui = ref.watch(editorUiControllerProvider);
        final uiController = ref.read(editorUiControllerProvider.notifier);

        final viewRegistry = ref.watch(blockViewRegistryProvider);
        final selectedBlock = controller.getSelectedBlock(editor.selectionPath);

        return EditorScaffold(
          appBar: EditorTopBar(
            title: apiDoc.title,
            isInspectorOpen: ui.isInspectorOpen,
            isLayoutMode: editor.isLayoutMode,
            onToggleInspector: uiController.toggleInspector,
            onToggleLayoutMode: () =>
                controller.setLayoutMode(!editor.isLayoutMode),
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
              final name = found.block.name;
              return name.startsWith('core/') ? name.substring(5) : name;
            },
          ),
          body: BlockViewRegistryScope(
            registry: viewRegistry,
            child: EditorBody(
              postId: apiDoc.postId,
              blocks: editor.document.blocks,
              rawContent: editor.document.rawContent,
              viewRegistry: viewRegistry,
              documentKey: apiDoc.postId.toString(),
              onRawChanged: controller.updateRawContent,
              isInspectorOpen: ui.isInspectorOpen,
              onCloseInspector: uiController.closeInspector,
              selectedBlock: selectedBlock,
              selectionPath: editor.selectionPath,
            ),
          ),
        );
      },
    );
  }
}
