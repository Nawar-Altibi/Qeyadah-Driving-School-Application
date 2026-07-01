// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_items_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SampleItemsState {

 ApiState<List<SampleItemEntity>> get apiState; bool get isSilentRefresh; SampleItemsEffect? get effect;
/// Create a copy of SampleItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleItemsStateCopyWith<SampleItemsState> get copyWith => _$SampleItemsStateCopyWithImpl<SampleItemsState>(this as SampleItemsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleItemsState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh,effect);

@override
String toString() {
  return 'SampleItemsState(apiState: $apiState, isSilentRefresh: $isSilentRefresh, effect: $effect)';
}


}

/// @nodoc
abstract mixin class $SampleItemsStateCopyWith<$Res>  {
  factory $SampleItemsStateCopyWith(SampleItemsState value, $Res Function(SampleItemsState) _then) = _$SampleItemsStateCopyWithImpl;
@useResult
$Res call({
 ApiState<List<SampleItemEntity>> apiState, bool isSilentRefresh, SampleItemsEffect? effect
});


$ApiStateCopyWith<List<SampleItemEntity>, $Res> get apiState;

}
/// @nodoc
class _$SampleItemsStateCopyWithImpl<$Res>
    implements $SampleItemsStateCopyWith<$Res> {
  _$SampleItemsStateCopyWithImpl(this._self, this._then);

  final SampleItemsState _self;
  final $Res Function(SampleItemsState) _then;

/// Create a copy of SampleItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = null,Object? isSilentRefresh = null,Object? effect = freezed,}) {
  return _then(_self.copyWith(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<List<SampleItemEntity>>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as SampleItemsEffect?,
  ));
}
/// Create a copy of SampleItemsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<List<SampleItemEntity>, $Res> get apiState {
  
  return $ApiStateCopyWith<List<SampleItemEntity>, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [SampleItemsState].
extension SampleItemsStatePatterns on SampleItemsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleItemsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleItemsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleItemsState value)  $default,){
final _that = this;
switch (_that) {
case _SampleItemsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleItemsState value)?  $default,){
final _that = this;
switch (_that) {
case _SampleItemsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<List<SampleItemEntity>> apiState,  bool isSilentRefresh,  SampleItemsEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SampleItemsState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<List<SampleItemEntity>> apiState,  bool isSilentRefresh,  SampleItemsEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _SampleItemsState():
return $default(_that.apiState,_that.isSilentRefresh,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<List<SampleItemEntity>> apiState,  bool isSilentRefresh,  SampleItemsEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _SampleItemsState() when $default != null:
return $default(_that.apiState,_that.isSilentRefresh,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _SampleItemsState implements SampleItemsState {
  const _SampleItemsState({this.apiState = const ApiState<List<SampleItemEntity>>.initial(), this.isSilentRefresh = false, this.effect});
  

@override@JsonKey() final  ApiState<List<SampleItemEntity>> apiState;
@override@JsonKey() final  bool isSilentRefresh;
@override final  SampleItemsEffect? effect;

/// Create a copy of SampleItemsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleItemsStateCopyWith<_SampleItemsState> get copyWith => __$SampleItemsStateCopyWithImpl<_SampleItemsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleItemsState&&(identical(other.apiState, apiState) || other.apiState == apiState)&&(identical(other.isSilentRefresh, isSilentRefresh) || other.isSilentRefresh == isSilentRefresh)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode => Object.hash(runtimeType,apiState,isSilentRefresh,effect);

@override
String toString() {
  return 'SampleItemsState(apiState: $apiState, isSilentRefresh: $isSilentRefresh, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$SampleItemsStateCopyWith<$Res> implements $SampleItemsStateCopyWith<$Res> {
  factory _$SampleItemsStateCopyWith(_SampleItemsState value, $Res Function(_SampleItemsState) _then) = __$SampleItemsStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<List<SampleItemEntity>> apiState, bool isSilentRefresh, SampleItemsEffect? effect
});


@override $ApiStateCopyWith<List<SampleItemEntity>, $Res> get apiState;

}
/// @nodoc
class __$SampleItemsStateCopyWithImpl<$Res>
    implements _$SampleItemsStateCopyWith<$Res> {
  __$SampleItemsStateCopyWithImpl(this._self, this._then);

  final _SampleItemsState _self;
  final $Res Function(_SampleItemsState) _then;

/// Create a copy of SampleItemsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = null,Object? isSilentRefresh = null,Object? effect = freezed,}) {
  return _then(_SampleItemsState(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<List<SampleItemEntity>>,isSilentRefresh: null == isSilentRefresh ? _self.isSilentRefresh : isSilentRefresh // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as SampleItemsEffect?,
  ));
}

/// Create a copy of SampleItemsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<List<SampleItemEntity>, $Res> get apiState {
  
  return $ApiStateCopyWith<List<SampleItemEntity>, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

/// @nodoc
mixin _$SampleItemDetailsState {

 ApiState<SampleItemEntity> get apiState;
/// Create a copy of SampleItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleItemDetailsStateCopyWith<SampleItemDetailsState> get copyWith => _$SampleItemDetailsStateCopyWithImpl<SampleItemDetailsState>(this as SampleItemDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleItemDetailsState&&(identical(other.apiState, apiState) || other.apiState == apiState));
}


@override
int get hashCode => Object.hash(runtimeType,apiState);

@override
String toString() {
  return 'SampleItemDetailsState(apiState: $apiState)';
}


}

/// @nodoc
abstract mixin class $SampleItemDetailsStateCopyWith<$Res>  {
  factory $SampleItemDetailsStateCopyWith(SampleItemDetailsState value, $Res Function(SampleItemDetailsState) _then) = _$SampleItemDetailsStateCopyWithImpl;
@useResult
$Res call({
 ApiState<SampleItemEntity> apiState
});


$ApiStateCopyWith<SampleItemEntity, $Res> get apiState;

}
/// @nodoc
class _$SampleItemDetailsStateCopyWithImpl<$Res>
    implements $SampleItemDetailsStateCopyWith<$Res> {
  _$SampleItemDetailsStateCopyWithImpl(this._self, this._then);

  final SampleItemDetailsState _self;
  final $Res Function(SampleItemDetailsState) _then;

/// Create a copy of SampleItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiState = null,}) {
  return _then(_self.copyWith(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<SampleItemEntity>,
  ));
}
/// Create a copy of SampleItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<SampleItemEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<SampleItemEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}


/// Adds pattern-matching-related methods to [SampleItemDetailsState].
extension SampleItemDetailsStatePatterns on SampleItemDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleItemDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleItemDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleItemDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _SampleItemDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleItemDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _SampleItemDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiState<SampleItemEntity> apiState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SampleItemDetailsState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiState<SampleItemEntity> apiState)  $default,) {final _that = this;
switch (_that) {
case _SampleItemDetailsState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiState<SampleItemEntity> apiState)?  $default,) {final _that = this;
switch (_that) {
case _SampleItemDetailsState() when $default != null:
return $default(_that.apiState);case _:
  return null;

}
}

}

/// @nodoc


class _SampleItemDetailsState implements SampleItemDetailsState {
  const _SampleItemDetailsState({this.apiState = const ApiState<SampleItemEntity>.initial()});
  

@override@JsonKey() final  ApiState<SampleItemEntity> apiState;

/// Create a copy of SampleItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleItemDetailsStateCopyWith<_SampleItemDetailsState> get copyWith => __$SampleItemDetailsStateCopyWithImpl<_SampleItemDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleItemDetailsState&&(identical(other.apiState, apiState) || other.apiState == apiState));
}


@override
int get hashCode => Object.hash(runtimeType,apiState);

@override
String toString() {
  return 'SampleItemDetailsState(apiState: $apiState)';
}


}

/// @nodoc
abstract mixin class _$SampleItemDetailsStateCopyWith<$Res> implements $SampleItemDetailsStateCopyWith<$Res> {
  factory _$SampleItemDetailsStateCopyWith(_SampleItemDetailsState value, $Res Function(_SampleItemDetailsState) _then) = __$SampleItemDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 ApiState<SampleItemEntity> apiState
});


@override $ApiStateCopyWith<SampleItemEntity, $Res> get apiState;

}
/// @nodoc
class __$SampleItemDetailsStateCopyWithImpl<$Res>
    implements _$SampleItemDetailsStateCopyWith<$Res> {
  __$SampleItemDetailsStateCopyWithImpl(this._self, this._then);

  final _SampleItemDetailsState _self;
  final $Res Function(_SampleItemDetailsState) _then;

/// Create a copy of SampleItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiState = null,}) {
  return _then(_SampleItemDetailsState(
apiState: null == apiState ? _self.apiState : apiState // ignore: cast_nullable_to_non_nullable
as ApiState<SampleItemEntity>,
  ));
}

/// Create a copy of SampleItemDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiStateCopyWith<SampleItemEntity, $Res> get apiState {
  
  return $ApiStateCopyWith<SampleItemEntity, $Res>(_self.apiState, (value) {
    return _then(_self.copyWith(apiState: value));
  });
}
}

// dart format on
