import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/mappers/auth_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';

class ForgotPasswordScreenCoordinator extends StatelessWidget {
  const ForgotPasswordScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<PasswordResetCubit, PasswordResetState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case PasswordResetEffectNavigateToReset(:final phone):
            AuthNavigation.pushNewPassword(context: context, phone: phone);
          case PasswordResetEffectActionFailed(:final failure):
            showErrorMessage(
              message: AuthFailureMessageMapper.messageFor(failure, l10n),
            );
          case PasswordResetEffectOtpRequested():
          case PasswordResetEffectOtpResent():
          case PasswordResetEffectResetSucceeded():
            break;
        }
        context.read<PasswordResetCubit>().clearEffect();
      },
      child: child,
    );
  }
}

class NewPasswordScreenCoordinator extends StatelessWidget {
  const NewPasswordScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<PasswordResetCubit, PasswordResetState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case PasswordResetEffectOtpResent():
            showSuccessMessage(message: l10n.otpResentSuccess);
          case PasswordResetEffectActionFailed(:final failure):
            showErrorMessage(
              message: AuthFailureMessageMapper.messageFor(failure, l10n),
            );
          case PasswordResetEffectResetSucceeded():
            context.read<PasswordResetCubit>().resetFlow();
            showSuccessMessage(message: l10n.passwordResetSuccess);
            context.read<AuthSessionCubit>().logout();
            AuthNavigation.goLogin(context: context);
          case PasswordResetEffectOtpRequested(:final message):
            if (message.isNotEmpty) showSuccessMessage(message: message);
          case PasswordResetEffectNavigateToReset():
            break;
        }
        context.read<PasswordResetCubit>().clearEffect();
      },
      child: child,
    );
  }
}

class LoginScreenCoordinator extends StatelessWidget {
  const LoginScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthSessionCubit, AuthSessionState>(
      listenWhen: (previous, current) =>
          previous.loginEffect != current.loginEffect &&
          current.loginEffect != null,
      listener: (context, state) {
        final effect = state.loginEffect;
        if (effect == null) return;

        switch (effect) {
          case AuthSessionEffectLoginFailed(:final failure):
            showErrorMessage(
              message: AuthFailureMessageMapper.messageFor(failure, l10n),
            );
          case AuthSessionEffectLoginSucceeded():
            final session = context.read<AuthSessionCubit>().currentSession;
            if (session?.user.mustChangePassword ?? false) {
              AuthNavigation.goForcePasswordChange(context: context);
            } else {
              AuthNavigation.goHome(
                context: context,
                role: session?.user.primaryRole,
              );
            }
          case AuthSessionEffectProfileRefreshed():
          case AuthSessionEffectProfileFailed():
            break;
        }
        context.read<AuthSessionCubit>().clearLoginEffect();
      },
      child: child,
    );
  }
}
