// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_booking_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentBookingDetailState {

 int? get bookingId; ApiState<StudentBookingDetailEntity> get apiState; bool get isCancelling; StudentBookingDetailEffect? get effect;
/// Create a copy of StudentBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentBookingDetailStateCopyWith<StudentBookingDetailState> get copyWith => _$StudentBookingDetailStateCopyWithImpl<StudentBookingDetailState>(this as StudentBookingDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentBookingDetailState&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,apiState,isCancelling,effect);

@override
String toString() {
  return 'StudentBookingDetailState(bookingId: $bookingId, apiState: $apiState, isCancelling: $isCancelling, effect: $effect)';
}


}

/// @nodoc
abstract mixin class $StudentBookingDetailStateCopyWith<$Res>  {
  factory $StudentBookingDetailStateCopyWith(StudentBookingDetailState value, $Res Function(StudentBookingDetailState) _then) = _$StudentBookingDetailStateCopyWithImpl;
@useResult
$Res call({
 int? bookingId, ApiState<StudentBookingDetailEntity> apiState, bool isCancelling, StudentBookingDetailEffect? effect
});


$ApiStateCopyWith<StudentBookingDetailEntity, $Res> get apiState;

}
/// @nodoc
class _$StudentBookingDetailStateCopyWithImpl<$Res>
    implements $StudentBookingDetailStateCopyWith<$Res> {
  _$StudentBookingDetailStateCopyWithImpl(this._self, this._then);

  final StudentBookingDetailState _self;
  final $Res Function(StudentBookingDetailState) _then;

/// Create a copy of StudentBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = freezed,Object? apiState = null,Object? isCancelling = null,Object? effect = freezed,}) {
  return _then(_self.copyWith(
bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int?,apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<StudentBookingDetailEntity>,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as StudentBookingDetailEffect?,
  ));
}
/// Create a copy of StudentBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<StudentBookingDetailEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<StudentBookingDetailEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudentBookingDetailState].
extension StudentBookingDetailStatePatterns on StudentBookingDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentBookingDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentBookingDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentBookingDetailState value)  $default,){
final _that = this;
switch (_that) {
case _StudentBookingDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentBookingDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentBookingDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? bookingId,  ApiState<StudentBookingDetailEntity> apiState,  bool isCancelling,  StudentBookingDetailEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentBookingDetailState() when $default != null:
return $default(_that.bookingId,_that.apiState,_that.isCancelling,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? bookingId,  ApiState<StudentBookingDetailEntity> apiState,  bool isCancelling,  StudentBookingDetailEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _StudentBookingDetailState():
return $default(_that.bookingId,_that.apiState,_that.isCancelling,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? bookingId,  ApiState<StudentBookingDetailEntity> apiState,  bool isCancelling,  StudentBookingDetailEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _StudentBookingDetailState() when $default != null:
return $default(_that.bookingId,_that.apiState,_that.isCancelling,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _StudentBookingDetailState implements StudentBookingDetailState {
  const _StudentBookingDetailState({this.bookingId, this.apiState = const ApiState<StudentBookingDetailEntity>.initial(), this.isCancelling = false, this.effect});
  

@override final  int? bookingId;
@override@JsonKey() final  ApiState<StudentBookingDetailEntity> apiState;
@override@JsonKey() final  bool isCancelling;
@override final  StudentBookingDetailEffect? effect;

/// Create a copy of StudentBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentBookingDetailStateCopyWith<_StudentBookingDetailState> get copyWith => __$StudentBookingDetailStateCopyWithImpl<_StudentBookingDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentBookingDetailState&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,apiState,isCancelling,effect);

@override
String toString() {
  return 'StudentBookingDetailState(bookingId: $bookingId, apiState: $apiState, isCancelling: $isCancelling, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$StudentBookingDetailStateCopyWith<$Res> implements $StudentBookingDetailStateCopyWith<$Res> {
  factory _$StudentBookingDetailStateCopyWith(_StudentBookingDetailState value, $Res Function(_StudentBookingDetailState) _then) = __$StudentBookingDetailStateCopyWithImpl;
@override @useResult
$Res call({
 int? bookingId, ApiState<StudentBookingDetailEntity> apiState, bool isCancelling, StudentBookingDetailEffect? effect
});


@override $ApiStateCopyWith<StudentBookingDetailEntity, $Res> get apiState;

}
/// @nodoc
class __$StudentBookingDetailStateCopyWithImpl<$Res>
    implements _$StudentBookingDetailStateCopyWith<$Res> {
  __$StudentBookingDetailStateCopyWithImpl(this._self, this._then);

  final _StudentBookingDetailState _self;
  final $Res Function(_StudentBookingDetailState) _then;

/// Create a copy of StudentBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = freezed,Object? apiState = null,Object? isCancelling = null,Object? effect = freezed,}) {
  return _then(_StudentBookingDetailState(
bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int?,apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<StudentBookingDetailEntity>,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as StudentBookingDetailEffect?,
  ));
}

/// Create a copy of StudentBookingDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<StudentBookingDetailEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<StudentBookingDetailEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
