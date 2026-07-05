part of 'registration_cubit.dart';

sealed class RegistrationEffect {
  const RegistrationEffect();
}

final class RegistrationEffectOtpRequested extends RegistrationEffect {
  const RegistrationEffectOtpRequested({
    required this.message,
    this.developmentCode,
    this.timedOut = false,
  });

  final String message;
  final String? developmentCode;
  final bool timedOut;
}

final class RegistrationEffectOtpResent extends RegistrationEffect {
  const RegistrationEffectOtpResent({
    required this.message,
    this.developmentCode,
  });

  final String message;
  final String? developmentCode;
}

final class RegistrationEffectActionFailed extends RegistrationEffect {
  const RegistrationEffectActionFailed(this.failure);

  final Failure failure;
}

final class RegistrationEffectRegistrationSucceeded extends RegistrationEffect {
  const RegistrationEffectRegistrationSucceeded(this.session);

  final AuthSessionEntity session;
}
