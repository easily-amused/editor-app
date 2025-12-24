// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditorState {

 WpDocument get document;/// Breadcrumb selection path (clientIds from root -> selected)
 WpBlockPath get selectionPath;/// Focused leaf (for typing) in Edit Mode
 String? get focusedClientId;/// Mode separation: Edit vs Layout
 bool get isLayoutMode;
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorStateCopyWith<EditorState> get copyWith => _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);

  /// Serializes this EditorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorState&&(identical(other.document, document) || other.document == document)&&(identical(other.selectionPath, selectionPath) || other.selectionPath == selectionPath)&&(identical(other.focusedClientId, focusedClientId) || other.focusedClientId == focusedClientId)&&(identical(other.isLayoutMode, isLayoutMode) || other.isLayoutMode == isLayoutMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,document,selectionPath,focusedClientId,isLayoutMode);

@override
String toString() {
  return 'EditorState(document: $document, selectionPath: $selectionPath, focusedClientId: $focusedClientId, isLayoutMode: $isLayoutMode)';
}


}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res>  {
  factory $EditorStateCopyWith(EditorState value, $Res Function(EditorState) _then) = _$EditorStateCopyWithImpl;
@useResult
$Res call({
 WpDocument document, WpBlockPath selectionPath, String? focusedClientId, bool isLayoutMode
});


$WpDocumentCopyWith<$Res> get document;$WpBlockPathCopyWith<$Res> get selectionPath;

}
/// @nodoc
class _$EditorStateCopyWithImpl<$Res>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? document = null,Object? selectionPath = null,Object? focusedClientId = freezed,Object? isLayoutMode = null,}) {
  return _then(_self.copyWith(
document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as WpDocument,selectionPath: null == selectionPath ? _self.selectionPath : selectionPath // ignore: cast_nullable_to_non_nullable
as WpBlockPath,focusedClientId: freezed == focusedClientId ? _self.focusedClientId : focusedClientId // ignore: cast_nullable_to_non_nullable
as String?,isLayoutMode: null == isLayoutMode ? _self.isLayoutMode : isLayoutMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WpDocumentCopyWith<$Res> get document {
  
  return $WpDocumentCopyWith<$Res>(_self.document, (value) {
    return _then(_self.copyWith(document: value));
  });
}/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WpBlockPathCopyWith<$Res> get selectionPath {
  
  return $WpBlockPathCopyWith<$Res>(_self.selectionPath, (value) {
    return _then(_self.copyWith(selectionPath: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditorState].
extension EditorStatePatterns on EditorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditorState value)  $default,){
final _that = this;
switch (_that) {
case _EditorState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditorState value)?  $default,){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WpDocument document,  WpBlockPath selectionPath,  String? focusedClientId,  bool isLayoutMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.document,_that.selectionPath,_that.focusedClientId,_that.isLayoutMode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WpDocument document,  WpBlockPath selectionPath,  String? focusedClientId,  bool isLayoutMode)  $default,) {final _that = this;
switch (_that) {
case _EditorState():
return $default(_that.document,_that.selectionPath,_that.focusedClientId,_that.isLayoutMode);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WpDocument document,  WpBlockPath selectionPath,  String? focusedClientId,  bool isLayoutMode)?  $default,) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.document,_that.selectionPath,_that.focusedClientId,_that.isLayoutMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EditorState implements EditorState {
  const _EditorState({required this.document, this.selectionPath = const WpBlockPath(), this.focusedClientId, this.isLayoutMode = false});
  factory _EditorState.fromJson(Map<String, dynamic> json) => _$EditorStateFromJson(json);

@override final  WpDocument document;
/// Breadcrumb selection path (clientIds from root -> selected)
@override@JsonKey() final  WpBlockPath selectionPath;
/// Focused leaf (for typing) in Edit Mode
@override final  String? focusedClientId;
/// Mode separation: Edit vs Layout
@override@JsonKey() final  bool isLayoutMode;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorStateCopyWith<_EditorState> get copyWith => __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EditorStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorState&&(identical(other.document, document) || other.document == document)&&(identical(other.selectionPath, selectionPath) || other.selectionPath == selectionPath)&&(identical(other.focusedClientId, focusedClientId) || other.focusedClientId == focusedClientId)&&(identical(other.isLayoutMode, isLayoutMode) || other.isLayoutMode == isLayoutMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,document,selectionPath,focusedClientId,isLayoutMode);

@override
String toString() {
  return 'EditorState(document: $document, selectionPath: $selectionPath, focusedClientId: $focusedClientId, isLayoutMode: $isLayoutMode)';
}


}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res> implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(_EditorState value, $Res Function(_EditorState) _then) = __$EditorStateCopyWithImpl;
@override @useResult
$Res call({
 WpDocument document, WpBlockPath selectionPath, String? focusedClientId, bool isLayoutMode
});


@override $WpDocumentCopyWith<$Res> get document;@override $WpBlockPathCopyWith<$Res> get selectionPath;

}
/// @nodoc
class __$EditorStateCopyWithImpl<$Res>
    implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? document = null,Object? selectionPath = null,Object? focusedClientId = freezed,Object? isLayoutMode = null,}) {
  return _then(_EditorState(
document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as WpDocument,selectionPath: null == selectionPath ? _self.selectionPath : selectionPath // ignore: cast_nullable_to_non_nullable
as WpBlockPath,focusedClientId: freezed == focusedClientId ? _self.focusedClientId : focusedClientId // ignore: cast_nullable_to_non_nullable
as String?,isLayoutMode: null == isLayoutMode ? _self.isLayoutMode : isLayoutMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WpDocumentCopyWith<$Res> get document {
  
  return $WpDocumentCopyWith<$Res>(_self.document, (value) {
    return _then(_self.copyWith(document: value));
  });
}/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WpBlockPathCopyWith<$Res> get selectionPath {
  
  return $WpBlockPathCopyWith<$Res>(_self.selectionPath, (value) {
    return _then(_self.copyWith(selectionPath: value));
  });
}
}

// dart format on
