import 'package:editor_app/ui/connect_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../wp_api/content_providers.dart';
import '../wp_api/models/wp_post_type.dart';
import '../editor/editor_screen.dart';

// ✅ add these imports based on where you put them
import '../auth/providers.dart'; // sessionControllerProvider, activeSiteProvider
import '../auth/models/wp_site_account.dart';

class _SitesSheet extends ConsumerWidget {
  const _SitesSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider).asData?.value;
    final sites = session?.sites ?? const [];
    final activeId = session?.activeSiteId;

    return ListView(
      shrinkWrap: true,
      children: [
        const ListTile(
          title: Text('Sites'),
          subtitle: Text('Switch or add a new WordPress site'),
        ),
        for (final s in sites)
          ListTile(
            leading: Icon(
              s.id == activeId ? Icons.check_circle : Icons.circle_outlined,
            ),
            title: Text(
              (s.label?.trim().isNotEmpty ?? false)
                  ? s.label!.trim()
                  : _hostFromUrl(s.siteUrl),
            ),
            subtitle: Text(s.siteUrl),
            onTap: () async {
              await ref
                  .read(sessionControllerProvider.notifier)
                  .setActiveSite(s.id);

              ref.read(selectedPostTypeProvider.notifier).state = null;
              ref.invalidate(postTypesProvider);

              Navigator.of(context).pop();
            },
          ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Add a site'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ConnectScreen(isAddingSite: true),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ContentPickerScreen extends ConsumerWidget {
  const ContentPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionControllerProvider);
    final activeSite = ref.watch(activeSiteProvider);

    final typesAsync = ref.watch(postTypesProvider);
    final selectedType = ref.watch(selectedPostTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose content'),
        actions: [
          IconButton(
            tooltip: 'Sites',
            icon: const Icon(Icons.domain),
            onPressed: () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (_) => const _SitesSheet(),
            ),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(postTypesProvider);
              final t = ref.read(selectedPostTypeProvider);
              if (t != null) {
                ref.invalidate(postsForTypeProvider(t));
              }
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Failed to load session: $e')),
        data: (session) {
          final sites = session?.sites ?? const <WpSiteAccount>[];

          if (sites.isEmpty) {
            return const Center(
              child: Text('No sites connected yet. Go add a site first.'),
            );
          }

          final effectiveSiteId = (activeSite?.id ?? sites.first.id);

          // Now render the rest as you already do:
          return typesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) =>
                Center(child: Text('Failed to load post types: $e')),
            data: (types) {
              if (types.isEmpty) {
                return const Center(
                  child: Text('No REST-enabled post types found.'),
                );
              }

              final sortedTypes = [
                ...types.where((t) => t.slug == 'post'),
                ...types.where((t) => t.slug != 'post'),
              ];

              final defaultType = sortedTypes.firstWhere(
                (t) => t.slug == 'post',
                orElse: () => sortedTypes.first,
              );

              final effectiveType = selectedType ?? defaultType;

              // Auto-select first type on first load
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final cur = ref.read(selectedPostTypeProvider);
                if (cur == null) {
                  ref.read(selectedPostTypeProvider.notifier).state =
                      effectiveType;
                }
              });

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: effectiveSiteId,
                            decoration: const InputDecoration(
                              labelText: 'Site',
                            ),
                            items: sites.map((s) {
                              final label =
                                  (s.label?.trim().isNotEmpty ?? false)
                                  ? s.label!.trim()
                                  : _hostFromUrl(s.siteUrl);
                              return DropdownMenuItem(
                                value: s.id,
                                child: Text(label),
                              );
                            }).toList(),
                            onChanged: (siteId) async {
                              if (siteId == null || siteId == effectiveSiteId)
                                return;

                              await ref
                                  .read(sessionControllerProvider.notifier)
                                  .setActiveSite(siteId);

                              ref
                                      .read(selectedPostTypeProvider.notifier)
                                      .state =
                                  null;
                              ref.invalidate(postTypesProvider);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // your existing POST TYPE DROPDOWN
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField<WpPostType>(
                      value: effectiveType,
                      decoration: const InputDecoration(labelText: 'Post type'),
                      items: types
                          .map(
                            (t) =>
                                DropdownMenuItem(value: t, child: Text(t.name)),
                          )
                          .toList(),
                      onChanged: (t) {
                        if (t == null) return;
                        ref.read(selectedPostTypeProvider.notifier).state = t;
                      },
                    ),
                  ),

                  const Divider(height: 1),
                  Expanded(child: _PostsList(type: effectiveType)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

String _hostFromUrl(String url) {
  try {
    return Uri.parse(url).host;
  } catch (_) {
    return url;
  }
}

class _PostsList extends ConsumerWidget {
  const _PostsList({required this.type});
  final WpPostType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsForTypeProvider(type));

    return postsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Failed to load posts: $e')),
      data: (posts) {
        if (posts.isEmpty) {
          return const Center(child: Text('No posts found.'));
        }

        return ListView.separated(
          itemCount: posts.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final p = posts[i];
            return ListTile(
              title: Text(p.title),
              subtitle: Text('${p.status} • ${p.modified}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EditorScreen(postType: type, postId: p.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
