import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'models/wp_post_type.dart';
import 'models/wp_post_summary.dart';
import 'wp_api_providers.dart';

final selectedPostTypeProvider = StateProvider<WpPostType?>((ref) => null);

final postTypesProvider = FutureProvider<List<WpPostType>>((ref) async {
  final client = ref.watch(wpApiClientProvider);
  if (client == null) throw Exception('Not authenticated');

  final json = await client.getJson(
    '/wp-json/wp/v2/types',
    query: {'context': 'edit'},
  );

  final map = (json as Map).cast<String, dynamic>();

  final types = <WpPostType>[];

  for (final entry in map.entries) {
    final v = (entry.value as Map).cast<String, dynamic>();

    final showInRest = v['viewable'];
    final isRestEnabled = showInRest == true || showInRest is Map;

    if (!isRestEnabled) continue;

    final slug = (v['slug'] ?? entry.key) as String;
    final name = (v['name'] ?? slug) as String;

    // rest_base might be top-level or inside show_in_rest object depending on registration
    final restBase =
        (v['rest_base'] as String?) ??
        (showInRest is Map ? (showInRest['rest_base'] as String?) : null) ??
        slug;

    types.add(WpPostType(slug: slug, name: name, restBase: restBase));
  }

  types.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return types;
});

final postsForTypeProvider =
    FutureProvider.family<List<WpPostSummary>, WpPostType>((ref, type) async {
      final client = ref.watch(wpApiClientProvider);
      if (client == null) throw Exception('Not authenticated');

      final json = await client.getJson(
        '/wp-json/wp/v2/${type.restBase}',
        query: {
          'per_page': '25',
          'orderby': 'modified',
          'order': 'desc',
          'context': 'edit',
          '_fields': 'id,title,modified,status',
        },
      );

      final list = (json as List).cast<dynamic>();

      return list.map((e) {
        final m = (e as Map).cast<String, dynamic>();
        final titleObj = (m['title'] as Map?)?.cast<String, dynamic>();
        final rendered = (titleObj?['rendered'] as String?) ?? '(untitled)';

        return WpPostSummary(
          id: m['id'] as int,
          title: rendered,
          modified: (m['modified'] as String?) ?? '',
          status: (m['status'] as String?) ?? '',
        );
      }).toList();
    });
