part of 'registration_cubit.dart';

class RegistrationState {
  const RegistrationState({
    this.draft,
    this.isRequestingOtp = false,
    this.isRegistering = false,
    this.effect,
  });

  final RegisterDraft? draft;
  final bool isRequestingOtp;
  final bool isRegistering;
  final RegistrationEffect? effect;

  bool get isBusy => isRequestingOtp || isRegistering;

  RegistrationState copyWith({
    RegisterDraft? draft,
    bool? isRequestingOtp,
    bool? isRegistering,
    RegistrationEffect? effect,
    bool clearEffect = false,
  }) {
    return RegistrationState(
      draft: draft ?? this.draft,
      isRequestingOtp: isRequestingOtp ?? this.isRequestingOtp,
      isRegistering: isRegistering ?? this.isRegistering,
      effect: clearEffect ? null : (effect ?? this.effect),
    );
  }
}
