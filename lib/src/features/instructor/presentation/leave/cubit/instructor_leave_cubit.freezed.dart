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

 ApiState<List<InstructorLeaveEntity>> get apiState;
/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstructorLeaveStateCopyWith<InstructorLeaveState> get copyWith => _$InstructorLeaveStateCopyWithImpl<InstructorLeaveState>(this as InstructorLeaveState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstructorLeaveState&&const DeepCollectionEquality().equals(other.apiState, apiState));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(apiState));

@override
String toString() {
  return 'InstructorLeaveState(apiState: $apiState)';
}


}

/// @nodoc
abstract mixin class $InstructorLeaveStateCopyWith<$Res>  {
  factory $InstructorLeaveStateCopyWith(InstructorLeaveState value, $Res Function(InstructorLeaveState) _then) = _$InstructorLeaveStateCopyWithImpl;
@useResult
$Res call({
 ApiState<List<InstructorLeaveEntity>> apiState
});




}
/// @nodoc
class _$InstructorLeaveStateCopyWithImpl<$Res>
    implements $InstructorLeaveStateCopyWith<$Res> {
  _$InstructorLeaveStateCopyWithImpl(this._self, this._then);

  final InstructorLeaveState _self;
  final $Res Function(InstructorLeaveState) _then;

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = freezed,}) {
  return _then(_self.copyWith(
apiState: freezed == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<List<InstructorLeaveEntity>>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<List<InstructorLeaveEntity>> apiState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstructorLeaveState() when $default != null:
return $default(_that.apiState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<List<InstructorLeaveEntity>> apiState)  $default,) {final _that = this;
switch (_that) {
case _InstructorLeaveState():
return $default(_that.apiState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<List<InstructorLeaveEntity>> apiState)?  $default,) {final _that = this;
switch (_that) {
case _InstructorLeaveState() when $default != null:
return $default(_that.apiState);case _:
  return null;

}
}

}

/// @nodoc


class _InstructorLeaveState implements InstructorLeaveState {
  const _InstructorLeaveState({required this.apiState});
  

@override final  ApiState<List<InstructorLeaveEntity>> apiState;

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstructorLeaveStateCopyWith<_InstructorLeaveState> get copyWith => __$InstructorLeaveStateCopyWithImpl<_InstructorLeaveState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstructorLeaveState&&const DeepCollectionEquality().equals(other.apiState, apiState));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(apiState));

@override
String toString() {
  return 'InstructorLeaveState(apiState: $apiState)';
}


}

/// @nodoc
abstract mixin class _$InstructorLeaveStateCopyWith<$Res> implements $InstructorLeaveStateCopyWith<$Res> {
  factory _$InstructorLeaveStateCopyWith(_InstructorLeaveState value, $Res Function(_InstructorLeaveState) _then) = __$InstructorLeaveStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<List<InstructorLeaveEntity>> apiState
});




}
/// @nodoc
class __$InstructorLeaveStateCopyWithImpl<$Res>
    implements _$InstructorLeaveStateCopyWith<$Res> {
  __$InstructorLeaveStateCopyWithImpl(this._self, this._then);

  final _InstructorLeaveState _self;
  final $Res Function(_InstructorLeaveState) _then;

/// Create a copy of InstructorLeaveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = freezed,}) {
  return _then(_InstructorLeaveState(
apiState: freezed == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<List<InstructorLeaveEntity>>,
  ));
}


}

// dart format on
