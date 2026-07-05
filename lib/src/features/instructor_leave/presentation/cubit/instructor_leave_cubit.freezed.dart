// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'instructor_leave_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstructorLeaveState {

 ApiState<List<InstructorLeaveEntity>> get apiState; bool get isSilentRefresh; bool get showFullDayOnly;
/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstructorLeaveStateCopyWith<InstructorLeaveState> get copyWith => _$InstructorLeaveStateCopyWithImpl<InstructorLeaveState>(this as InstructorLeaveState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstructorLeaveState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh)&&(identical(other.showFullDayOnly, showFullDayOnly) || other.showFullDayOnly == showFullDayOnly));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh,showFullDayOnly);

@override
String toString() {
  return 'InstructorLeaveState(apiState: $apiState, isSilentRefresh: $isSilentRefresh, showFullDayOnly: $showFullDayOnly)';
}


}

/// @nodoc
abstract mixin class $InstructorLeaveStateCopyWith<$Res>  {
  factory $InstructorLeaveStateCopyWith(InstructorLeaveState value, $Res Function(InstructorLeaveState) _then) = _$InstructorLeaveStateCopyWithImpl;
@useResult
$Res call({
 ApiState<List<InstructorLeaveEntity>> apiState, bool isSilentRefresh, bool showFullDayOnly
});


$ApiStateCopyWith<List<InstructorLeaveEntity>, $Res> get apiState;

}
/// @nodoc
class _$InstructorLeaveStateCopyWithImpl<$Res>
    implements $InstructorLeaveStateCopyWith<$Res> {
  _$InstructorLeaveStateCopyWithImpl(this._self, this._then);

  final InstructorLeaveState _self;
  final $Res Function(InstructorLeaveState) _then;

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = null,Object? isSilentRefresh = null,Object? showFullDayOnly = null,}) {
  return _then(_self.copyWith(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<List<InstructorLeaveEntity>>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,showFullDayOnly: null == showFullDayOnly ? _self.showFullDayOnly : showFullDayOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<List<InstructorLeaveEntity>, $Res> get apiState {
  
  return $ApiStateCopyWith<List<InstructorLeaveEntity>, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [InstructorLeaveState].
extension InstructorLeaveStatePatterns on InstructorLeaveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstructorLeaveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstructorLeaveState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstructorLeaveState value)  $default,){
final _that = this;
switch (_that) {
case _InstructorLeaveState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstructorLeaveState value)?  $default,){
final _that = this;
switch (_that) {
case _InstructorLeaveState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<List<InstructorLeaveEntity>> apiState,  bool isSilentRefresh,  bool showFullDayOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstructorLeaveState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh,_that.showFullDayOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<List<InstructorLeaveEntity>> apiState,  bool isSilentRefresh,  bool showFullDayOnly)  $default,) {final _that = this;
switch (_that) {
case _InstructorLeaveState():
return $default(_that.apiState,_that.isSilentRefresh,_that.showFullDayOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<List<InstructorLeaveEntity>> apiState,  bool isSilentRefresh,  bool showFullDayOnly)?  $default,) {final _that = this;
switch (_that) {
case _InstructorLeaveState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh,_that.showFullDayOnly);case _:
  return null;

}
}

}

/// @nodoc


class _InstructorLeaveState implements InstructorLeaveState {
  const _InstructorLeaveState({this.apiState = const ApiState<List<InstructorLeaveEntity>>.initial(), this.isSilentRefresh = false, this.showFullDayOnly = true});
  

@override@JsonKey() final  ApiState<List<InstructorLeaveEntity>> apiState;
@override@JsonKey() final  bool isSilentRefresh;
@override@JsonKey() final  bool showFullDayOnly;

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstructorLeaveStateCopyWith<_InstructorLeaveState> get copyWith => __$InstructorLeaveStateCopyWithImpl<_InstructorLeaveState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstructorLeaveState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh)&&(identical(other.showFullDayOnly, showFullDayOnly) || other.showFullDayOnly == showFullDayOnly));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh,showFullDayOnly);

@override
String toString() {
  return 'InstructorLeaveState(apiState: $apiState, isSilentRefresh: $isSilentRefresh, showFullDayOnly: $showFullDayOnly)';
}


}

/// @nodoc
abstract mixin class _$InstructorLeaveStateCopyWith<$Res> implements $InstructorLeaveStateCopyWith<$Res> {
  factory _$InstructorLeaveStateCopyWith(_InstructorLeaveState value, $Res Function(_InstructorLeaveState) _then) = __$InstructorLeaveStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<List<InstructorLeaveEntity>> apiState, bool isSilentRefresh, bool showFullDayOnly
});


@override $ApiStateCopyWith<List<InstructorLeaveEntity>, $Res> get apiState;

}
/// @nodoc
class __$InstructorLeaveStateCopyWithImpl<$Res>
    implements _$InstructorLeaveStateCopyWith<$Res> {
  __$InstructorLeaveStateCopyWithImpl(this._self, this._then);

  final _InstructorLeaveState _self;
  final $Res Function(_InstructorLeaveState) _then;

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = null,Object? isSilentRefresh = null,Object? showFullDayOnly = null,}) {
  return _then(_InstructorLeaveState(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<List<InstructorLeaveEntity>>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,showFullDayOnly: null == showFullDayOnly ? _self.showFullDayOnly : showFullDayOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<List<InstructorLeaveEntity>, $Res> get apiState {
  
  return $ApiStateCopyWith<List<InstructorLeaveEntity>, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
