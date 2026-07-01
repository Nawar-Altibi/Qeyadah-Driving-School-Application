import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/cubit_effect_listener.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
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
            AuthNavigation.goHome(context: context);
        }
      },
      onClearEffect: (context) {
        context.read<AuthSessionCubit>().clearLoginEffect();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.login)),
        body: ResponsiveShell(
          child: Padding(
            padding: PaddingManager.paddingAll24,
            child: TypedFormProvider(
              fields: [
                FormFieldDefinition<String>(
                  name: 'phone',
                  initialValue: '0999400001',
                  validators: [TypedCommonValidators.required<String>()],
                ),
                FormFieldDefinition<String>(
                  name: 'password',
                  initialValue: 'Test@12345',
                  validators: [TypedCommonValidators.required<String>()],
                ),
              ],
              child: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.loginSubtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(l10n.loginDemoHint),
                    const SizedBox(height: 24),
                    AppInputField(
                      name: 'phone',
                      label: l10n.email,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    AppInputField(
                      name: 'password',
                      label: l10n.password,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthSessionCubit, AuthSessionState>(
                      buildWhen: (previous, current) =>
                          previous.isLoggingIn != current.isLoggingIn,
                      builder: (context, state) {
                        return AppButton.primary(
                          label: l10n.loginButton,
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
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final form = TypedFormProvider.of(context);
    form.validateForm(
      context,
      onValidationPass: () async {
        final phone = form.getValue<String>('phone') ?? '';
        final password = form.getValue<String>('password') ?? '';
        await context.read<AuthSessionCubit>().login(
          phone: phone,
          password: password,
        );
      },
    );
  }
}
