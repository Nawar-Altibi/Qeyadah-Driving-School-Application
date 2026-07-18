import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_input_field.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/coordinators/login_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_brand_header.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_outline_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_top_bar.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const String routePath = '/auth/forgot-password';
  static const String routeName = 'forgot-password';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PasswordResetCubit>(),
      child: const ForgotPasswordScreenCoordinator(
        child: _ForgotPasswordScreenBody(),
      ),
    );
  }
}

class _ForgotPasswordScreenBody extends StatelessWidget {
  const _ForgotPasswordScreenBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AuthScreenScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTopBar(
            title: l10n.forgotPasswordScreenTitle,
            onBack: () => AuthNavigation.pop(context: context),
          ),
          const SizedBox(height: 8),
          AuthBrandHeader(
            eyebrow: l10n.accountRecoveryEyebrow,
            title: l10n.forgotPasswordTitle,
            subtitle: l10n.forgotPasswordSubtitle,
          ),
          const SizedBox(height: 24),
          TypedFormProvider(
            fields: [
              FormFieldDefinition<String>(
                name: 'phone',
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
                    name: 'phone',
                    label: l10n.phoneNumber,
                    hintText: '0999000000',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(
                      PhosphorIconsBold.phone,
                      size: 18,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<PasswordResetCubit, PasswordResetState>(
                    buildWhen: (previous, current) =>
                        previous.isRequestingOtp != current.isRequestingOtp,
                    builder: (context, state) {
                      return AuthGradientButton(
                        label: l10n.sendVerificationCode,
                        isLoading: state.isRequestingOtp,
                        onPressed: () => _submit(context),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  AuthOutlineButton(
                    label: l10n.backToLogin,
                    onPressed: () => AuthNavigation.pop(context: context),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    final form = TypedFormProvider.of(context);
    form.validateForm(
      context,
      onValidationPass: () {
        final phone = form.getValue<String>('phone') ?? '';
        context.read<PasswordResetCubit>().requestOtp(phone);
      },
    );
  }
}
