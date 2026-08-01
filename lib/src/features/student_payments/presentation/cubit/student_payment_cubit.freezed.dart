// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_payment_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentPaymentState {

 StudentPaymentHoldArgs? get args; Duration get remaining; bool get isExpired; bool get isSubmitting; StudentPaymentEffect? get effect;
/// Create a copy of StudentPaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentPaymentStateCopyWith<StudentPaymentState> get copyWith => _$StudentPaymentStateCopyWithImpl<StudentPaymentState>(this as StudentPaymentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentPaymentState&&(identical(other.args, args) || other.args == args)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,args,remaining,isExpired,isSubmitting,effect);

@override
String toString() {
  return 'StudentPaymentState(args: $args, remaining: $remaining, isExpired: $isExpired, isSubmitting: $isSubmitting, effect: $effect)';
}


}

/// @nodoc
abstract mixin class $StudentPaymentStateCopyWith<$Res>  {
  factory $StudentPaymentStateCopyWith(StudentPaymentState value, $Res Function(StudentPaymentState) _then) = _$StudentPaymentStateCopyWithImpl;
@useResult
$Res call({
 StudentPaymentHoldArgs? args, Duration remaining, bool isExpired, bool isSubmitting, StudentPaymentEffect? effect
});




}
/// @nodoc
class _$StudentPaymentStateCopyWithImpl<$Res>
    implements $StudentPaymentStateCopyWith<$Res> {
  _$StudentPaymentStateCopyWithImpl(this._self, this._then);

  final StudentPaymentState _self;
  final $Res Function(StudentPaymentState) _then;

/// Create a copy of StudentPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? args = freezed,Object? remaining = null,Object? isExpired = null,Object? isSubmitting = null,Object? effect = freezed,}) {
  return _then(_self.copyWith(
args: freezed == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as StudentPaymentHoldArgs?,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Duration,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as StudentPaymentEffect?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentPaymentState].
extension StudentPaymentStatePatterns on StudentPaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentPaymentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentPaymentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentPaymentState value)  $default,){
final _that = this;
switch (_that) {
case _StudentPaymentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentPaymentState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentPaymentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StudentPaymentHoldArgs? args,  Duration remaining,  bool isExpired,  bool isSubmitting,  StudentPaymentEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentPaymentState() when $default != null:
return $default(_that.args,_that.remaining,_that.isExpired,_that.isSubmitting,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StudentPaymentHoldArgs? args,  Duration remaining,  bool isExpired,  bool isSubmitting,  StudentPaymentEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _StudentPaymentState():
return $default(_that.args,_that.remaining,_that.isExpired,_that.isSubmitting,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StudentPaymentHoldArgs? args,  Duration remaining,  bool isExpired,  bool isSubmitting,  StudentPaymentEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _StudentPaymentState() when $default != null:
return $default(_that.args,_that.remaining,_that.isExpired,_that.isSubmitting,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _StudentPaymentState implements StudentPaymentState {
  const _StudentPaymentState({this.args, this.remaining = Duration.zero, this.isExpired = false, this.isSubmitting = false, this.effect});
  

@override final  StudentPaymentHoldArgs? args;
@override@JsonKey() final  Duration remaining;
@override@JsonKey() final  bool isExpired;
@override@JsonKey() final  bool isSubmitting;
@override final  StudentPaymentEffect? effect;

/// Create a copy of StudentPaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentPaymentStateCopyWith<_StudentPaymentState> get copyWith => __$StudentPaymentStateCopyWithImpl<_StudentPaymentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentPaymentState&&(identical(other.args, args) || other.args == args)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,args,remaining,isExpired,isSubmitting,effect);

@override
String toString() {
  return 'StudentPaymentState(args: $args, remaining: $remaining, isExpired: $isExpired, isSubmitting: $isSubmitting, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$StudentPaymentStateCopyWith<$Res> implements $StudentPaymentStateCopyWith<$Res> {
  factory _$StudentPaymentStateCopyWith(_StudentPaymentState value, $Res Function(_StudentPaymentState) _then) = __$StudentPaymentStateCopyWithImpl;
@override @useResult
$Res call({
 StudentPaymentHoldArgs? args, Duration remaining, bool isExpired, bool isSubmitting, StudentPaymentEffect? effect
});




}
/// @nodoc
class __$StudentPaymentStateCopyWithImpl<$Res>
    implements _$StudentPaymentStateCopyWith<$Res> {
  __$StudentPaymentStateCopyWithImpl(this._self, this._then);

  final _StudentPaymentState _self;
  final $Res Function(_StudentPaymentState) _then;

/// Create a copy of StudentPaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? args = freezed,Object? remaining = null,Object? isExpired = null,Object? isSubmitting = null,Object? effect = freezed,}) {
  return _then(_StudentPaymentState(
args: freezed == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as StudentPaymentHoldArgs?,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Duration,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as StudentPaymentEffect?,
  ));
}


}

// dart format on
