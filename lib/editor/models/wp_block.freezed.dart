// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpBlock {

 String get clientId; String get name; Map<String, dynamic> get attributes; List<WpBlock> get innerBlocks; List<String> get innerContent; String? get originalContent; bool get isUnsupported;
/// Create a copy of WpBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpBlockCopyWith<WpBlock> get copyWith => _$WpBlockCopyWithImpl<WpBlock>(this as WpBlock, _$identity);

  /// Serializes this WpBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpBlock&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&const DeepCollectionEquality().equals(other.innerBlocks, innerBlocks)&&const DeepCollectionEquality().equals(other.innerContent, innerContent)&&(identical(other.originalContent, originalContent) || other.originalContent == originalContent)&&(identical(other.isUnsupported, isUnsupported) || other.isUnsupported == isUnsupported));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,name,const DeepCollectionEquality().hash(attributes),const DeepCollectionEquality().hash(innerBlocks),const DeepCollectionEquality().hash(innerContent),originalContent,isUnsupported);

@override
String toString() {
  return 'WpBlock(clientId: $clientId, name: $name, attributes: $attributes, innerBlocks: $innerBlocks, innerContent: $innerContent, originalContent: $originalContent, isUnsupported: $isUnsupported)';
}


}

/// @nodoc
abstract mixin class $WpBlockCopyWith<$Res>  {
  factory $WpBlockCopyWith(WpBlock value, $Res Function(WpBlock) _then) = _$WpBlockCopyWithImpl;
@useResult
$Res call({
 String clientId, String name, Map<String, dynamic> attributes, List<WpBlock> innerBlocks, List<String> innerContent, String? originalContent, bool isUnsupported
});




}
/// @nodoc
class _$WpBlockCopyWithImpl<$Res>
    implements $WpBlockCopyWith<$Res> {
  _$WpBlockCopyWithImpl(this._self, this._then);

  final WpBlock _self;
  final $Res Function(WpBlock) _then;

/// Create a copy of WpBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? name = null,Object? attributes = null,Object? innerBlocks = null,Object? innerContent = null,Object? originalContent = freezed,Object? isUnsupported = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,innerBlocks: null == innerBlocks ? _self.innerBlocks : innerBlocks // ignore: cast_nullable_to_non_nullable
as List<WpBlock>,innerContent: null == innerContent ? _self.innerContent : innerContent // ignore: cast_nullable_to_non_nullable
as List<String>,originalContent: freezed == originalContent ? _self.originalContent : originalContent // ignore: cast_nullable_to_non_nullable
as String?,isUnsupported: null == isUnsupported ? _self.isUnsupported : isUnsupported // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WpBlock].
extension WpBlockPatterns on WpBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpBlock value)  $default,){
final _that = this;
switch (_that) {
case _WpBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpBlock value)?  $default,){
final _that = this;
switch (_that) {
case _WpBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String name,  Map<String, dynamic> attributes,  List<WpBlock> innerBlocks,  List<String> innerContent,  String? originalContent,  bool isUnsupported)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpBlock() when $default != null:
return $default(_that.clientId,_that.name,_that.attributes,_that.innerBlocks,_that.innerContent,_that.originalContent,_that.isUnsupported);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String name,  Map<String, dynamic> attributes,  List<WpBlock> innerBlocks,  List<String> innerContent,  String? originalContent,  bool isUnsupported)  $default,) {final _that = this;
switch (_that) {
case _WpBlock():
return $default(_that.clientId,_that.name,_that.attributes,_that.innerBlocks,_that.innerContent,_that.originalContent,_that.isUnsupported);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String name,  Map<String, dynamic> attributes,  List<WpBlock> innerBlocks,  List<String> innerContent,  String? originalContent,  bool isUnsupported)?  $default,) {final _that = this;
switch (_that) {
case _WpBlock() when $default != null:
return $default(_that.clientId,_that.name,_that.attributes,_that.innerBlocks,_that.innerContent,_that.originalContent,_that.isUnsupported);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpBlock implements WpBlock {
  const _WpBlock({required this.clientId, required this.name, final  Map<String, dynamic> attributes = const <String, dynamic>{}, final  List<WpBlock> innerBlocks = const <WpBlock>[], final  List<String> innerContent = const <String>[], this.originalContent, this.isUnsupported = false}): _attributes = attributes,_innerBlocks = innerBlocks,_innerContent = innerContent;
  factory _WpBlock.fromJson(Map<String, dynamic> json) => _$WpBlockFromJson(json);

@override final  String clientId;
@override final  String name;
 final  Map<String, dynamic> _attributes;
@override@JsonKey() Map<String, dynamic> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}

 final  List<WpBlock> _innerBlocks;
@override@JsonKey() List<WpBlock> get innerBlocks {
  if (_innerBlocks is EqualUnmodifiableListView) return _innerBlocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_innerBlocks);
}

 final  List<String> _innerContent;
@override@JsonKey() List<String> get innerContent {
  if (_innerContent is EqualUnmodifiableListView) return _innerContent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_innerContent);
}

@override final  String? originalContent;
@override@JsonKey() final  bool isUnsupported;

/// Create a copy of WpBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpBlockCopyWith<_WpBlock> get copyWith => __$WpBlockCopyWithImpl<_WpBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpBlock&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&const DeepCollectionEquality().equals(other._innerBlocks, _innerBlocks)&&const DeepCollectionEquality().equals(other._innerContent, _innerContent)&&(identical(other.originalContent, originalContent) || other.originalContent == originalContent)&&(identical(other.isUnsupported, isUnsupported) || other.isUnsupported == isUnsupported));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,name,const DeepCollectionEquality().hash(_attributes),const DeepCollectionEquality().hash(_innerBlocks),const DeepCollectionEquality().hash(_innerContent),originalContent,isUnsupported);

@override
String toString() {
  return 'WpBlock(clientId: $clientId, name: $name, attributes: $attributes, innerBlocks: $innerBlocks, innerContent: $innerContent, originalContent: $originalContent, isUnsupported: $isUnsupported)';
}


}

/// @nodoc
abstract mixin class _$WpBlockCopyWith<$Res> implements $WpBlockCopyWith<$Res> {
  factory _$WpBlockCopyWith(_WpBlock value, $Res Function(_WpBlock) _then) = __$WpBlockCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String name, Map<String, dynamic> attributes, List<WpBlock> innerBlocks, List<String> innerContent, String? originalContent, bool isUnsupported
});




}
/// @nodoc
class __$WpBlockCopyWithImpl<$Res>
    implements _$WpBlockCopyWith<$Res> {
  __$WpBlockCopyWithImpl(this._self, this._then);

  final _WpBlock _self;
  final $Res Function(_WpBlock) _then;

/// Create a copy of WpBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? name = null,Object? attributes = null,Object? innerBlocks = null,Object? innerContent = null,Object? originalContent = freezed,Object? isUnsupported = null,}) {
  return _then(_WpBlock(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,innerBlocks: null == innerBlocks ? _self._innerBlocks : innerBlocks // ignore: cast_nullable_to_non_nullable
as List<WpBlock>,innerContent: null == innerContent ? _self._innerContent : innerContent // ignore: cast_nullable_to_non_nullable
as List<String>,originalContent: freezed == originalContent ? _self.originalContent : originalContent // ignore: cast_nullable_to_non_nullable
as String?,isUnsupported: null == isUnsupported ? _self.isUnsupported : isUnsupported // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
