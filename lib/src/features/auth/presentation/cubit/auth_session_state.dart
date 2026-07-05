part of 'auth_session_cubit.dart';

@freezed
abstract class AuthSessionState with _$AuthSessionState {
  const factory AuthSessionState({
    @Default(ApiState<AuthSessionEntity>.initial())
    ApiState<AuthSessionEntity> apiState,
    @Default(false) bool isLoggingIn,
    @Default(false) bool isRefreshingProfile,
    AuthSessionEffect? loginEffect,
    AuthSessionEffect? profileEffect,
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

final class AuthSessionEffectProfileRefreshed extends AuthSessionEffect {
  const AuthSessionEffectProfileRefreshed();
}

final class AuthSessionEffectProfileFailed extends AuthSessionEffect {
  const AuthSessionEffectProfileFailed(this.failure);

  final Failure failure;
}
