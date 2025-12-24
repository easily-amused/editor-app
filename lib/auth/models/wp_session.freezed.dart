// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpSession {

 List<WpSiteAccount> get sites; String? get activeSiteId;
/// Create a copy of WpSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpSessionCopyWith<WpSession> get copyWith => _$WpSessionCopyWithImpl<WpSession>(this as WpSession, _$identity);

  /// Serializes this WpSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpSession&&const DeepCollectionEquality().equals(other.sites, sites)&&(identical(other.activeSiteId, activeSiteId) || other.activeSiteId == activeSiteId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sites),activeSiteId);

@override
String toString() {
  return 'WpSession(sites: $sites, activeSiteId: $activeSiteId)';
}


}

/// @nodoc
abstract mixin class $WpSessionCopyWith<$Res>  {
  factory $WpSessionCopyWith(WpSession value, $Res Function(WpSession) _then) = _$WpSessionCopyWithImpl;
@useResult
$Res call({
 List<WpSiteAccount> sites, String? activeSiteId
});




}
/// @nodoc
class _$WpSessionCopyWithImpl<$Res>
    implements $WpSessionCopyWith<$Res> {
  _$WpSessionCopyWithImpl(this._self, this._then);

  final WpSession _self;
  final $Res Function(WpSession) _then;

/// Create a copy of WpSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sites = null,Object? activeSiteId = freezed,}) {
  return _then(_self.copyWith(
sites: null == sites ? _self.sites : sites // ignore: cast_nullable_to_non_nullable
as List<WpSiteAccount>,activeSiteId: freezed == activeSiteId ? _self.activeSiteId : activeSiteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WpSession].
extension WpSessionPatterns on WpSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpSession value)  $default,){
final _that = this;
switch (_that) {
case _WpSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpSession value)?  $default,){
final _that = this;
switch (_that) {
case _WpSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WpSiteAccount> sites,  String? activeSiteId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpSession() when $default != null:
return $default(_that.sites,_that.activeSiteId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WpSiteAccount> sites,  String? activeSiteId)  $default,) {final _that = this;
switch (_that) {
case _WpSession():
return $default(_that.sites,_that.activeSiteId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WpSiteAccount> sites,  String? activeSiteId)?  $default,) {final _that = this;
switch (_that) {
case _WpSession() when $default != null:
return $default(_that.sites,_that.activeSiteId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpSession implements WpSession {
  const _WpSession({required final  List<WpSiteAccount> sites, required this.activeSiteId}): _sites = sites;
  factory _WpSession.fromJson(Map<String, dynamic> json) => _$WpSessionFromJson(json);

 final  List<WpSiteAccount> _sites;
@override List<WpSiteAccount> get sites {
  if (_sites is EqualUnmodifiableListView) return _sites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sites);
}

@override final  String? activeSiteId;

/// Create a copy of WpSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpSessionCopyWith<_WpSession> get copyWith => __$WpSessionCopyWithImpl<_WpSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpSession&&const DeepCollectionEquality().equals(other._sites, _sites)&&(identical(other.activeSiteId, activeSiteId) || other.activeSiteId == activeSiteId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sites),activeSiteId);

@override
String toString() {
  return 'WpSession(sites: $sites, activeSiteId: $activeSiteId)';
}


}

/// @nodoc
abstract mixin class _$WpSessionCopyWith<$Res> implements $WpSessionCopyWith<$Res> {
  factory _$WpSessionCopyWith(_WpSession value, $Res Function(_WpSession) _then) = __$WpSessionCopyWithImpl;
@override @useResult
$Res call({
 List<WpSiteAccount> sites, String? activeSiteId
});




}
/// @nodoc
class __$WpSessionCopyWithImpl<$Res>
    implements _$WpSessionCopyWith<$Res> {
  __$WpSessionCopyWithImpl(this._self, this._then);

  final _WpSession _self;
  final $Res Function(_WpSession) _then;

/// Create a copy of WpSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sites = null,Object? activeSiteId = freezed,}) {
  return _then(_WpSession(
sites: null == sites ? _self._sites : sites // ignore: cast_nullable_to_non_nullable
as List<WpSiteAccount>,activeSiteId: freezed == activeSiteId ? _self.activeSiteId : activeSiteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
