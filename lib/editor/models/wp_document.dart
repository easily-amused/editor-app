import 'package:freezed_annotation/freezed_annotation.dart';
import 'wp_block.dart';

part 'wp_document.freezed.dart';
part 'wp_document.g.dart';

@freezed
sealed class WpDocument with _$WpDocument {
  const factory WpDocument({
    @Default(<WpBlock>[]) List<WpBlock> blocks,
    @Default(<String, dynamic>{}) Map<String, dynamic> meta,
  }) = _WpDocument;

  factory WpDocument.fromJson(Map<String, dynamic> json) => _$WpDocumentFromJson(json);
}
