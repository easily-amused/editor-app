import 'package:flutter/material.dart';

import '../models/wp_block.dart';
import '../models/wp_block_path.dart';

class EditorInspectorPanel extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  /// null => Post/page settings
  final WpBlock? selectedBlock;
  final WpBlockPath selectionPath;

  const EditorInspectorPanel({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.selectedBlock,
    required this.selectionPath,
  });

  static const double _panelHeight = 280;

  @override
  Widget build(BuildContext context) {
    // Panel slides from top, overlays content (does not push it).
    return Stack(
      children: [
        // Scrim (tap to close)
        IgnorePointer(
          ignoring: !isOpen,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: isOpen ? 1 : 0,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
        ),

        // Sliding panel
        AnimatedPositioned(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          top: isOpen ? 0 : -_panelHeight - 12,
          left: 0,
          right: 0,
          height: _panelHeight,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _Header(
                      title: selectedBlock == null
                          ? 'Post settings'
                          : 'Block settings',
                      subtitle: selectedBlock == null
                          ? 'Page-level configuration'
                          : selectedBlock!.name,
                      onClose: onClose,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(12),
                        child: selectedBlock == null
                            ? const _PostSettings()
                            : _BlockSettings(block: selectedBlock!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onClose;

  const _Header({
    required this.title,
    required this.subtitle,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).hintColor),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: onClose,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class _PostSettings extends StatelessWidget {
  const _PostSettings();

  @override
  Widget build(BuildContext context) {
    // MVP placeholders (wire up to WP post fields later).
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Status',
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: 'draft',
          items: const [
            DropdownMenuItem(value: 'draft', child: Text('Draft')),
            DropdownMenuItem(value: 'publish', child: Text('Published')),
          ],
          onChanged: (_) {},
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Slug',
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: '',
          onChanged: (_) {},
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            hintText: 'my-page-slug',
          ),
        ),
        const SizedBox(height: 14),
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          contentPadding: EdgeInsets.zero,
          title: const Text('Allow comments'),
        ),
      ],
    );
  }
}

class _BlockSettings extends StatelessWidget {
  final WpBlock block;

  const _BlockSettings({required this.block});

  @override
  Widget build(BuildContext context) {
    // MVP: show + edit a few common attributes if present.
    final attrs = block.attributes;

    Widget attributeField(String key, {String? label}) {
      final v = attrs[key];
      final initial = v is String ? v : (v?.toString() ?? '');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label ?? key,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initial,
            onChanged: (_) {
              // Hook this up later via controller.updateBlockAttributes
              // (We keep this panel dumb/presentational for now.)
            },
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selected: ${block.name}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),

        if (attrs.containsKey('align')) attributeField('align', label: 'Align'),
        if (attrs.containsKey('level')) attributeField('level', label: 'Level'),
        if (attrs.containsKey('content'))
          attributeField('content', label: 'Content'),

        // Fallback: show raw keys
        if (attrs.isEmpty)
          Text(
            'No editable attributes (yet).',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).hintColor),
          ),
      ],
    );
  }
}
