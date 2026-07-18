import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_input_field.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_text_link.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

typedef AuthForgotPasswordCallback = void Function();

class AuthLoginForm extends StatelessWidget {
  const AuthLoginForm({
    super.key,
    required this.onForgotPassword,
  });

  final AuthForgotPasswordCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AutofillGroup(
      child: TypedFormProvider(
        fields: [
          FormFieldDefinition<String>(
            name: 'phone',
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
        ],
        child: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppInputField(
                name: 'phone',
                label: l10n.phoneNumber,
                hintText: '0999000000',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                autoFillHints: const [AutofillHints.telephoneNumber],
                prefixIcon: const Icon(
                  PhosphorIconsBold.phone,
                  size: 18,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 14),
              AppInputField(
                name: 'password',
                label: l10n.password,
                obscureText: true,
                textInputAction: TextInputAction.done,
                autoFillHints: const [AutofillHints.password],
              ),
              const SizedBox(height: 4),
              AuthTextLink(
                label: l10n.forgotPassword,
                onPressed: onForgotPassword,
              ),
              const SizedBox(height: 14),
              BlocBuilder<AuthSessionCubit, AuthSessionState>(
                buildWhen: (previous, current) =>
                    previous.isLoggingIn != current.isLoggingIn,
                builder: (context, state) {
                  return AuthGradientButton(
                    label: l10n.loginButton,
                    icon: PhosphorIconsBold.shieldCheck,
                    isLoading: state.isLoggingIn,
                    onPressed: () => _submit(context),
                  );
                },
              ),
            ],
          );
        },
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
        TextInput.finishAutofillContext();
        await context.read<AuthSessionCubit>().login(
          phone: phone,
          password: password,
          deviceName: AuthConstants.deviceName,
        );
      },
    );
  }
}
