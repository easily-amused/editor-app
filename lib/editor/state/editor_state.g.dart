// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EditorState _$EditorStateFromJson(Map<String, dynamic> json) => _EditorState(
  document: WpDocument.fromJson(json['document'] as Map<String, dynamic>),
  selectionPath: json['selectionPath'] == null
      ? const WpBlockPath()
      : WpBlockPath.fromJson(json['selectionPath'] as Map<String, dynamic>),
  focusedClientId: json['focusedClientId'] as String?,
  isLayoutMode: json['isLayoutMode'] as bool? ?? false,
);

Map<String, dynamic> _$EditorStateToJson(_EditorState instance) =>
    <String, dynamic>{
      'document': instance.document,
      'selectionPath': instance.selectionPath,
      'focusedClientId': instance.focusedClientId,
      'isLayoutMode': instance.isLayoutMode,
    };
