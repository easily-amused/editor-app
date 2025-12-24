// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_post_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpPostType {

 String get slug;// "post"
 String get name;// "Posts"
 String get restBase;
/// Create a copy of WpPostType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpPostTypeCopyWith<WpPostType> get copyWith => _$WpPostTypeCopyWithImpl<WpPostType>(this as WpPostType, _$identity);

  /// Serializes this WpPostType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpPostType&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.restBase, restBase) || other.restBase == restBase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,name,restBase);

@override
String toString() {
  return 'WpPostType(slug: $slug, name: $name, restBase: $restBase)';
}


}

/// @nodoc
abstract mixin class $WpPostTypeCopyWith<$Res>  {
  factory $WpPostTypeCopyWith(WpPostType value, $Res Function(WpPostType) _then) = _$WpPostTypeCopyWithImpl;
@useResult
$Res call({
 String slug, String name, String restBase
});




}
/// @nodoc
class _$WpPostTypeCopyWithImpl<$Res>
    implements $WpPostTypeCopyWith<$Res> {
  _$WpPostTypeCopyWithImpl(this._self, this._then);

  final WpPostType _self;
  final $Res Function(WpPostType) _then;

/// Create a copy of WpPostType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? name = null,Object? restBase = null,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,restBase: null == restBase ? _self.restBase : restBase // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WpPostType].
extension WpPostTypePatterns on WpPostType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpPostType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpPostType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpPostType value)  $default,){
final _that = this;
switch (_that) {
case _WpPostType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpPostType value)?  $default,){
final _that = this;
switch (_that) {
case _WpPostType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String name,  String restBase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpPostType() when $default != null:
return $default(_that.slug,_that.name,_that.restBase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String name,  String restBase)  $default,) {final _that = this;
switch (_that) {
case _WpPostType():
return $default(_that.slug,_that.name,_that.restBase);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String name,  String restBase)?  $default,) {final _that = this;
switch (_that) {
case _WpPostType() when $default != null:
return $default(_that.slug,_that.name,_that.restBase);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpPostType extends WpPostType {
  const _WpPostType({required this.slug, required this.name, required this.restBase}): super._();
  factory _WpPostType.fromJson(Map<String, dynamic> json) => _$WpPostTypeFromJson(json);

@override final  String slug;
// "post"
@override final  String name;
// "Posts"
@override final  String restBase;

/// Create a copy of WpPostType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpPostTypeCopyWith<_WpPostType> get copyWith => __$WpPostTypeCopyWithImpl<_WpPostType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpPostTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpPostType&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.restBase, restBase) || other.restBase == restBase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,name,restBase);

@override
String toString() {
  return 'WpPostType(slug: $slug, name: $name, restBase: $restBase)';
}


}

/// @nodoc
abstract mixin class _$WpPostTypeCopyWith<$Res> implements $WpPostTypeCopyWith<$Res> {
  factory _$WpPostTypeCopyWith(_WpPostType value, $Res Function(_WpPostType) _then) = __$WpPostTypeCopyWithImpl;
@override @useResult
$Res call({
 String slug, String name, String restBase
});




}
/// @nodoc
class __$WpPostTypeCopyWithImpl<$Res>
    implements _$WpPostTypeCopyWith<$Res> {
  __$WpPostTypeCopyWithImpl(this._self, this._then);

  final _WpPostType _self;
  final $Res Function(_WpPostType) _then;

/// Create a copy of WpPostType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? name = null,Object? restBase = null,}) {
  return _then(_WpPostType(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,restBase: null == restBase ? _self.restBase : restBase // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
