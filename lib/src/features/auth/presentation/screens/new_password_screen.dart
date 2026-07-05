import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_input_field.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/coordinators/login_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_outline_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_otp_input.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_resend_timer.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_top_bar.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({
    super.key,
    required this.phone,
    this.isForced = false,
  });

  final String phone;
  final bool isForced;

  static const String routePath = '/auth/reset-password';
  static const String routeName = 'reset-password';
  static const String forcedRoutePath = '/auth/force-password-change';
  static const String forcedRouteName = 'force-password-change';

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return NewPasswordScreenCoordinator(
      child: AuthScreenScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTopBar(
              title: widget.isForced
                  ? l10n.forcePasswordChangeScreenTitle
                  : l10n.newPasswordScreenTitle,
              onBack: widget.isForced
                  ? null
                  : () => AuthNavigation.pop(context: context),
            ),
            const SizedBox(height: 20),
            Center(child: AuthHeroIcon(icon: PhosphorIconsBold.shieldCheck)),
            const SizedBox(height: 14),
            Text(
              widget.isForced
                  ? l10n.forcePasswordChangeEyebrow
                  : l10n.resetPasswordEyebrow,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 9,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.isForced
                  ? l10n.forcePasswordChangeTitle
                  : l10n.resetPasswordTitle,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.isForced
                  ? l10n.forcePasswordChangeSubtitle
                  : l10n.resetPasswordSubtitle,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.muted,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: AuthOtpInput(controller: _otpController, autofocus: true),
            ),
            const SizedBox(height: 12),
            Center(
              child: AuthResendTimer(
                onResend: () => context.read<PasswordResetCubit>().resendOtp(),
              ),
            ),
            const SizedBox(height: 20),
            TypedFormProvider(
              fields: [
                FormFieldDefinition<String>(
                  name: 'newPassword',
                  initialValue: '',
                  validators: [
                    TypedCommonValidators.required<String>(context: context),
                  ],
                ),
                FormFieldDefinition<String>(
                  name: 'confirmPassword',
                  initialValue: '',
                  validators: [
                    TypedCommonValidators.required<String>(context: context),
                  ],
                ),
              ],
              child: (formContext) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppInputField(
                      name: 'newPassword',
                      label: l10n.newPassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 14),
                    AppInputField(
                      name: 'confirmPassword',
                      label: l10n.confirmNewPassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<PasswordResetCubit, PasswordResetState>(
                      buildWhen: (previous, current) =>
                          previous.isBusy != current.isBusy,
                      builder: (context, state) {
                        return AuthGradientButton(
                          label: l10n.savePasswordAndLogin,
                          isLoading: state.isBusy,
                          onPressed: () => _submit(context),
                        );
                      },
                    ),
                    if (widget.isForced) ...[
                      const SizedBox(height: 12),
                      AuthOutlineButton(
                        label: l10n.logout,
                        onPressed: () =>
                            context.read<AuthSessionCubit>().logout(),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final form = TypedFormProvider.of(context);
    form.validateForm(
      context,
      onValidationPass: () {
        context.read<PasswordResetCubit>().submitReset(
          code: _otpController.text,
          newPassword: form.getValue<String>('newPassword') ?? '',
          confirmPassword: form.getValue<String>('confirmPassword') ?? '',
        );
      },
    );
  }
}
