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
  ) : super(const AuthSessionState());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final LogoutAllUseCase _logoutAllUseCase;
  final GetPersistedSessionUseCase _getPersistedSessionUseCase;
  final RefreshProfileUseCase _refreshProfileUseCase;

  bool _initialRestoreComplete = false;
  int _loginGeneration = 0;
  int _profileGeneration = 0;

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
      final result = await _getPersistedSessionUseCase(
        const NoParams(),
      ).timeout(const Duration(seconds: 4));
      _initialRestoreComplete = true;

      result.fold((Failure failure) => _finishInitialRestoreWithoutSession(), (
        AuthSessionEntity? session,
      ) {
        if (session == null) {
          _finishInitialRestoreWithoutSession();
          return;
        }
        emit(
          state.copyWith(
            apiState: ApiState<AuthSessionEntity>.succeeded(session),
          ),
        );
      });
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

        final result = await FutureEitherTimeout.guard(
          _loginUseCase(
            LoginParams(
              phone: validatedPhone,
              password: password,
              deviceName: deviceName ?? AuthConstants.deviceName,
            ),
          ),
        );

        if (!isActiveGeneration(
          capturedGeneration: generation,
          currentGeneration: _loginGeneration,
        )) {
          return;
        }

        result.fold(
          (failure) => emit(
            state.copyWith(
              isLoggingIn: false,
              loginEffect: AuthSessionEffectLoginFailed(failure),
            ),
          ),
          (session) => emit(
            state.copyWith(
              isLoggingIn: false,
              apiState: ApiState<AuthSessionEntity>.succeeded(session),
              loginEffect: const AuthSessionEffectLoginSucceeded(),
            ),
          ),
        );
      },
    );
  }

  void applySession(AuthSessionEntity session) {
    emit(
      state.copyWith(apiState: ApiState<AuthSessionEntity>.succeeded(session)),
    );
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
    await _logoutUseCase(const NoParams());
    emit(
      const AuthSessionState(),
    );
  }

  Future<void> logoutAll() async {
    await _logoutAllUseCase(const NoParams());
    emit(
      const AuthSessionState(),
    );
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
