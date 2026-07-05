part of 'password_reset_cubit.dart';

enum PasswordResetStep { otp, newPassword }

class PasswordResetState {
  const PasswordResetState({
    this.phone,
    this.resetToken,
    this.step = PasswordResetStep.otp,
    this.isRequestingOtp = false,
    this.isVerifyingOtp = false,
    this.isResetting = false,
    this.effect,
  });

  final String? phone;
  final String? resetToken;
  final PasswordResetStep step;
  final bool isRequestingOtp;
  final bool isVerifyingOtp;
  final bool isResetting;
  final PasswordResetEffect? effect;

  bool get isBusy => isRequestingOtp || isVerifyingOtp || isResetting;

  PasswordResetState copyWith({
    String? phone,
    String? resetToken,
    PasswordResetStep? step,
    bool? isRequestingOtp,
    bool? isVerifyingOtp,
    bool? isResetting,
    PasswordResetEffect? effect,
  }) {
    return PasswordResetState(
      phone: phone ?? this.phone,
      resetToken: resetToken ?? this.resetToken,
      step: step ?? this.step,
      isRequestingOtp: isRequestingOtp ?? this.isRequestingOtp,
      isVerifyingOtp: isVerifyingOtp ?? this.isVerifyingOtp,
      isResetting: isResetting ?? this.isResetting,
      effect: effect,
    );
  }
}

sealed class PasswordResetEffect {
  const PasswordResetEffect();
}

final class PasswordResetEffectOtpRequested extends PasswordResetEffect {
  const PasswordResetEffectOtpRequested(this.message);

  final String message;
}

final class PasswordResetEffectActionFailed extends PasswordResetEffect {
  const PasswordResetEffectActionFailed(this.failure);

  final Failure failure;
}

final class PasswordResetEffectNavigateToReset extends PasswordResetEffect {
  const PasswordResetEffectNavigateToReset(this.phone);

  final String phone;
}

final class PasswordResetEffectOtpResent extends PasswordResetEffect {
  const PasswordResetEffectOtpResent();
}

final class PasswordResetEffectResetSucceeded extends PasswordResetEffect {
  const PasswordResetEffectResetSucceeded();
}
