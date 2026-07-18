import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_input_field.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/coordinators/registration_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_brand_header.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_info_banner.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_outline_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_top_bar.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String routePath = '/auth/register';
  static const String routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegistrationCubit>(),
      child: const RegistrationScreenCoordinator(child: _RegisterScreenBody()),
    );
  }
}

class _RegisterScreenBody extends StatelessWidget {
  const _RegisterScreenBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AuthScreenScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTopBar(
            title: l10n.registerScreenTitle,
            onBack: () => AuthNavigation.pop(context: context),
          ),
          const SizedBox(height: 8),
          AuthBrandHeader(
            eyebrow: l10n.registerEyebrow,
            title: l10n.registerWelcomeTitle,
            subtitle: l10n.registerSubtitle,
          ),
          const SizedBox(height: 24),
          TypedFormProvider(
            fields: [
              FormFieldDefinition<String>(
                name: 'name',
                initialValue: '',
                validators: [
                  TypedCommonValidators.required<String>(context: context),
                ],
              ),
              FormFieldDefinition<String>(
                name: 'phone',
                initialValue: '',
                validators: [
                  TypedCommonValidators.required<String>(context: context),
                ],
              ),
              FormFieldDefinition<String>(
                name: 'email',
                initialValue: '',
                validators: [
                  TypedCommonValidators.required<String>(context: context),
                ],
              ),
              FormFieldDefinition<String>(
                name: 'password',
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
                    name: 'name',
                    label: l10n.fullName,
                    hintText: l10n.fullNameHint,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      PhosphorIconsBold.user,
                      size: 18,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppInputField(
                    name: 'phone',
                    label: l10n.phoneNumber,
                    hintText: '0999000000',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      PhosphorIconsBold.phone,
                      size: 18,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppInputField(
                    name: 'email',
                    label: l10n.emailAddress,
                    hintText: l10n.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      PhosphorIconsBold.envelopeSimple,
                      size: 18,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppInputField(
                    name: 'password',
                    label: l10n.password,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
                  AppInputField(
                    name: 'confirmPassword',
                    label: l10n.confirmPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 18),
                  AuthInfoBanner(
                    title: l10n.registerNextStepTitle,
                    body: l10n.registerNextStepBody,
                  ),
                  const SizedBox(height: 18),
                  BlocBuilder<RegistrationCubit, RegistrationState>(
                    buildWhen: (previous, current) =>
                        previous.isRequestingOtp != current.isRequestingOtp,
                    builder: (context, state) {
                      return AuthGradientButton(
                        label: l10n.registerSubmitButton,
                        isLoading: state.isRequestingOtp,
                        onPressed: () => _submit(context),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<RegistrationCubit, RegistrationState>(
                    buildWhen: (previous, current) =>
                        previous.isRequestingOtp != current.isRequestingOtp,
                    builder: (context, state) {
                      return AuthOutlineButton(
                        label: l10n.registerAlreadyHaveCode,
                        onPressed: state.isRequestingOtp
                            ? null
                            : () => _enterExistingCode(context),
                      );
                    },
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
        context.read<RegistrationCubit>().submitRegistrationForm(
          name: form.getValue<String>('name') ?? '',
          phone: form.getValue<String>('phone') ?? '',
          email: form.getValue<String>('email') ?? '',
          password: form.getValue<String>('password') ?? '',
          confirmPassword: form.getValue<String>('confirmPassword') ?? '',
        );
      },
    );
  }

  void _enterExistingCode(BuildContext context) {
    final form = TypedFormProvider.of(context);
    form.validateForm(
      context,
      onValidationPass: () {
        context.read<RegistrationCubit>().prepareOtpVerification(
          name: form.getValue<String>('name') ?? '',
          phone: form.getValue<String>('phone') ?? '',
          email: form.getValue<String>('email') ?? '',
          password: form.getValue<String>('password') ?? '',
          confirmPassword: form.getValue<String>('confirmPassword') ?? '',
        );
      },
    );
  }
}
