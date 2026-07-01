// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthSessionState {

 ApiState<AuthSessionEntity> get apiState; bool get isLoggingIn; AuthSessionEffect? get loginEffect;
/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionStateCopyWith<AuthSessionState> get copyWith => _$AuthSessionStateCopyWithImpl<AuthSessionState>(this as AuthSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSessionState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isLoggingIn, isLoggingIn) || other.isLoggingIn == isLoggingIn)&&(identical(other.loginEffect, loginEffect) || other.loginEffect == loginEffect));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isLoggingIn,loginEffect);

@override
String toString() {
  return 'AuthSessionState(apiState: $apiState, isLoggingIn: $isLoggingIn, loginEffect: $loginEffect)';
}


}

/// @nodoc
abstract mixin class $AuthSessionStateCopyWith<$Res>  {
  factory $AuthSessionStateCopyWith(AuthSessionState value, $Res Function(AuthSessionState) _then) = _$AuthSessionStateCopyWithImpl;
@useResult
$Res call({
 ApiState<AuthSessionEntity> apiState, bool isLoggingIn, AuthSessionEffect? loginEffect
});


$ApiStateCopyWith<AuthSessionEntity, $Res> get apiState;

}
/// @nodoc
class _$AuthSessionStateCopyWithImpl<$Res>
    implements $AuthSessionStateCopyWith<$Res> {
  _$AuthSessionStateCopyWithImpl(this._self, this._then);

  final AuthSessionState _self;
  final $Res Function(AuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = null,Object? isLoggingIn = null,Object? loginEffect = freezed,}) {
  return _then(_self.copyWith(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<AuthSessionEntity>,isLoggingIn: null == isLoggingIn ? _self.isLoggingIn : isLoggingIn // ignore: cast_nullable_to_non_nullable
as bool,loginEffect: freezed == loginEffect ? _self.loginEffect : loginEffect // ignore: cast_nullable_to_non_nullable
as AuthSessionEffect?,
  ));
}
/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<AuthSessionEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<AuthSessionEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthSessionState].
extension AuthSessionStatePatterns on AuthSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSessionState value)  $default,){
final _that = this;
switch (_that) {
case _AuthSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<AuthSessionEntity> apiState,  bool isLoggingIn,  AuthSessionEffect? loginEffect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSessionState() when $default != null:
return $default(_that.apiState,_that.isLoggingIn,_that.loginEffect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<AuthSessionEntity> apiState,  bool isLoggingIn,  AuthSessionEffect? loginEffect)  $default,) {final _that = this;
switch (_that) {
case _AuthSessionState():
return $default(_that.apiState,_that.isLoggingIn,_that.loginEffect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<AuthSessionEntity> apiState,  bool isLoggingIn,  AuthSessionEffect? loginEffect)?  $default,) {final _that = this;
switch (_that) {
case _AuthSessionState() when $default != null:
return $default(_that.apiState,_that.isLoggingIn,_that.loginEffect);case _:
  return null;

}
}

}

/// @nodoc


class _AuthSessionState implements AuthSessionState {
  const _AuthSessionState({this.apiState = const ApiState<AuthSessionEntity>.initial(), this.isLoggingIn = false, this.loginEffect});
  

@override@JsonKey() final  ApiState<AuthSessionEntity> apiState;
@override@JsonKey() final  bool isLoggingIn;
@override final  AuthSessionEffect? loginEffect;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionStateCopyWith<_AuthSessionState> get copyWith => __$AuthSessionStateCopyWithImpl<_AuthSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSessionState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isLoggingIn, isLoggingIn) || other.isLoggingIn == isLoggingIn)&&(identical(other.loginEffect, loginEffect) || other.loginEffect == loginEffect));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isLoggingIn,loginEffect);

@override
String toString() {
  return 'AuthSessionState(apiState: $apiState, isLoggingIn: $isLoggingIn, loginEffect: $loginEffect)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionStateCopyWith<$Res> implements $AuthSessionStateCopyWith<$Res> {
  factory _$AuthSessionStateCopyWith(_AuthSessionState value, $Res Function(_AuthSessionState) _then) = __$AuthSessionStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<AuthSessionEntity> apiState, bool isLoggingIn, AuthSessionEffect? loginEffect
});


@override $ApiStateCopyWith<AuthSessionEntity, $Res> get apiState;

}
/// @nodoc
class __$AuthSessionStateCopyWithImpl<$Res>
    implements _$AuthSessionStateCopyWith<$Res> {
  __$AuthSessionStateCopyWithImpl(this._self, this._then);

  final _AuthSessionState _self;
  final $Res Function(_AuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = null,Object? isLoggingIn = null,Object? loginEffect = freezed,}) {
  return _then(_AuthSessionState(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<AuthSessionEntity>,isLoggingIn: null == isLoggingIn ? _self.isLoggingIn : isLoggingIn // ignore: cast_nullable_to_non_nullable
as bool,loginEffect: freezed == loginEffect ? _self.loginEffect : loginEffect // ignore: cast_nullable_to_non_nullable
as AuthSessionEffect?,
  ));
}

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<AuthSessionEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<AuthSessionEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
