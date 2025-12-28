import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/wp_block.dart';
import '../models/wp_document.dart';
import '../models/wp_block_path.dart';
import '../registry/block_registry.dart';

import 'editor_state.dart';

final editorControllerProvider =
    NotifierProvider.autoDispose<EditorController, EditorState>(
      EditorController.new,
    );

class EditorController extends Notifier<EditorState> {
  final _uuid = const Uuid();
  WpBlock? get selectedBlock => getSelectedBlock(state.selectionPath);

  @override
  EditorState build() {
    return EditorState(document: WpDocument.empty());
  }

  void updateRawContent(String value) {
    state = state.copyWith(
      document: state.document.copyWith(rawContent: value),
    );
  }

  void setLayoutMode(bool value) {
    state = state.copyWith(isLayoutMode: value);
  }

  void setSelectionPath(WpBlockPath path) {
    state = state.copyWith(selectionPath: path);
  }

  void focusBlock(String? clientId) {
    state = state.copyWith(focusedClientId: clientId);
  }

  ({WpBlock block, WpBlockPath path})? findByClientId(String clientId) {
    final roots = state.document.blocks;
    for (final root in roots) {
      final result = _findInTree(root, clientId, []);
      if (result != null) return result;
    }
    return null;
  }

  ({WpBlock block, WpBlockPath path})? _findInTree(
    WpBlock node,
    String targetId,
    List<String> trail,
  ) {
    final nextTrail = [...trail, node.clientId];
    if (node.clientId == targetId) {
      return (block: node, path: WpBlockPath(clientIds: nextTrail));
    }
    for (final child in node.innerBlocks) {
      final found = _findInTree(child, targetId, nextTrail);
      if (found != null) return found;
    }
    return null;
  }

  /// Get parent block of clientId (null if it’s a root block or not found).
  ({WpBlock parent, int indexInParent})? findParentOf(String clientId) {
    // Check root list first
    final roots = state.document.blocks;
    final idxRoot = roots.indexWhere((b) => b.clientId == clientId);
    if (idxRoot != -1) return null;

    for (final root in roots) {
      final found = _findParentInTree(root, clientId);
      if (found != null) return found;
    }
    return null;
  }

  ({WpBlock parent, int indexInParent})? _findParentInTree(
    WpBlock node,
    String childId,
  ) {
    final idx = node.innerBlocks.indexWhere((b) => b.clientId == childId);
    if (idx != -1) return (parent: node, indexInParent: idx);
    for (final child in node.innerBlocks) {
      final found = _findParentInTree(child, childId);
      if (found != null) return found;
    }
    return null;
  }

  WpBlock createBlock(
    String name, {
    Map<String, dynamic>? attributes,
    List<WpBlock>? innerBlocks,
  }) {
    return WpBlock(
      clientId: _uuid.v4(),
      name: name,
      attributes: attributes ?? getDefaultAttributes(name),
      innerBlocks: innerBlocks ?? const [],
    );
  }

  /// Insert a block into a parent container at index.
  /// If parentClientId is null => insert at root blocks list.
  void insertBlock({
    required String blockName,
    String? parentClientId,
    required int index,
    Map<String, dynamic>? attributes,
    List<WpBlock>? innerBlocks,
  }) {
    final newBlock = createBlock(
      blockName,
      attributes: attributes,
      innerBlocks: innerBlocks,
    );

    if (parentClientId == null) {
      final nextRoots = [...state.document.blocks]..insert(index, newBlock);
      state = state.copyWith(
        document: state.document.copyWith(blocks: nextRoots),
      );
      return;
    }

    final parentResult = findByClientId(parentClientId);
    if (parentResult == null) return;

    final parent = parentResult.block;
    if (!canInsertChild(parentName: parent.name, childName: newBlock.name))
      return;

    final updatedParent = parent.copyWith(
      innerBlocks: [...parent.innerBlocks]..insert(index, newBlock),
    );

    _replaceBlock(updatedParent);
  }

  /// Remove a block by clientId.
  void removeBlock(String clientId) {
    // Root removal
    final roots = state.document.blocks;
    final idx = roots.indexWhere((b) => b.clientId == clientId);
    if (idx != -1) {
      final nextRoots = [...roots]..removeAt(idx);
      state = state.copyWith(
        document: state.document.copyWith(blocks: nextRoots),
      );
      return;
    }

    final parentInfo = findParentOf(clientId);
    if (parentInfo == null) return;

    final parent = parentInfo.parent;
    final i = parentInfo.indexInParent;

    final nextChildren = [...parent.innerBlocks]..removeAt(i);
    _replaceBlock(parent.copyWith(innerBlocks: nextChildren));
  }

  /// Move a block to a new parent+index.
  /// If newParentClientId is null, move to root.
  void moveBlock({
    required String clientId,
    String? newParentClientId,
    required int newIndex,
  }) {
    final extracted = _extractBlock(clientId);
    if (extracted == null) return;

    final block = extracted;

    // Insert into new target
    if (newParentClientId == null) {
      final nextRoots = [...state.document.blocks]..insert(newIndex, block);
      state = state.copyWith(
        document: state.document.copyWith(blocks: nextRoots),
      );
      return;
    }

    final parentRes = findByClientId(newParentClientId);
    if (parentRes == null) return;

    final newParent = parentRes.block;
    if (!canInsertChild(parentName: newParent.name, childName: block.name)) {
      // If invalid, put it back where it came from? (MVP: just drop)
      return;
    }

    final updatedParent = newParent.copyWith(
      innerBlocks: [...newParent.innerBlocks]..insert(newIndex, block),
    );

    _replaceBlock(updatedParent);
  }

  /// Extract block from tree (removes it) and returns it.
  WpBlock? _extractBlock(String clientId) {
    // Root extraction
    final roots = state.document.blocks;
    final idx = roots.indexWhere((b) => b.clientId == clientId);
    if (idx != -1) {
      final nextRoots = [...roots];
      final removed = nextRoots.removeAt(idx);
      state = state.copyWith(
        document: state.document.copyWith(blocks: nextRoots),
      );
      return removed;
    }

    final parentInfo = findParentOf(clientId);
    if (parentInfo == null) return null;

    final parent = parentInfo.parent;
    final i = parentInfo.indexInParent;

    final nextChildren = [...parent.innerBlocks];
    final removed = nextChildren.removeAt(i);

    _replaceBlock(parent.copyWith(innerBlocks: nextChildren));
    return removed;
  }

  /// Replace an existing block (matched by clientId) anywhere in the document tree.
  void _replaceBlock(WpBlock updated) {
    final roots = state.document.blocks;
    final idx = roots.indexWhere((b) => b.clientId == updated.clientId);
    if (idx != -1) {
      final nextRoots = [...roots];
      nextRoots[idx] = updated;
      state = state.copyWith(
        document: state.document.copyWith(blocks: nextRoots),
      );
      return;
    }

    final nextRoots = roots
        .map((root) => _replaceInTree(root, updated))
        .toList();
    state = state.copyWith(
      document: state.document.copyWith(blocks: nextRoots),
    );
  }

  WpBlock _replaceInTree(WpBlock node, WpBlock updated) {
    if (node.clientId == updated.clientId) return updated;

    if (node.innerBlocks.isEmpty) return node;

    final nextChildren = node.innerBlocks
        .map((c) => _replaceInTree(c, updated))
        .toList();
    // Only copy if changed
    if (const ListEquality().equals(nextChildren, node.innerBlocks))
      return node;
    return node.copyWith(innerBlocks: nextChildren);
  }

  // ---------------------------
  // Columns helpers (MVP)
  // ---------------------------

  /// Resize columns widths on a core/columns block.
  /// widths must match number of innerBlocks and ideally sum to 1.0.
  void setColumnsWidths({
    required String columnsClientId,
    required List<double> widths,
  }) {
    final res = findByClientId(columnsClientId);
    if (res == null) return;
    final columns = res.block;
    if (columns.name != CoreBlockNames.columns) return;
    if (columns.innerBlocks.length != widths.length) return;

    // Normalize to sum=1.0
    final sum = widths.fold<double>(0, (a, b) => a + b);
    if (sum <= 0) return;
    final normalized = widths.map((w) => w / sum).toList();

    final updated = columns.copyWith(
      attributes: {...columns.attributes, 'columnWidths': normalized},
    );

    _replaceBlock(updated);
  }

  /// Add a new column at end (default width distribution).
  void addColumn({required String columnsClientId}) {
    final res = findByClientId(columnsClientId);
    if (res == null) return;
    final columns = res.block;
    if (columns.name != CoreBlockNames.columns) return;

    final newColumn = createBlock(
      CoreBlockNames.column,
      innerBlocks: [createBlock(CoreBlockNames.paragraph)],
    );

    final nextColumns = columns.copyWith(
      innerBlocks: [...columns.innerBlocks, newColumn],
    );

    // Adjust widths
    final count = nextColumns.innerBlocks.length;
    final widths = List<double>.filled(count, 1.0 / count);
    final updated = nextColumns.copyWith(
      attributes: {...nextColumns.attributes, 'columnWidths': widths},
    );

    _replaceBlock(updated);
  }

  bool _hydrated = false;

  void hydrateFromApi(WpDocument document) {
    if (_hydrated) return;
    debugPrint(
      '🧠 hydrateFromApi: current=${state.document.postId} -> next=${document.postId}',
    );
    _hydrated = true;

    state = state.copyWith(
      document: document,
      selectionPath: const WpBlockPath(clientIds: []),
      focusedClientId: null,
    );
  }

  void updateBlockAttributes({
    required String clientId,
    required Map<String, dynamic> attributesPatch,
  }) {
    final found = findByClientId(clientId);
    if (found == null) return;

    final block = found.block;
    final updated = block.copyWith(
      attributes: {...block.attributes, ...attributesPatch},
    );

    _replaceBlock(updated);
  }

  void selectPath(WpBlockPath path) {
    state = state.copyWith(selectionPath: path);
  }

  void clearSelection() {
    state = state.copyWith(selectionPath: const WpBlockPath(clientIds: []));
    // or null if you switch to nullable
  }
  
  WpBlock? getSelectedBlock(WpBlockPath selectionPath) {
    if (selectionPath.clientIds.isEmpty) return null;
    final selectedId = selectionPath.clientIds.last;
    final found = findByClientId(selectedId);
    return found?.block;
  }
}
