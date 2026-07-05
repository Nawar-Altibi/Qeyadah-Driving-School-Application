import 'package:coore/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/utils/future_either_timeout.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/register_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/register_student_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/request_registration_otp_use_case.dart';

part 'registration_state.dart';
part 'registration_effect.dart';

@injectable
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._requestOtpUseCase, this._registerStudentUseCase)
    : super(const RegistrationState());

  final RequestRegistrationOtpUseCase _requestOtpUseCase;
  final RegisterStudentUseCase _registerStudentUseCase;

  int _actionGeneration = 0;

  Future<void> submitRegistrationForm({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final draft = _validateRegistrationDraft(
      name: name,
      phone: phone,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    if (draft == null) return;

    final generation = ++_actionGeneration;
    emit(
      state.copyWith(
        isRequestingOtp: true,
        draft: draft,
        clearEffect: true,
      ),
    );

    final result = await FutureEitherTimeout.guard(
      _requestOtpUseCase(
        RequestRegistrationOtpParams(
          name: draft.name,
          phone: draft.phone,
          email: draft.email,
          password: draft.password,
        ),
      ),
    );
    if (!_isActiveGeneration(generation)) return;

    _emitOtpRequestResult(
      result,
      onSuccess: (challenge) => RegistrationEffectOtpRequested(
        message: challenge.message,
        developmentCode: challenge.developmentCode,
      ),
    );
  }

  Future<void> prepareOtpVerification({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final draft = _validateRegistrationDraft(
      name: name,
      phone: phone,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    if (draft == null) return;

    emit(
      state.copyWith(
        draft: draft,
        isRequestingOtp: false,
        effect: const RegistrationEffectOtpRequested(message: ''),
      ),
    );
  }

  Future<void> resendOtp() async {
    final draft = state.draft;
    if (draft == null) return;

    final generation = ++_actionGeneration;
    emit(state.copyWith(isRequestingOtp: true, clearEffect: true));

    final result = await FutureEitherTimeout.guard(
      _requestOtpUseCase(
        RequestRegistrationOtpParams(
          name: draft.name,
          phone: draft.phone,
          email: draft.email,
          password: draft.password,
        ),
      ),
    );
    if (!_isActiveGeneration(generation)) return;

    _emitOtpRequestResult(
      result,
      onSuccess: (challenge) => RegistrationEffectOtpResent(
        message: challenge.message,
        developmentCode: challenge.developmentCode,
      ),
    );
  }

  Future<void> verifyAndRegister(String code) async {
    final draft = state.draft;
    if (draft == null) return;

    final otpResult = AuthCredentialsRules.validateOtp(code);
    final validatedCode = otpResult.fold<String?>((failure) {
      _emitFailure(failure);
      return null;
    }, (value) => value);
    if (validatedCode == null) return;

    final generation = ++_actionGeneration;
    emit(state.copyWith(isRegistering: true, clearEffect: true));

    final result = await FutureEitherTimeout.guard(
      _registerStudentUseCase(
        RegisterStudentParams(
          name: draft.name,
          phone: draft.phone,
          email: draft.email,
          code: validatedCode,
          password: draft.password,
          deviceName: AuthConstants.deviceName,
        ),
      ),
    );
    if (!_isActiveGeneration(generation)) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRegistering: false,
          effect: RegistrationEffectActionFailed(failure),
        ),
      ),
      (session) => emit(
        state.copyWith(
          isRegistering: false,
          effect: RegistrationEffectRegistrationSucceeded(session),
        ),
      ),
    );
  }

  void clearEffect() {
    emit(state.copyWith(clearEffect: true));
  }

  void resetFlow() {
    _actionGeneration++;
    emit(const RegistrationState());
  }

  void _emitFailure(Failure failure) {
    emit(state.copyWith(effect: RegistrationEffectActionFailed(failure)));
  }

  RegisterDraft? _validateRegistrationDraft({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    final nameResult = AuthCredentialsRules.validateName(name);
    final validatedName = nameResult.fold<String?>((failure) {
      _emitFailure(failure);
      return null;
    }, (value) => value);
    if (validatedName == null) return null;

    final phoneResult = AuthCredentialsRules.validatePhone(phone);
    final validatedPhone = phoneResult.fold<String?>((failure) {
      _emitFailure(failure);
      return null;
    }, (value) => value);
    if (validatedPhone == null) return null;

    final emailResult = AuthCredentialsRules.validateEmail(email);
    final validatedEmail = emailResult.fold<String?>((failure) {
      _emitFailure(failure);
      return null;
    }, (value) => value);
    if (validatedEmail == null) return null;

    final passwordResult = AuthCredentialsRules.validatePassword(password);
    final validatedPassword = passwordResult.fold<String?>((failure) {
      _emitFailure(failure);
      return null;
    }, (value) => value);
    if (validatedPassword == null) return null;

    if (validatedPassword != confirmPassword.trim()) {
      _emitFailure(
        const BusinessFailure(message: AuthValidationKeys.passwordMismatch),
      );
      return null;
    }

    return RegisterDraft(
      name: validatedName,
      phone: validatedPhone,
      email: validatedEmail,
      password: validatedPassword,
    );
  }

  void _emitOtpRequestResult(
    Either<Failure, AuthOtpChallengeEntity> result, {
    required RegistrationEffect Function(AuthOtpChallengeEntity challenge)
    onSuccess,
  }) {
    result.fold(
      (failure) {
        if (failure is RequestTimeoutFailure) {
          emit(
            state.copyWith(
              isRequestingOtp: false,
              effect: const RegistrationEffectOtpRequested(
                message: '',
                timedOut: true,
              ),
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            isRequestingOtp: false,
            effect: RegistrationEffectActionFailed(failure),
          ),
        );
      },
      (challenge) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: onSuccess(challenge),
        ),
      ),
    );
  }

  bool _isActiveGeneration(int generation) => generation == _actionGeneration;

  @override
  Future<void> close() {
    _actionGeneration++;
    return super.close();
  }
}
