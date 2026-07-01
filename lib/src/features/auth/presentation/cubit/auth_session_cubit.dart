import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/get_persisted_session_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_session_state.dart';
part 'auth_session_cubit.freezed.dart';

@lazySingleton
class AuthSessionCubit
    extends AppCoreCoreCubit<AuthSessionState, AuthSessionEntity> {
  AuthSessionCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._getPersistedSessionUseCase,
  ) : super(const AuthSessionState());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetPersistedSessionUseCase _getPersistedSessionUseCase;

  bool _initialRestoreComplete = false;
  int _loginGeneration = 0;

  bool get hasCompletedInitialRestore => _initialRestoreComplete;

  bool get isAuthenticated => state.apiState.maybeWhen(
    succeeded: (AuthSessionEntity data) => data.isAuthenticated,
    orElse: () => false,
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

    final result = await _getPersistedSessionUseCase(const NoParams());
    _initialRestoreComplete = true;

    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          apiState: ApiState<AuthSessionEntity>.failed(
            failure,
            retryFunction: restoreSession,
          ),
        ),
      ),
      (AuthSessionEntity? session) {
        if (session == null) {
          emit(
            state.copyWith(
              apiState: const ApiState<AuthSessionEntity>.initial(),
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            apiState: ApiState<AuthSessionEntity>.succeeded(session),
          ),
        );
      },
    );
  }

  Future<void> login({required String phone, required String password}) async {
    final generation = ++_loginGeneration;
    emit(state.copyWith(isLoggingIn: true, loginEffect: null));

    final result = await _loginUseCase(
      LoginParams(phone: phone, password: password),
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
  }

  Future<void> logout() async {
    await _logoutUseCase(const NoParams());
    emit(
      const AuthSessionState(apiState: ApiState<AuthSessionEntity>.initial()),
    );
  }

  void clearLoginEffect() {
    emit(state.copyWith(loginEffect: null));
  }

  @override
  Future<void> close() {
    _loginGeneration++;
    return super.close();
  }
}
