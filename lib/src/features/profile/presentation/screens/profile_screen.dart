import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/widgets/auth_outline_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routePath = '/profile';
  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = context.watch<AuthSessionCubit>().currentSession;
    final user = session?.user;
    final isRefreshing = context.select(
      (AuthSessionCubit cubit) => cubit.state.isRefreshingProfile,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        actions: [
          IconButton(
            tooltip: l10n.refreshProfile,
            onPressed: isRefreshing
                ? null
                : () => context.read<AuthSessionCubit>().refreshProfile(),
            icon: isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: ResponsiveShell(
        child: ListView(
          padding: PaddingManager.paddingAll16,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.brandMintSoft,
                          borderRadius: BorderRadius.circular(
                            AppDesignTokens.radiusControl,
                          ),
                        ),
                        child: const Icon(
                          PhosphorIconsBold.user,
                          color: AppColors.brandPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName ?? '—',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              user?.phone ?? '—',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.muted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesignTokens.spacingLg),
                  _ProfileRow(
                    label: l10n.profileName,
                    value: user?.displayName ?? '—',
                  ),
                  const SizedBox(height: AppDesignTokens.spacingSm),
                  _ProfileRow(
                    label: l10n.profilePhone,
                    value: user?.phone ?? '—',
                  ),
                  if (user?.mustChangePassword ?? false) ...[
                    const SizedBox(height: AppDesignTokens.spacingMd),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.warningBg,
                        borderRadius: BorderRadius.circular(
                          AppDesignTokens.radiusControl,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(12),
                        child: Text(
                          l10n.mustChangePasswordNotice,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingLg),
            AuthOutlineButton(
              label: l10n.logoutCurrentDevice,
              onPressed: () => context.read<AuthSessionCubit>().logout(),
            ),
            const SizedBox(height: 12),
            AuthOutlineButton(
              label: l10n.logoutAllDevices,
              onPressed: () => context.read<AuthSessionCubit>().logoutAll(),
            ),
            const SizedBox(height: 12),
            AuthGradientButton(
              label: l10n.backToHome,
              onPressed: () => AuthNavigation.goHome(
                context: context,
                role: user?.primaryRole,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
