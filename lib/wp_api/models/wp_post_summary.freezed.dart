// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wp_post_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WpPostSummary {

 int get id; String get title;// title.rendered flattened
 String get modified;// ISO string
 String get status;
/// Create a copy of WpPostSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WpPostSummaryCopyWith<WpPostSummary> get copyWith => _$WpPostSummaryCopyWithImpl<WpPostSummary>(this as WpPostSummary, _$identity);

  /// Serializes this WpPostSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WpPostSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,modified,status);

@override
String toString() {
  return 'WpPostSummary(id: $id, title: $title, modified: $modified, status: $status)';
}


}

/// @nodoc
abstract mixin class $WpPostSummaryCopyWith<$Res>  {
  factory $WpPostSummaryCopyWith(WpPostSummary value, $Res Function(WpPostSummary) _then) = _$WpPostSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String title, String modified, String status
});




}
/// @nodoc
class _$WpPostSummaryCopyWithImpl<$Res>
    implements $WpPostSummaryCopyWith<$Res> {
  _$WpPostSummaryCopyWithImpl(this._self, this._then);

  final WpPostSummary _self;
  final $Res Function(WpPostSummary) _then;

/// Create a copy of WpPostSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? modified = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WpPostSummary].
extension WpPostSummaryPatterns on WpPostSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WpPostSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WpPostSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WpPostSummary value)  $default,){
final _that = this;
switch (_that) {
case _WpPostSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WpPostSummary value)?  $default,){
final _that = this;
switch (_that) {
case _WpPostSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String modified,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WpPostSummary() when $default != null:
return $default(_that.id,_that.title,_that.modified,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String modified,  String status)  $default,) {final _that = this;
switch (_that) {
case _WpPostSummary():
return $default(_that.id,_that.title,_that.modified,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String modified,  String status)?  $default,) {final _that = this;
switch (_that) {
case _WpPostSummary() when $default != null:
return $default(_that.id,_that.title,_that.modified,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WpPostSummary extends WpPostSummary {
  const _WpPostSummary({required this.id, required this.title, required this.modified, required this.status}): super._();
  factory _WpPostSummary.fromJson(Map<String, dynamic> json) => _$WpPostSummaryFromJson(json);

@override final  int id;
@override final  String title;
// title.rendered flattened
@override final  String modified;
// ISO string
@override final  String status;

/// Create a copy of WpPostSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WpPostSummaryCopyWith<_WpPostSummary> get copyWith => __$WpPostSummaryCopyWithImpl<_WpPostSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WpPostSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WpPostSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,modified,status);

@override
String toString() {
  return 'WpPostSummary(id: $id, title: $title, modified: $modified, status: $status)';
}


}

/// @nodoc
abstract mixin class _$WpPostSummaryCopyWith<$Res> implements $WpPostSummaryCopyWith<$Res> {
  factory _$WpPostSummaryCopyWith(_WpPostSummary value, $Res Function(_WpPostSummary) _then) = __$WpPostSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String modified, String status
});




}
/// @nodoc
class __$WpPostSummaryCopyWithImpl<$Res>
    implements _$WpPostSummaryCopyWith<$Res> {
  __$WpPostSummaryCopyWithImpl(this._self, this._then);

  final _WpPostSummary _self;
  final $Res Function(_WpPostSummary) _then;

/// Create a copy of WpPostSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? modified = null,Object? status = null,}) {
  return _then(_WpPostSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,modified: null == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
