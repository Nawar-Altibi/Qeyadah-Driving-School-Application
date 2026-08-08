import 'dart:async';

import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/utils/future_either_timeout.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/get_persisted_session_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_all_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/refresh_profile_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/coordinators/push_notifications_coordinator.dart';

part 'auth_session_state.dart';
part 'auth_session_cubit.freezed.dart';

@lazySingleton
class AuthSessionCubit
    extends AppCoreCoreCubit<AuthSessionState, AuthSessionEntity> {
  AuthSessionCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._logoutAllUseCase,
    this._getPersistedSessionUseCase,
    this._refreshProfileUseCase,
    this._pushCoordinator,
  ) : super(const AuthSessionState());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final LogoutAllUseCase _logoutAllUseCase;
  final GetPersistedSessionUseCase _getPersistedSessionUseCase;
  final RefreshProfileUseCase _refreshProfileUseCase;
  final PushNotificationsCoordinator _pushCoordinator;

  bool _initialRestoreComplete = false;
  int _loginGeneration = 0;
  int _profileGeneration = 0;
  int _authEpoch = 0;

  bool get hasCompletedInitialRestore => _initialRestoreComplete;

  bool get isAuthenticated => state.apiState.maybeWhen(
    succeeded: (AuthSessionEntity data) => data.isAuthenticated,
    orElse: () => false,
  );

  AuthSessionEntity? get currentSession => state.apiState.maybeWhen(
    succeeded: (AuthSessionEntity data) => data,
    orElse: () => null,
  );

  @override
  ApiState<AuthSessionEntity> getApiState(AuthSessionState state) =>
      state.apiState;

  @override
  AuthSessionState setApiState(
    AuthSessionState state,
    ApiState<AuthSessionEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> restoreSession() async {
    if (_initialRestoreComplete) return;

    try {
      // Hive auth-box open can take up to ~10s; keep budget above that so a
      // cold start does not drop a valid persisted session as "logged out".
      final result = await _getPersistedSessionUseCase(
        const NoParams(),
      ).timeout(const Duration(seconds: 15));

      result.fold(
        (Failure failure) {
          _initialRestoreComplete = true;
          _finishInitialRestoreWithoutSession();
        },
        (AuthSessionEntity? session) {
          if (session == null) {
            _initialRestoreComplete = true;
            _finishInitialRestoreWithoutSession();
            return;
          }
          emit(
            state.copyWith(
              apiState: ApiState<AuthSessionEntity>.succeeded(session),
            ),
          );
          // Set after emit so the router never sees restoreCompleted=true
          // while apiState is still initial.
          _initialRestoreComplete = true;
          unawaited(_pushCoordinator.startForAuthenticatedSession());
        },
      );
    } on Object {
      _initialRestoreComplete = true;
      _finishInitialRestoreWithoutSession();
    }
  }

  void _finishInitialRestoreWithoutSession() {
    emit(state.copyWith(apiState: const ApiState<AuthSessionEntity>.initial()));
  }

  Future<void> login({
    required String phone,
    required String password,
    String? deviceName,
  }) async {
    final phoneResult = AuthCredentialsRules.validatePhone(phone);
    await phoneResult.fold(
      (failure) async {
        emit(
          state.copyWith(loginEffect: AuthSessionEffectLoginFailed(failure)),
        );
      },
      (validatedPhone) async {
        final generation = ++_loginGeneration;
        emit(state.copyWith(isLoggingIn: true, loginEffect: null));

        // Do NOT await FCM before login — Firebase getToken/requestPermission
        // can hang on some Android OEMs and trip the login timeout even after
        // HTTP 200. Device registration happens in
        // startForAuthenticatedSession() after a successful login.
        final result = await FutureEitherTimeout.guard(
          _loginUseCase(
            LoginParams(
              phone: validatedPhone,
              password: password,
              deviceName: deviceName ?? AuthConstants.deviceName,
            ),
          ),
          timeout: const Duration(seconds: 25),
        );

        if (!isActiveGeneration(
          capturedGeneration: generation,
          currentGeneration: _loginGeneration,
        )) {
          return;
        }

        result.fold(
          (failure) {
            emit(
              state.copyWith(
                isLoggingIn: false,
                loginEffect: AuthSessionEffectLoginFailed(failure),
              ),
            );
          },
          (session) {
            _authEpoch++;
            emit(
              state.copyWith(
                isLoggingIn: false,
                apiState: ApiState<AuthSessionEntity>.succeeded(session),
                loginEffect: const AuthSessionEffectLoginSucceeded(),
              ),
            );
            unawaited(_pushCoordinator.startForAuthenticatedSession());
          },
        );
      },
    );
  }

  void applySession(AuthSessionEntity session) {
    _authEpoch++;
    emit(
      state.copyWith(apiState: ApiState<AuthSessionEntity>.succeeded(session)),
    );
    unawaited(_pushCoordinator.startForAuthenticatedSession());
  }

  Future<void> refreshProfile() async {
    final generation = ++_profileGeneration;
    emit(state.copyWith(isRefreshingProfile: true));

    final result = await FutureEitherTimeout.guard(
      _refreshProfileUseCase(const NoParams()),
    );
    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _profileGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRefreshingProfile: false,
          profileEffect: AuthSessionEffectProfileFailed(failure),
        ),
      ),
      (session) => emit(
        state.copyWith(
          isRefreshingProfile: false,
          apiState: ApiState<AuthSessionEntity>.succeeded(session),
          profileEffect: const AuthSessionEffectProfileRefreshed(),
        ),
      ),
    );
  }

  Future<void> logout() async {
    // Leave the authenticated UI immediately; network cleanup must not block
    // redirect to login (seen hanging on DELETE /devices/token + logout HTTP).
    final epoch = ++_authEpoch;
    emit(const AuthSessionState());
    unawaited(_cleanupAfterLogout(allDevices: false, epoch: epoch));
  }

  Future<void> logoutAll() async {
    final epoch = ++_authEpoch;
    emit(const AuthSessionState());
    unawaited(_cleanupAfterLogout(allDevices: true, epoch: epoch));
  }

  Future<void> _cleanupAfterLogout({
    required bool allDevices,
    required int epoch,
  }) async {
    // Clear local session first (fast) so a force-kill cannot restore it.
    // Remote token revoke + FCM unregister stay best-effort afterwards.
    try {
      if (allDevices) {
        await FutureEitherTimeout.guard(
          _logoutAllUseCase(const NoParams()),
          timeout: const Duration(seconds: 8),
        );
      } else {
        await FutureEitherTimeout.guard(
          _logoutUseCase(const NoParams()),
          timeout: const Duration(seconds: 8),
        );
      }
    } on Object {
      // Local clear is handled inside the repository before remote calls.
    }
    if (epoch != _authEpoch || isAuthenticated) return;
    try {
      await _pushCoordinator.stopAndUnregister().timeout(
        const Duration(seconds: 5),
      );
    } on Object {
      // Unregister without auth is best-effort after local logout.
    }
  }

  void clearProfileEffect() {
    emit(state.copyWith(profileEffect: null));
  }

  void clearLoginEffect() {
    emit(state.copyWith(loginEffect: null));
  }

  @override
  Future<void> close() {
    _loginGeneration++;
    _profileGeneration++;
    return super.close();
  }
}
