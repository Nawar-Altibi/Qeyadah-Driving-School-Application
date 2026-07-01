part of 'auth_session_cubit.dart';

@freezed
abstract class AuthSessionState with _$AuthSessionState {
  const factory AuthSessionState({
    @Default(ApiState<AuthSessionEntity>.initial())
    ApiState<AuthSessionEntity> apiState,
    @Default(false) bool isLoggingIn,
    AuthSessionEffect? loginEffect,
  }) = _AuthSessionState;
}

sealed class AuthSessionEffect {
  const AuthSessionEffect();
}

final class AuthSessionEffectLoginSucceeded extends AuthSessionEffect {
  const AuthSessionEffectLoginSucceeded();
}

final class AuthSessionEffectLoginFailed extends AuthSessionEffect {
  const AuthSessionEffectLoginFailed(this.failure);

  final Failure failure;
}
