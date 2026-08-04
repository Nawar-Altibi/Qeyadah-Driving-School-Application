import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/coordinators/registration_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_otp_input.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_outline_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_resend_timer.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_top_bar.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen({super.key});

  static const String routePath = '/auth/register/verify-otp';
  static const String routeName = 'register-verify-otp';

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
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
    final phone = context.watch<RegistrationCubit>().state.draft?.phone ?? '';

    return RegisterOtpScreenCoordinator(
      child: AuthScreenScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTopBar(
              title: l10n.confirmPhoneTitle,
              onBack: () => AuthNavigation.pop(context: context),
            ),
            const SizedBox(height: 24),
            const Center(
              child: AuthHeroIcon(icon: PhosphorIconsBold.bellRinging),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.otpEyebrow,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.otpEnterTitle,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.otpEnterSubtitle(phone),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
                fontSize: 15,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: AuthOtpInput(controller: _otpController, autofocus: true),
            ),
            const SizedBox(height: 16),
            Center(
              child: AuthResendTimer(
                onResend: () => context.read<RegistrationCubit>().resendOtp(),
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<RegistrationCubit, RegistrationState>(
              buildWhen: (previous, current) =>
                  previous.isRegistering != current.isRegistering,
              builder: (context, state) {
                return AuthGradientButton(
                  label: l10n.confirmAndEnter,
                  isLoading: state.isRegistering,
                  onPressed: () => context
                      .read<RegistrationCubit>()
                      .verifyAndRegister(_otpController.text),
                );
              },
            ),
            const SizedBox(height: 12),
            AuthOutlineButton(
              label: l10n.changePhone,
              onPressed: () {
                context.read<RegistrationCubit>().resetFlow();
                AuthNavigation.pop(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
