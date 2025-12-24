import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editorUiControllerProvider =
    NotifierProvider<EditorUiController, EditorUiState>(
  EditorUiController.new,
);

@immutable
class EditorUiState {
  final bool isInspectorOpen;

  const EditorUiState({required this.isInspectorOpen});

  EditorUiState copyWith({bool? isInspectorOpen}) => EditorUiState(
        isInspectorOpen: isInspectorOpen ?? this.isInspectorOpen,
      );
}

class EditorUiController extends Notifier<EditorUiState> {
  @override
  EditorUiState build() {
    return const EditorUiState(isInspectorOpen: false);
  }

  void toggleInspector() {
    state = state.copyWith(isInspectorOpen: !state.isInspectorOpen);
  }

  void openInspector() {
    state = state.copyWith(isInspectorOpen: true);
  }

  void closeInspector() {
    state = state.copyWith(isInspectorOpen: false);
  }
}
