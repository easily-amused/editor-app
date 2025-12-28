import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'registry/block_view_registry.dart';
import 'registry/block_view_registry_core.dart';
import 'registry/block_view_registry_custom.dart';

final blockViewRegistryProvider = Provider<BlockViewRegistry>((ref) {
  final merged = BlockViewRegistry();

  void absorb(BlockViewRegistry other) {
    for (final entry in other.all.entries) {
      merged.register(entry.key, entry.value);
    }
  }

  absorb(buildCoreBlockViewRegistry());
  absorb(buildCustomBlockViewRegistry());

  return merged;
});
