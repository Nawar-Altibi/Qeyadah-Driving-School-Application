import 'package:coore/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/utils/future_either_timeout.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/password_reset_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/request_password_reset_otp_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/verify_password_reset_otp_use_case.dart';

part 'password_reset_state.dart';

@injectable
class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit(
    this._requestOtpUseCase,
    this._verifyOtpUseCase,
    this._resetPasswordUseCase,
  ) : super(const PasswordResetState());

  final RequestPasswordResetOtpUseCase _requestOtpUseCase;
  final VerifyPasswordResetOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  int _actionGeneration = 0;

  Future<void> startForcedPasswordChange(String phone) async {
    final phoneResult = AuthCredentialsRules.validatePhone(phone);
    final validatedPhone = phoneResult.fold<String?>((failure) {
      emit(state.copyWith(effect: PasswordResetEffectActionFailed(failure)));
      return null;
    }, (value) => value);
    if (validatedPhone == null) return;

    final generation = ++_actionGeneration;
    emit(
      state.copyWith(
        isRequestingOtp: true,
        phone: validatedPhone,
      ),
    );

    final result = await FutureEitherTimeout.guard(
      _requestOtpUseCase(ForgotPasswordParams(phone: validatedPhone)),
    );
    if (!_isActiveGeneration(generation)) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: PasswordResetEffectActionFailed(failure),
        ),
      ),
      (challenge) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: PasswordResetEffectOtpRequested(challenge.message),
        ),
      ),
    );
  }

  Future<void> requestOtp(String phone) async {
    final phoneResult = AuthCredentialsRules.validatePhone(phone);
    final validatedPhone = phoneResult.fold<String?>((failure) {
      emit(state.copyWith(effect: PasswordResetEffectActionFailed(failure)));
      return null;
    }, (value) => value);
    if (validatedPhone == null) return;

    final generation = ++_actionGeneration;
    emit(
      state.copyWith(
        isRequestingOtp: true,
        phone: validatedPhone,
      ),
    );

    final result = await FutureEitherTimeout.guard(
      _requestOtpUseCase(ForgotPasswordParams(phone: validatedPhone)),
    );
    if (!_isActiveGeneration(generation)) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: PasswordResetEffectActionFailed(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: PasswordResetEffectNavigateToReset(validatedPhone),
        ),
      ),
    );
  }

  Future<void> verifyOtp(String code) async {
    final phone = state.phone;
    if (phone == null) return;

    final otpResult = AuthCredentialsRules.validateOtp(code);
    final validatedCode = otpResult.fold<String?>((failure) {
      emit(state.copyWith(effect: PasswordResetEffectActionFailed(failure)));
      return null;
    }, (value) => value);
    if (validatedCode == null) return;

    final generation = ++_actionGeneration;
    emit(state.copyWith(isVerifyingOtp: true));

    final result = await FutureEitherTimeout.guard(
      _verifyOtpUseCase(
        VerifyPasswordResetOtpParams(phone: phone, code: validatedCode),
      ),
    );
    if (!_isActiveGeneration(generation)) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          isVerifyingOtp: false,
          effect: PasswordResetEffectActionFailed(failure),
        ),
      ),
      (resetToken) => emit(
        state.copyWith(
          isVerifyingOtp: false,
          resetToken: resetToken,
          step: PasswordResetStep.newPassword,
        ),
      ),
    );
  }

  Future<void> submitReset({
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.trim() != confirmPassword.trim()) {
      emit(
        state.copyWith(
          effect: const PasswordResetEffectActionFailed(
            BusinessFailure(message: AuthValidationKeys.passwordMismatch),
          ),
        ),
      );
      return;
    }

    final passwordResult = AuthCredentialsRules.validatePassword(newPassword);
    final validatedPassword = passwordResult.fold<String?>((failure) {
      emit(state.copyWith(effect: PasswordResetEffectActionFailed(failure)));
      return null;
    }, (value) => value);
    if (validatedPassword == null) return;

    final otpResult = AuthCredentialsRules.validateOtp(code);
    final validatedCode = otpResult.fold<String?>((failure) {
      emit(state.copyWith(effect: PasswordResetEffectActionFailed(failure)));
      return null;
    }, (value) => value);
    if (validatedCode == null) return;

    final phone = state.phone;
    if (phone == null) return;

    final generation = ++_actionGeneration;
    emit(state.copyWith(isVerifyingOtp: true, isResetting: true));

    final verifyResult = await FutureEitherTimeout.guard(
      _verifyOtpUseCase(
        VerifyPasswordResetOtpParams(phone: phone, code: validatedCode),
      ),
    );
    if (!_isActiveGeneration(generation)) return;

    String? resetToken;
    verifyResult.fold(
      (failure) => emit(
        state.copyWith(
          isVerifyingOtp: false,
          isResetting: false,
          effect: PasswordResetEffectActionFailed(failure),
        ),
      ),
      (token) => resetToken = token,
    );
    if (resetToken == null) return;

    final resetResult = await FutureEitherTimeout.guard(
      _resetPasswordUseCase(
        ResetPasswordParams(
          resetToken: resetToken!,
          newPassword: validatedPassword,
        ),
      ),
    );
    if (!_isActiveGeneration(generation)) return;

    resetResult.fold(
      (failure) => emit(
        state.copyWith(
          isVerifyingOtp: false,
          isResetting: false,
          effect: PasswordResetEffectActionFailed(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          isVerifyingOtp: false,
          isResetting: false,
          effect: const PasswordResetEffectResetSucceeded(),
        ),
      ),
    );
  }

  Future<void> resendOtp() async {
    final phone = state.phone;
    if (phone == null) return;

    final generation = ++_actionGeneration;
    emit(state.copyWith(isRequestingOtp: true));

    final result = await FutureEitherTimeout.guard(
      _requestOtpUseCase(ForgotPasswordParams(phone: phone)),
    );
    if (!_isActiveGeneration(generation)) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: PasswordResetEffectActionFailed(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          isRequestingOtp: false,
          effect: const PasswordResetEffectOtpResent(),
        ),
      ),
    );
  }

  void clearEffect() {
    emit(state.copyWith());
  }

  void resetFlow() {
    _actionGeneration++;
    emit(const PasswordResetState());
  }

  bool _isActiveGeneration(int generation) => generation == _actionGeneration;

  @override
  Future<void> close() {
    _actionGeneration++;
    return super.close();
  }
}
