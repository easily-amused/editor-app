import 'package:freezed_annotation/freezed_annotation.dart';

part 'wp_block_path.freezed.dart';
part 'wp_block_path.g.dart';

/// Parity-friendly selection path based on clientId.
/// Example: [columnsId, column2Id, paragraphId]
@freezed
sealed class WpBlockPath with _$WpBlockPath {
  const factory WpBlockPath({
    @Default(<String>[]) List<String> clientIds,
  }) = _WpBlockPath;

  factory WpBlockPath.fromJson(Map<String, dynamic> json) => _$WpBlockPathFromJson(json);
}
