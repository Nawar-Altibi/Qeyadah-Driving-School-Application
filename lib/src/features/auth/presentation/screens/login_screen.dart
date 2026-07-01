import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/cubit_effect_listener.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_input_field.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routePath = '/auth/login';
  static const String routeName = 'login';
  static const String routePathSegment = 'login';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CubitEffectListener<
      AuthSessionCubit,
      AuthSessionState,
      AuthSessionEffect
    >(
      selectEffect: (state) => state.loginEffect,
      onEffect: (context, effect) {
        switch (effect) {
          case AuthSessionEffectLoginFailed(:final failure):
            showErrorMessage(
              message: CoreFailureMessageMapper.messageFor(failure, l10n),
            );
          case AuthSessionEffectLoginSucceeded():
            final role = context
                .read<AuthSessionCubit>()
                .currentSession
                ?.user
                .primaryRole;
            AuthNavigation.goHome(context: context, role: role);
        }
      },
      onClearEffect: (context) {
        context.read<AuthSessionCubit>().clearLoginEffect();
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: AppGradients.softMintBackground,
          ),
          child: SafeArea(
            child: ResponsiveShell(
              child: ListView(
                padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
                children: [
                  const SizedBox(height: AppDesignTokens.spacingLg),
                  const _BrandHeader(),
                  const SizedBox(height: AppDesignTokens.spacingXl),
                  _LoginForm(l10n: l10n),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  const _AuthHelpPanel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.brandPrimary,
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.directions_car_filled_rounded,
            color: AppColors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        Text(
          'Qeyadah Mobile',
          style: textTheme.headlineMedium?.copyWith(
            color: AppColors.ink,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingSm),
        Text(
          'Secure access for students and instructors',
          style: textTheme.bodyLarge?.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderRadius: AppDesignTokens.radiusXl,
      child: AutofillGroup(
        child: TypedFormProvider(
          fields: [
            FormFieldDefinition<String>(
              name: 'phone',
              initialValue: '',
              validators: [TypedCommonValidators.required<String>()],
            ),
            FormFieldDefinition<String>(
              name: 'password',
              initialValue: '',
              validators: [TypedCommonValidators.required<String>()],
            ),
          ],
          child: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.login,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(
                  l10n.loginSubtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                AppInputField(
                  name: 'phone',
                  label: l10n.email,
                  hintText: '0999000000',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autoFillHints: const [AutofillHints.telephoneNumber],
                  prefixIcon: const Icon(Icons.phone_rounded),
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                AppInputField(
                  name: 'password',
                  label: l10n.password,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  autoFillHints: const [AutofillHints.password],
                  prefixIcon: const Icon(Icons.lock_rounded),
                ),
                const SizedBox(height: AppDesignTokens.spacing),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () => showSuccessMessage(
                      message:
                          'Password reset OTP flow is ready in the auth repository.',
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                BlocBuilder<AuthSessionCubit, AuthSessionState>(
                  buildWhen: (previous, current) =>
                      previous.isLoggingIn != current.isLoggingIn,
                  builder: (context, state) {
                    return AppButton.primary(
                      label: l10n.loginButton,
                      icon: Icons.shield_rounded,
                      isLoading: state.isLoggingIn,
                      onPressed: () => _submit(context),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final form = TypedFormProvider.of(context);
    form.validateForm(
      context,
      onValidationPass: () async {
        final phone = (form.getValue<String>('phone') ?? '').trim();
        final password = form.getValue<String>('password') ?? '';
        if (phone.length != 10) {
          showErrorMessage(message: 'Phone number must be 10 digits.');
          return;
        }
        TextInput.finishAutofillContext();
        await context.read<AuthSessionCubit>().login(
          phone: phone,
          password: password,
          deviceName: 'Qeyadah mobile app',
        );
      },
    );
  }
}

class _AuthHelpPanel extends StatelessWidget {
  const _AuthHelpPanel();

  @override
  Widget build(BuildContext context) {
    return AppAlertBanner(
      tone: AppAlertTone.info,
      icon: Icons.verified_user_rounded,
      title: 'Backend connected auth',
      message:
          'Students and instructors are routed by backend roles. Dashboard roles are blocked from mobile access.',
    );
  }
}
