import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/coordinators/login_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_brand_header.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_login_form.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_outline_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_screen_scaffold.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_text_link.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routePath = '/auth/login';
  static const String routeName = 'login';
  static const String routePathSegment = 'login';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return LoginScreenCoordinator(
      child: AuthScreenScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthBrandHeader(),
            const SizedBox(height: 28),
            AuthLoginForm(
              onForgotPassword: () =>
                  AuthNavigation.pushForgotPassword(context: context),
            ),
            const SizedBox(height: 14),
            AuthOutlineButton(
              label: l10n.createStudentAccount,
              onPressed: () => AuthNavigation.pushRegister(context: context),
            ),
            const SizedBox(height: 18),
            const AuthSecureNote(),
          ],
        ),
      ),
    );
  }
}
