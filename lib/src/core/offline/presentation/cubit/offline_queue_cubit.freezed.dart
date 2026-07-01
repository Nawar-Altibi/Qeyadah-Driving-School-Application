// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_queue_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OfflineQueueState {

 OfflineQueueStatusEntity? get status;
/// Create a copy of OfflineQueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineQueueStateCopyWith<OfflineQueueState> get copyWith => _$OfflineQueueStateCopyWithImpl<OfflineQueueState>(this as OfflineQueueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineQueueState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'OfflineQueueState(status: $status)';
}


}

/// @nodoc
abstract mixin class $OfflineQueueStateCopyWith<$Res>  {
  factory $OfflineQueueStateCopyWith(OfflineQueueState value, $Res Function(OfflineQueueState) _then) = _$OfflineQueueStateCopyWithImpl;
@useResult
$Res call({
 OfflineQueueStatusEntity? status
});




}
/// @nodoc
class _$OfflineQueueStateCopyWithImpl<$Res>
    implements $OfflineQueueStateCopyWith<$Res> {
  _$OfflineQueueStateCopyWithImpl(this._self, this._then);

  final OfflineQueueState _self;
  final $Res Function(OfflineQueueState) _then;

/// Create a copy of OfflineQueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfflineQueueStatusEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [OfflineQueueState].
extension OfflineQueueStatePatterns on OfflineQueueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfflineQueueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfflineQueueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfflineQueueState value)  $default,){
final _that = this;
switch (_that) {
case _OfflineQueueState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfflineQueueState value)?  $default,){
final _that = this;
switch (_that) {
case _OfflineQueueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OfflineQueueStatusEntity? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfflineQueueState() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OfflineQueueStatusEntity? status)  $default,) {final _that = this;
switch (_that) {
case _OfflineQueueState():
return $default(_that.status);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OfflineQueueStatusEntity? status)?  $default,) {final _that = this;
switch (_that) {
case _OfflineQueueState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _OfflineQueueState implements OfflineQueueState {
  const _OfflineQueueState({this.status});
  

@override final  OfflineQueueStatusEntity? status;

/// Create a copy of OfflineQueueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineQueueStateCopyWith<_OfflineQueueState> get copyWith => __$OfflineQueueStateCopyWithImpl<_OfflineQueueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineQueueState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'OfflineQueueState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$OfflineQueueStateCopyWith<$Res> implements $OfflineQueueStateCopyWith<$Res> {
  factory _$OfflineQueueStateCopyWith(_OfflineQueueState value, $Res Function(_OfflineQueueState) _then) = __$OfflineQueueStateCopyWithImpl;
@override @useResult
$Res call({
 OfflineQueueStatusEntity? status
});




}
/// @nodoc
class __$OfflineQueueStateCopyWithImpl<$Res>
    implements _$OfflineQueueStateCopyWith<$Res> {
  __$OfflineQueueStateCopyWithImpl(this._self, this._then);

  final _OfflineQueueState _self;
  final $Res Function(_OfflineQueueState) _then;

/// Create a copy of OfflineQueueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,}) {
  return _then(_OfflineQueueState(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfflineQueueStatusEntity?,
  ));
}


}

// dart format on
