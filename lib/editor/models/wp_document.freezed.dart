// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpDocument {

 int get postId; String get postTypeRestBase; String get title; String get rawContent; List<WpBlock> get blocks; Map<String, dynamic> get meta;
/// Create a copy of WpDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpDocumentCopyWith<WpDocument> get copyWith => _$WpDocumentCopyWithImpl<WpDocument>(this as WpDocument, _$identity);

  /// Serializes this WpDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpDocument&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.postTypeRestBase, postTypeRestBase) || other.postTypeRestBase == postTypeRestBase)&&(identical(other.title, title) || other.title == title)&&(identical(other.rawContent, rawContent) || other.rawContent == rawContent)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&const DeepCollectionEquality().equals(other.meta, meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postId,postTypeRestBase,title,rawContent,const DeepCollectionEquality().hash(blocks),const DeepCollectionEquality().hash(meta));

@override
String toString() {
  return 'WpDocument(postId: $postId, postTypeRestBase: $postTypeRestBase, title: $title, rawContent: $rawContent, blocks: $blocks, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $WpDocumentCopyWith<$Res>  {
  factory $WpDocumentCopyWith(WpDocument value, $Res Function(WpDocument) _then) = _$WpDocumentCopyWithImpl;
@useResult
$Res call({
 int postId, String postTypeRestBase, String title, String rawContent, List<WpBlock> blocks, Map<String, dynamic> meta
});




}
/// @nodoc
class _$WpDocumentCopyWithImpl<$Res>
    implements $WpDocumentCopyWith<$Res> {
  _$WpDocumentCopyWithImpl(this._self, this._then);

  final WpDocument _self;
  final $Res Function(WpDocument) _then;

/// Create a copy of WpDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postId = null,Object? postTypeRestBase = null,Object? title = null,Object? rawContent = null,Object? blocks = null,Object? meta = null,}) {
  return _then(_self.copyWith(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,postTypeRestBase: null == postTypeRestBase ? _self.postTypeRestBase : postTypeRestBase // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rawContent: null == rawContent ? _self.rawContent : rawContent // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<WpBlock>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [WpDocument].
extension WpDocumentPatterns on WpDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpDocument value)  $default,){
final _that = this;
switch (_that) {
case _WpDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpDocument value)?  $default,){
final _that = this;
switch (_that) {
case _WpDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int postId,  String postTypeRestBase,  String title,  String rawContent,  List<WpBlock> blocks,  Map<String, dynamic> meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpDocument() when $default != null:
return $default(_that.postId,_that.postTypeRestBase,_that.title,_that.rawContent,_that.blocks,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int postId,  String postTypeRestBase,  String title,  String rawContent,  List<WpBlock> blocks,  Map<String, dynamic> meta)  $default,) {final _that = this;
switch (_that) {
case _WpDocument():
return $default(_that.postId,_that.postTypeRestBase,_that.title,_that.rawContent,_that.blocks,_that.meta);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int postId,  String postTypeRestBase,  String title,  String rawContent,  List<WpBlock> blocks,  Map<String, dynamic> meta)?  $default,) {final _that = this;
switch (_that) {
case _WpDocument() when $default != null:
return $default(_that.postId,_that.postTypeRestBase,_that.title,_that.rawContent,_that.blocks,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpDocument extends WpDocument {
  const _WpDocument({required this.postId, required this.postTypeRestBase, required this.title, required this.rawContent, final  List<WpBlock> blocks = const <WpBlock>[], final  Map<String, dynamic> meta = const <String, dynamic>{}}): _blocks = blocks,_meta = meta,super._();
  factory _WpDocument.fromJson(Map<String, dynamic> json) => _$WpDocumentFromJson(json);

@override final  int postId;
@override final  String postTypeRestBase;
@override final  String title;
@override final  String rawContent;
 final  List<WpBlock> _blocks;
@override@JsonKey() List<WpBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

 final  Map<String, dynamic> _meta;
@override@JsonKey() Map<String, dynamic> get meta {
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_meta);
}


/// Create a copy of WpDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpDocumentCopyWith<_WpDocument> get copyWith => __$WpDocumentCopyWithImpl<_WpDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpDocument&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.postTypeRestBase, postTypeRestBase) || other.postTypeRestBase == postTypeRestBase)&&(identical(other.title, title) || other.title == title)&&(identical(other.rawContent, rawContent) || other.rawContent == rawContent)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&const DeepCollectionEquality().equals(other._meta, _meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postId,postTypeRestBase,title,rawContent,const DeepCollectionEquality().hash(_blocks),const DeepCollectionEquality().hash(_meta));

@override
String toString() {
  return 'WpDocument(postId: $postId, postTypeRestBase: $postTypeRestBase, title: $title, rawContent: $rawContent, blocks: $blocks, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$WpDocumentCopyWith<$Res> implements $WpDocumentCopyWith<$Res> {
  factory _$WpDocumentCopyWith(_WpDocument value, $Res Function(_WpDocument) _then) = __$WpDocumentCopyWithImpl;
@override @useResult
$Res call({
 int postId, String postTypeRestBase, String title, String rawContent, List<WpBlock> blocks, Map<String, dynamic> meta
});




}
/// @nodoc
class __$WpDocumentCopyWithImpl<$Res>
    implements _$WpDocumentCopyWith<$Res> {
  __$WpDocumentCopyWithImpl(this._self, this._then);

  final _WpDocument _self;
  final $Res Function(_WpDocument) _then;

/// Create a copy of WpDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? postTypeRestBase = null,Object? title = null,Object? rawContent = null,Object? blocks = null,Object? meta = null,}) {
  return _then(_WpDocument(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,postTypeRestBase: null == postTypeRestBase ? _self.postTypeRestBase : postTypeRestBase // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rawContent: null == rawContent ? _self.rawContent : rawContent // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<WpBlock>,meta: null == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
