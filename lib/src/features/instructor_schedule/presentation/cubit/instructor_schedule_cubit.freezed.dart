// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'instructor_schedule_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstructorScheduleState {

 ApiState<InstructorScheduleDashboardEntity> get apiState; bool get isSilentRefresh;
/// Create a copy of InstructorScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstructorScheduleStateCopyWith<InstructorScheduleState> get copyWith => _$InstructorScheduleStateCopyWithImpl<InstructorScheduleState>(this as InstructorScheduleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstructorScheduleState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh);

@override
String toString() {
  return 'InstructorScheduleState(apiState: $apiState, isSilentRefresh: $isSilentRefresh)';
}


}

/// @nodoc
abstract mixin class $InstructorScheduleStateCopyWith<$Res>  {
  factory $InstructorScheduleStateCopyWith(InstructorScheduleState value, $Res Function(InstructorScheduleState) _then) = _$InstructorScheduleStateCopyWithImpl;
@useResult
$Res call({
 ApiState<InstructorScheduleDashboardEntity> apiState, bool isSilentRefresh
});


$ApiStateCopyWith<InstructorScheduleDashboardEntity, $Res> get apiState;

}
/// @nodoc
class _$InstructorScheduleStateCopyWithImpl<$Res>
    implements $InstructorScheduleStateCopyWith<$Res> {
  _$InstructorScheduleStateCopyWithImpl(this._self, this._then);

  final InstructorScheduleState _self;
  final $Res Function(InstructorScheduleState) _then;

/// Create a copy of InstructorScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = null,Object? isSilentRefresh = null,}) {
  return _then(_self.copyWith(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<InstructorScheduleDashboardEntity>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of InstructorScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<InstructorScheduleDashboardEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<InstructorScheduleDashboardEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [InstructorScheduleState].
extension InstructorScheduleStatePatterns on InstructorScheduleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstructorScheduleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstructorScheduleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstructorScheduleState value)  $default,){
final _that = this;
switch (_that) {
case _InstructorScheduleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstructorScheduleState value)?  $default,){
final _that = this;
switch (_that) {
case _InstructorScheduleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<InstructorScheduleDashboardEntity> apiState,  bool isSilentRefresh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstructorScheduleState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<InstructorScheduleDashboardEntity> apiState,  bool isSilentRefresh)  $default,) {final _that = this;
switch (_that) {
case _InstructorScheduleState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<InstructorScheduleDashboardEntity> apiState,  bool isSilentRefresh)?  $default,) {final _that = this;
switch (_that) {
case _InstructorScheduleState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh);case _:
  return null;

}
}

}

/// @nodoc


class _InstructorScheduleState implements InstructorScheduleState {
  const _InstructorScheduleState({this.apiState = const ApiState<InstructorScheduleDashboardEntity>.initial(), this.isSilentRefresh = false});
  

@override@JsonKey() final  ApiState<InstructorScheduleDashboardEntity> apiState;
@override@JsonKey() final  bool isSilentRefresh;

/// Create a copy of InstructorScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstructorScheduleStateCopyWith<_InstructorScheduleState> get copyWith => __$InstructorScheduleStateCopyWithImpl<_InstructorScheduleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstructorScheduleState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh);

@override
String toString() {
  return 'InstructorScheduleState(apiState: $apiState, isSilentRefresh: $isSilentRefresh)';
}


}

/// @nodoc
abstract mixin class _$InstructorScheduleStateCopyWith<$Res> implements $InstructorScheduleStateCopyWith<$Res> {
  factory _$InstructorScheduleStateCopyWith(_InstructorScheduleState value, $Res Function(_InstructorScheduleState) _then) = __$InstructorScheduleStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<InstructorScheduleDashboardEntity> apiState, bool isSilentRefresh
});


@override $ApiStateCopyWith<InstructorScheduleDashboardEntity, $Res> get apiState;

}
/// @nodoc
class __$InstructorScheduleStateCopyWithImpl<$Res>
    implements _$InstructorScheduleStateCopyWith<$Res> {
  __$InstructorScheduleStateCopyWithImpl(this._self, this._then);

  final _InstructorScheduleState _self;
  final $Res Function(_InstructorScheduleState) _then;

/// Create a copy of InstructorScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = null,Object? isSilentRefresh = null,}) {
  return _then(_InstructorScheduleState(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<InstructorScheduleDashboardEntity>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of InstructorScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<InstructorScheduleDashboardEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<InstructorScheduleDashboardEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
