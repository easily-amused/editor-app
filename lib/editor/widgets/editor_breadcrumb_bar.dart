import 'package:flutter/material.dart';

import '../models/wp_block_path.dart';

class _EllipsisCrumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '…',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

Widget _chevron() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Icon(Icons.chevron_right, size: 18),
  );
}

class EditorBreadcrumbBar extends StatelessWidget {
  const EditorBreadcrumbBar({
    super.key,
    required this.selectionPath,
    required this.onSelectPost,
    required this.onSelectClientId,
    required this.labelForClientId,
  });

  final WpBlockPath selectionPath;
  final VoidCallback onSelectPost;
  final void Function(String clientId) onSelectClientId;
  final String Function(String clientId) labelForClientId;

  List<Widget> _buildCrumbs(BuildContext context) {
    final ids = selectionPath.clientIds;

    final List<Widget> crumbs = [_Crumb(label: 'Post', onTap: onSelectPost)];

    if (ids.length <= 2) {
      // Normal behavior: Post > A > B
      for (final id in ids) {
        crumbs.add(_chevron());
        crumbs.add(
          _Crumb(
            label: labelForClientId(id),
            onTap: () => onSelectClientId(id),
          ),
        );
      }
    } else {
      // Collapsed: Post > … > Active
      crumbs.add(_chevron());
      crumbs.add(_EllipsisCrumb());

      final lastId = ids.last;
      crumbs.add(_chevron());
      crumbs.add(
        _Crumb(
          label: labelForClientId(lastId),
          onTap: () => onSelectClientId(lastId),
        ),
      );
    }

    return crumbs;
  }

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
              child: Row(children: _buildCrumbs(context)),
            ),
    );
  }
}

class _Crumb extends StatelessWidget {
  const _Crumb({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

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
