import 'package:flutter/material.dart';

import '../models/wp_block_path.dart';
import '../widgets/editor_breadcrumb_bar.dart';

class EditorTopBar extends StatelessWidget implements PreferredSizeWidget {
  const EditorTopBar({
    super.key,
    required this.title,
    required this.isInspectorOpen,
    required this.isLayoutMode,
    required this.onToggleInspector,
    required this.onToggleLayoutMode,
    required this.selectionPath,
    required this.onSelectPost,
    required this.onSelectClientId,
    required this.labelForClientId,
  });

  final String title;
  final bool isInspectorOpen;
  final bool isLayoutMode;
  final VoidCallback onToggleInspector;
  final VoidCallback onToggleLayoutMode;

  final WpBlockPath selectionPath;
  final VoidCallback onSelectPost;
  final void Function(String clientId) onSelectClientId;
  final String Function(String clientId) labelForClientId;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 44);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.isNotEmpty ? title : 'Untitled',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        IconButton(
          tooltip: 'Toggle settings',
          onPressed: onToggleInspector,
          icon: Icon(isInspectorOpen ? Icons.tune : Icons.tune_outlined),
        ),
        IconButton(
          tooltip: isLayoutMode ? 'Switch to Edit Mode' : 'Switch to Layout Mode',
          onPressed: onToggleLayoutMode,
          icon: Icon(isLayoutMode ? Icons.grid_view : Icons.edit),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: EditorBreadcrumbBar(
          selectionPath: selectionPath,
          onSelectPost: onSelectPost,
          onSelectClientId: onSelectClientId,
          labelForClientId: labelForClientId,
        ),
      ),
    );
  }
}
