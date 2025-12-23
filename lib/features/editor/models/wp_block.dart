import 'package:freezed_annotation/freezed_annotation.dart';

part 'wp_block.freezed.dart';
part 'wp_block.g.dart';

/// Parity-first Gutenberg block model.
/// Mirrors the core fields Gutenberg developers expect:
/// - clientId
/// - name
/// - attributes
/// - innerBlocks
///
/// We also include a fidelity escape hatch for unsupported/unknown blocks.
@freezed
sealed class WpBlock with _$WpBlock {
  const factory WpBlock({
    required String clientId,
    required String name,
    @Default(<String, dynamic>{}) Map<String, dynamic> attributes,
    @Default(<WpBlock>[]) List<WpBlock> innerBlocks,
    @Default(<String>[]) List<String> innerContent,
    String? originalContent,
    @Default(false) bool isUnsupported,
  }) = _WpBlock;

  factory WpBlock.fromJson(Map<String, dynamic> json) => _$WpBlockFromJson(json);
}
