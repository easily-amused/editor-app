import 'package:freezed_annotation/freezed_annotation.dart';

part 'wp_post_type.freezed.dart';
part 'wp_post_type.g.dart';

@freezed
sealed class WpPostType with _$WpPostType {
  const factory WpPostType({
    required String slug,      // "post"
    required String name,      // "Posts"
    required String restBase,  // usually "posts"
  }) = _WpPostType;

  const WpPostType._();

  factory WpPostType.fromJson(Map<String, dynamic> json) =>
      _$WpPostTypeFromJson(json);
}
