// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_block_path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpBlockPath {

 List<String> get clientIds;
/// Create a copy of WpBlockPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpBlockPathCopyWith<WpBlockPath> get copyWith => _$WpBlockPathCopyWithImpl<WpBlockPath>(this as WpBlockPath, _$identity);

  /// Serializes this WpBlockPath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpBlockPath&&const DeepCollectionEquality().equals(other.clientIds, clientIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(clientIds));

@override
String toString() {
  return 'WpBlockPath(clientIds: $clientIds)';
}


}

/// @nodoc
abstract mixin class $WpBlockPathCopyWith<$Res>  {
  factory $WpBlockPathCopyWith(WpBlockPath value, $Res Function(WpBlockPath) _then) = _$WpBlockPathCopyWithImpl;
@useResult
$Res call({
 List<String> clientIds
});




}
/// @nodoc
class _$WpBlockPathCopyWithImpl<$Res>
    implements $WpBlockPathCopyWith<$Res> {
  _$WpBlockPathCopyWithImpl(this._self, this._then);

  final WpBlockPath _self;
  final $Res Function(WpBlockPath) _then;

/// Create a copy of WpBlockPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientIds = null,}) {
  return _then(_self.copyWith(
clientIds: null == clientIds ? _self.clientIds : clientIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [WpBlockPath].
extension WpBlockPathPatterns on WpBlockPath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpBlockPath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpBlockPath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpBlockPath value)  $default,){
final _that = this;
switch (_that) {
case _WpBlockPath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpBlockPath value)?  $default,){
final _that = this;
switch (_that) {
case _WpBlockPath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> clientIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpBlockPath() when $default != null:
return $default(_that.clientIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> clientIds)  $default,) {final _that = this;
switch (_that) {
case _WpBlockPath():
return $default(_that.clientIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> clientIds)?  $default,) {final _that = this;
switch (_that) {
case _WpBlockPath() when $default != null:
return $default(_that.clientIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpBlockPath implements WpBlockPath {
  const _WpBlockPath({final  List<String> clientIds = const <String>[]}): _clientIds = clientIds;
  factory _WpBlockPath.fromJson(Map<String, dynamic> json) => _$WpBlockPathFromJson(json);

 final  List<String> _clientIds;
@override@JsonKey() List<String> get clientIds {
  if (_clientIds is EqualUnmodifiableListView) return _clientIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clientIds);
}


/// Create a copy of WpBlockPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpBlockPathCopyWith<_WpBlockPath> get copyWith => __$WpBlockPathCopyWithImpl<_WpBlockPath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpBlockPathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpBlockPath&&const DeepCollectionEquality().equals(other._clientIds, _clientIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_clientIds));

@override
String toString() {
  return 'WpBlockPath(clientIds: $clientIds)';
}


}

/// @nodoc
abstract mixin class _$WpBlockPathCopyWith<$Res> implements $WpBlockPathCopyWith<$Res> {
  factory _$WpBlockPathCopyWith(_WpBlockPath value, $Res Function(_WpBlockPath) _then) = __$WpBlockPathCopyWithImpl;
@override @useResult
$Res call({
 List<String> clientIds
});




}
/// @nodoc
class __$WpBlockPathCopyWithImpl<$Res>
    implements _$WpBlockPathCopyWith<$Res> {
  __$WpBlockPathCopyWithImpl(this._self, this._then);

  final _WpBlockPath _self;
  final $Res Function(_WpBlockPath) _then;

/// Create a copy of WpBlockPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientIds = null,}) {
  return _then(_WpBlockPath(
clientIds: null == clientIds ? _self._clientIds : clientIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
