import 'package:freezed_annotation/freezed_annotation.dart';

part 'wp_post_summary.freezed.dart';
part 'wp_post_summary.g.dart';

@freezed
sealed class WpPostSummary with _$WpPostSummary {
  const factory WpPostSummary({
    required int id,
    required String title,     // title.rendered flattened
    required String modified,  // ISO string
    required String status,
  }) = _WpPostSummary;

  const WpPostSummary._();

  factory WpPostSummary.fromJson(Map<String, dynamic> json) =>
      _$WpPostSummaryFromJson(json);
}
