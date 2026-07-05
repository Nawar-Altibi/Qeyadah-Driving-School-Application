import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/mappers/auth_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';

class RegistrationScreenCoordinator extends StatelessWidget {
  const RegistrationScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<RegistrationCubit, RegistrationState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case RegistrationEffectOtpRequested(
            :final message,
            :final developmentCode,
            :final timedOut,
          ):
            if (timedOut) {
              showSuccessMessage(message: l10n.registerOtpTimeoutProceed);
            } else if (message.isNotEmpty) {
              showSuccessMessage(message: message);
            }
            if (developmentCode != null && developmentCode.isNotEmpty) {
              showSuccessMessage(message: 'OTP: $developmentCode');
            }
            AuthNavigation.pushRegisterOtp(context: context);
          case RegistrationEffectOtpResent(
            :final message,
            :final developmentCode,
          ):
            if (message.isNotEmpty) showSuccessMessage(message: message);
            if (developmentCode != null && developmentCode.isNotEmpty) {
              showSuccessMessage(message: 'OTP: $developmentCode');
            }
          case RegistrationEffectActionFailed(:final failure):
            showErrorMessage(
              message: AuthFailureMessageMapper.messageFor(failure, l10n),
            );
          case RegistrationEffectRegistrationSucceeded(:final session):
            context.read<AuthSessionCubit>().applySession(session);
            if (session.user.mustChangePassword) {
              AuthNavigation.goForcePasswordChange(context: context);
            } else {
              AuthNavigation.goHome(
                context: context,
                role: session.user.primaryRole,
              );
            }
        }
        context.read<RegistrationCubit>().clearEffect();
      },
      child: child,
    );
  }
}

class RegisterOtpScreenCoordinator extends StatelessWidget {
  const RegisterOtpScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<RegistrationCubit, RegistrationState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case RegistrationEffectOtpResent(
            :final message,
            :final developmentCode,
          ):
            if (message.isNotEmpty) showSuccessMessage(message: message);
            if (developmentCode != null && developmentCode.isNotEmpty) {
              showSuccessMessage(message: 'OTP: $developmentCode');
            }
          case RegistrationEffectActionFailed(:final failure):
            showErrorMessage(
              message: AuthFailureMessageMapper.messageFor(failure, l10n),
            );
          case RegistrationEffectRegistrationSucceeded(:final session):
            context.read<AuthSessionCubit>().applySession(session);
            if (session.user.mustChangePassword) {
              AuthNavigation.goForcePasswordChange(context: context);
            } else {
              AuthNavigation.goHome(
                context: context,
                role: session.user.primaryRole,
              );
            }
          case RegistrationEffectOtpRequested():
            break;
        }
        context.read<RegistrationCubit>().clearEffect();
      },
      child: child,
    );
  }
}
