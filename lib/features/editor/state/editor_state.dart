import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/wp_document.dart';
import '../models/wp_block_path.dart';

part 'editor_state.freezed.dart';
part 'editor_state.g.dart';

@freezed
sealed class EditorState with _$EditorState {
  const factory EditorState({
    required WpDocument document,

    /// Breadcrumb selection path (clientIds from root -> selected)
    @Default(WpBlockPath()) WpBlockPath selectionPath,

    /// Focused leaf (for typing) in Edit Mode
    String? focusedClientId,

    /// Mode separation: Edit vs Layout
    @Default(false) bool isLayoutMode,
  }) = _EditorState;

  factory EditorState.fromJson(Map<String, dynamic> json) => _$EditorStateFromJson(json);
}
