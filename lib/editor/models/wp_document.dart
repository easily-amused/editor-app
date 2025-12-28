import 'package:freezed_annotation/freezed_annotation.dart';
import 'wp_block.dart';

part 'wp_document.freezed.dart';
part 'wp_document.g.dart';

@freezed
sealed class WpDocument with _$WpDocument {
  const factory WpDocument({
    required int postId,
    required String postTypeRestBase,
    required String title,
    required String rawContent,
    @Default(<WpBlock>[]) List<WpBlock> blocks,
    @Default(<String, dynamic>{}) Map<String, dynamic> meta,
  }) = _WpDocument;

  const WpDocument._(); // <-- add this to allow custom getters / methods

  factory WpDocument.empty() => const WpDocument(
        postId: 0,
        postTypeRestBase: '',
        title: '',
        rawContent: '',
        blocks: <WpBlock>[],
        meta: <String, dynamic>{},
      );

  factory WpDocument.fromJson(Map<String, dynamic> json) =>
      _$WpDocumentFromJson(json);
}

