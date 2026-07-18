// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'instructor_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstructorProfileState {

 ApiState<InstructorProfileDashboardEntity> get apiState; bool get isSilentRefresh;
/// Create a copy of InstructorProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstructorProfileStateCopyWith<InstructorProfileState> get copyWith => _$InstructorProfileStateCopyWithImpl<InstructorProfileState>(this as InstructorProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstructorProfileState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh);

@override
String toString() {
  return 'InstructorProfileState(apiState: $apiState, isSilentRefresh: $isSilentRefresh)';
}


}

/// @nodoc
abstract mixin class $InstructorProfileStateCopyWith<$Res>  {
  factory $InstructorProfileStateCopyWith(InstructorProfileState value, $Res Function(InstructorProfileState) _then) = _$InstructorProfileStateCopyWithImpl;
@useResult
$Res call({
 ApiState<InstructorProfileDashboardEntity> apiState, bool isSilentRefresh
});


$ApiStateCopyWith<InstructorProfileDashboardEntity, $Res> get apiState;

}
/// @nodoc
class _$InstructorProfileStateCopyWithImpl<$Res>
    implements $InstructorProfileStateCopyWith<$Res> {
  _$InstructorProfileStateCopyWithImpl(this._self, this._then);

  final InstructorProfileState _self;
  final $Res Function(InstructorProfileState) _then;

/// Create a copy of InstructorProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = null,Object? isSilentRefresh = null,}) {
  return _then(_self.copyWith(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<InstructorProfileDashboardEntity>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of InstructorProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<InstructorProfileDashboardEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<InstructorProfileDashboardEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [InstructorProfileState].
extension InstructorProfileStatePatterns on InstructorProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstructorProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstructorProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstructorProfileState value)  $default,){
final _that = this;
switch (_that) {
case _InstructorProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstructorProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _InstructorProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<InstructorProfileDashboardEntity> apiState,  bool isSilentRefresh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstructorProfileState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<InstructorProfileDashboardEntity> apiState,  bool isSilentRefresh)  $default,) {final _that = this;
switch (_that) {
case _InstructorProfileState():
return $default(_that.apiState,_that.isSilentRefresh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<InstructorProfileDashboardEntity> apiState,  bool isSilentRefresh)?  $default,) {final _that = this;
switch (_that) {
case _InstructorProfileState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh);case _:
  return null;

}
}

}

/// @nodoc


class _InstructorProfileState implements InstructorProfileState {
  const _InstructorProfileState({this.apiState = const ApiState<InstructorProfileDashboardEntity>.initial(), this.isSilentRefresh = false});
  

@override@JsonKey() final  ApiState<InstructorProfileDashboardEntity> apiState;
@override@JsonKey() final  bool isSilentRefresh;

/// Create a copy of InstructorProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstructorProfileStateCopyWith<_InstructorProfileState> get copyWith => __$InstructorProfileStateCopyWithImpl<_InstructorProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstructorProfileState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh);

@override
String toString() {
  return 'InstructorProfileState(apiState: $apiState, isSilentRefresh: $isSilentRefresh)';
}


}

/// @nodoc
abstract mixin class _$InstructorProfileStateCopyWith<$Res> implements $InstructorProfileStateCopyWith<$Res> {
  factory _$InstructorProfileStateCopyWith(_InstructorProfileState value, $Res Function(_InstructorProfileState) _then) = __$InstructorProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<InstructorProfileDashboardEntity> apiState, bool isSilentRefresh
});


@override $ApiStateCopyWith<InstructorProfileDashboardEntity, $Res> get apiState;

}
/// @nodoc
class __$InstructorProfileStateCopyWithImpl<$Res>
    implements _$InstructorProfileStateCopyWith<$Res> {
  __$InstructorProfileStateCopyWithImpl(this._self, this._then);

  final _InstructorProfileState _self;
  final $Res Function(_InstructorProfileState) _then;

/// Create a copy of InstructorProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = null,Object? isSilentRefresh = null,}) {
  return _then(_InstructorProfileState(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<InstructorProfileDashboardEntity>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of InstructorProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<InstructorProfileDashboardEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<InstructorProfileDashboardEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
