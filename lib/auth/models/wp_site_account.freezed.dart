// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_site_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpSiteAccount {

 String get id; String get siteUrl; String get username; String get appPassword; String? get label; DateTime? get lastUsedAt;
/// Create a copy of WpSiteAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpSiteAccountCopyWith<WpSiteAccount> get copyWith => _$WpSiteAccountCopyWithImpl<WpSiteAccount>(this as WpSiteAccount, _$identity);

  /// Serializes this WpSiteAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpSiteAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.siteUrl, siteUrl) || other.siteUrl == siteUrl)&&(identical(other.username, username) || other.username == username)&&(identical(other.appPassword, appPassword) || other.appPassword == appPassword)&&(identical(other.label, label) || other.label == label)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,siteUrl,username,appPassword,label,lastUsedAt);

@override
String toString() {
  return 'WpSiteAccount(id: $id, siteUrl: $siteUrl, username: $username, appPassword: $appPassword, label: $label, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class $WpSiteAccountCopyWith<$Res>  {
  factory $WpSiteAccountCopyWith(WpSiteAccount value, $Res Function(WpSiteAccount) _then) = _$WpSiteAccountCopyWithImpl;
@useResult
$Res call({
 String id, String siteUrl, String username, String appPassword, String? label, DateTime? lastUsedAt
});




}
/// @nodoc
class _$WpSiteAccountCopyWithImpl<$Res>
    implements $WpSiteAccountCopyWith<$Res> {
  _$WpSiteAccountCopyWithImpl(this._self, this._then);

  final WpSiteAccount _self;
  final $Res Function(WpSiteAccount) _then;

/// Create a copy of WpSiteAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? siteUrl = null,Object? username = null,Object? appPassword = null,Object? label = freezed,Object? lastUsedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,siteUrl: null == siteUrl ? _self.siteUrl : siteUrl // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,appPassword: null == appPassword ? _self.appPassword : appPassword // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WpSiteAccount].
extension WpSiteAccountPatterns on WpSiteAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpSiteAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpSiteAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpSiteAccount value)  $default,){
final _that = this;
switch (_that) {
case _WpSiteAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpSiteAccount value)?  $default,){
final _that = this;
switch (_that) {
case _WpSiteAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String siteUrl,  String username,  String appPassword,  String? label,  DateTime? lastUsedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpSiteAccount() when $default != null:
return $default(_that.id,_that.siteUrl,_that.username,_that.appPassword,_that.label,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String siteUrl,  String username,  String appPassword,  String? label,  DateTime? lastUsedAt)  $default,) {final _that = this;
switch (_that) {
case _WpSiteAccount():
return $default(_that.id,_that.siteUrl,_that.username,_that.appPassword,_that.label,_that.lastUsedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String siteUrl,  String username,  String appPassword,  String? label,  DateTime? lastUsedAt)?  $default,) {final _that = this;
switch (_that) {
case _WpSiteAccount() when $default != null:
return $default(_that.id,_that.siteUrl,_that.username,_that.appPassword,_that.label,_that.lastUsedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpSiteAccount implements WpSiteAccount {
  const _WpSiteAccount({required this.id, required this.siteUrl, required this.username, required this.appPassword, this.label, this.lastUsedAt});
  factory _WpSiteAccount.fromJson(Map<String, dynamic> json) => _$WpSiteAccountFromJson(json);

@override final  String id;
@override final  String siteUrl;
@override final  String username;
@override final  String appPassword;
@override final  String? label;
@override final  DateTime? lastUsedAt;

/// Create a copy of WpSiteAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpSiteAccountCopyWith<_WpSiteAccount> get copyWith => __$WpSiteAccountCopyWithImpl<_WpSiteAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpSiteAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpSiteAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.siteUrl, siteUrl) || other.siteUrl == siteUrl)&&(identical(other.username, username) || other.username == username)&&(identical(other.appPassword, appPassword) || other.appPassword == appPassword)&&(identical(other.label, label) || other.label == label)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,siteUrl,username,appPassword,label,lastUsedAt);

@override
String toString() {
  return 'WpSiteAccount(id: $id, siteUrl: $siteUrl, username: $username, appPassword: $appPassword, label: $label, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class _$WpSiteAccountCopyWith<$Res> implements $WpSiteAccountCopyWith<$Res> {
  factory _$WpSiteAccountCopyWith(_WpSiteAccount value, $Res Function(_WpSiteAccount) _then) = __$WpSiteAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String siteUrl, String username, String appPassword, String? label, DateTime? lastUsedAt
});




}
/// @nodoc
class __$WpSiteAccountCopyWithImpl<$Res>
    implements _$WpSiteAccountCopyWith<$Res> {
  __$WpSiteAccountCopyWithImpl(this._self, this._then);

  final _WpSiteAccount _self;
  final $Res Function(_WpSiteAccount) _then;

/// Create a copy of WpSiteAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? siteUrl = null,Object? username = null,Object? appPassword = null,Object? label = freezed,Object? lastUsedAt = freezed,}) {
  return _then(_WpSiteAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,siteUrl: null == siteUrl ? _self.siteUrl : siteUrl // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,appPassword: null == appPassword ? _self.appPassword : appPassword // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
