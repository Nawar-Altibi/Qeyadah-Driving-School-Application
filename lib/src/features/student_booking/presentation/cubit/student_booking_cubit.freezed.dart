// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_booking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentBookingState {

 StudentBookingFiltersEntity get filters; ApiState<StudentAvailableSlotsPageEntity> get apiState; bool get isSilentRefresh; StudentBookingSelectionEntity? get selection; StudentBookingPricingEntity? get pricing; bool get isCreatingBooking; StudentBookingEffect? get effect;
/// Create a copy of StudentBookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentBookingStateCopyWith<StudentBookingState> get copyWith => _$StudentBookingStateCopyWithImpl<StudentBookingState>(this as StudentBookingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentBookingState&&(identical(other.filters, filters) || other.filters == filters)&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.isCreatingBooking, isCreatingBooking) || other.isCreatingBooking == isCreatingBooking)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,filters,apiState,isSilentRefresh,selection,pricing,isCreatingBooking,effect);

@override
String toString() {
  return 'StudentBookingState(filters: $filters, apiState: $apiState, isSilentRefresh: $isSilentRefresh, selection: $selection, pricing: $pricing, isCreatingBooking: $isCreatingBooking, effect: $effect)';
}


}

/// @nodoc
abstract mixin class $StudentBookingStateCopyWith<$Res>  {
  factory $StudentBookingStateCopyWith(StudentBookingState value, $Res Function(StudentBookingState) _then) = _$StudentBookingStateCopyWithImpl;
@useResult
$Res call({
 StudentBookingFiltersEntity filters, ApiState<StudentAvailableSlotsPageEntity> apiState, bool isSilentRefresh, StudentBookingSelectionEntity? selection, StudentBookingPricingEntity? pricing, bool isCreatingBooking, StudentBookingEffect? effect
});


$ApiStateCopyWith<StudentAvailableSlotsPageEntity, $Res> get apiState;

}
/// @nodoc
class _$StudentBookingStateCopyWithImpl<$Res>
    implements $StudentBookingStateCopyWith<$Res> {
  _$StudentBookingStateCopyWithImpl(this._self, this._then);

  final StudentBookingState _self;
  final $Res Function(StudentBookingState) _then;

/// Create a copy of StudentBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filters = null,Object? apiState = null,Object? isSilentRefresh = null,Object? selection = freezed,Object? pricing = freezed,Object? isCreatingBooking = null,Object? effect = freezed,}) {
  return _then(_self.copyWith(
filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as StudentBookingFiltersEntity,apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<StudentAvailableSlotsPageEntity>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as StudentBookingSelectionEntity?,pricing: freezed == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as StudentBookingPricingEntity?,isCreatingBooking: null == isCreatingBooking ? _self.isCreatingBooking : isCreatingBooking // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as StudentBookingEffect?,
  ));
}
/// Create a copy of StudentBookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<StudentAvailableSlotsPageEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<StudentAvailableSlotsPageEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudentBookingState].
extension StudentBookingStatePatterns on StudentBookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentBookingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentBookingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentBookingState value)  $default,){
final _that = this;
switch (_that) {
case _StudentBookingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentBookingState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentBookingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StudentBookingFiltersEntity filters,  ApiState<StudentAvailableSlotsPageEntity> apiState,  bool isSilentRefresh,  StudentBookingSelectionEntity? selection,  StudentBookingPricingEntity? pricing,  bool isCreatingBooking,  StudentBookingEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentBookingState() when $default != null:
return $default(_that.filters,_that.apiState,_that.isSilentRefresh,_that.selection,_that.pricing,_that.isCreatingBooking,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StudentBookingFiltersEntity filters,  ApiState<StudentAvailableSlotsPageEntity> apiState,  bool isSilentRefresh,  StudentBookingSelectionEntity? selection,  StudentBookingPricingEntity? pricing,  bool isCreatingBooking,  StudentBookingEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _StudentBookingState():
return $default(_that.filters,_that.apiState,_that.isSilentRefresh,_that.selection,_that.pricing,_that.isCreatingBooking,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StudentBookingFiltersEntity filters,  ApiState<StudentAvailableSlotsPageEntity> apiState,  bool isSilentRefresh,  StudentBookingSelectionEntity? selection,  StudentBookingPricingEntity? pricing,  bool isCreatingBooking,  StudentBookingEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _StudentBookingState() when $default != null:
return $default(_that.filters,_that.apiState,_that.isSilentRefresh,_that.selection,_that.pricing,_that.isCreatingBooking,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _StudentBookingState implements StudentBookingState {
  const _StudentBookingState({this.filters = const StudentBookingFiltersEntity(), this.apiState = const ApiState<StudentAvailableSlotsPageEntity>.initial(), this.isSilentRefresh = false, this.selection, this.pricing, this.isCreatingBooking = false, this.effect});
  

@override@JsonKey() final  StudentBookingFiltersEntity filters;
@override@JsonKey() final  ApiState<StudentAvailableSlotsPageEntity> apiState;
@override@JsonKey() final  bool isSilentRefresh;
@override final  StudentBookingSelectionEntity? selection;
@override final  StudentBookingPricingEntity? pricing;
@override@JsonKey() final  bool isCreatingBooking;
@override final  StudentBookingEffect? effect;

/// Create a copy of StudentBookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentBookingStateCopyWith<_StudentBookingState> get copyWith => __$StudentBookingStateCopyWithImpl<_StudentBookingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentBookingState&&(identical(other.filters, filters) || other.filters == filters)&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.isCreatingBooking, isCreatingBooking) || other.isCreatingBooking == isCreatingBooking)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,filters,apiState,isSilentRefresh,selection,pricing,isCreatingBooking,effect);

@override
String toString() {
  return 'StudentBookingState(filters: $filters, apiState: $apiState, isSilentRefresh: $isSilentRefresh, selection: $selection, pricing: $pricing, isCreatingBooking: $isCreatingBooking, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$StudentBookingStateCopyWith<$Res> implements $StudentBookingStateCopyWith<$Res> {
  factory _$StudentBookingStateCopyWith(_StudentBookingState value, $Res Function(_StudentBookingState) _then) = __$StudentBookingStateCopyWithImpl;
@override @useResult
$Res call({
 StudentBookingFiltersEntity filters, ApiState<StudentAvailableSlotsPageEntity> apiState, bool isSilentRefresh, StudentBookingSelectionEntity? selection, StudentBookingPricingEntity? pricing, bool isCreatingBooking, StudentBookingEffect? effect
});


@override $ApiStateCopyWith<StudentAvailableSlotsPageEntity, $Res> get apiState;

}
/// @nodoc
class __$StudentBookingStateCopyWithImpl<$Res>
    implements _$StudentBookingStateCopyWith<$Res> {
  __$StudentBookingStateCopyWithImpl(this._self, this._then);

  final _StudentBookingState _self;
  final $Res Function(_StudentBookingState) _then;

/// Create a copy of StudentBookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filters = null,Object? apiState = null,Object? isSilentRefresh = null,Object? selection = freezed,Object? pricing = freezed,Object? isCreatingBooking = null,Object? effect = freezed,}) {
  return _then(_StudentBookingState(
filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as StudentBookingFiltersEntity,apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<StudentAvailableSlotsPageEntity>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as StudentBookingSelectionEntity?,pricing: freezed == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as StudentBookingPricingEntity?,isCreatingBooking: null == isCreatingBooking ? _self.isCreatingBooking : isCreatingBooking // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as StudentBookingEffect?,
  ));
}

/// Create a copy of StudentBookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<StudentAvailableSlotsPageEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<StudentAvailableSlotsPageEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
