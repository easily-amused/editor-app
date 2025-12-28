// lib/editor/wp_api/parsers/wp_block_mapper.dart
import 'package:uuid/uuid.dart';
import '../../models/wp_block.dart';

WpBlock wpBlockFromGutenberg(
  dynamic b, {
  required Uuid uuid,
}) {
  final map = (b as Map).cast<String, dynamic>();

  final name = (map['name'] as String?) ?? 'app/unknown';
  final attrs = (map['attributes'] as Map?)?.cast<String, dynamic>() ?? const {};
  final innerBlocks = (map['innerBlocks'] as List?) ?? const [];

  // Preserve source-y fields in a non-destructive way (matches your current pattern)
  final mergedAttrs = <String, dynamic>{
    ...attrs,
    if (map['innerHTML'] != null) '_innerHtml': map['innerHTML'],
    if (map['innerContent'] != null) '_innerContent': map['innerContent'],
  };

  return WpBlock(
    clientId: uuid.v4(),
    name: name,
    attributes: mergedAttrs,
    innerBlocks: innerBlocks.map((c) => wpBlockFromGutenberg(c, uuid: uuid)).toList(),
  );
}
