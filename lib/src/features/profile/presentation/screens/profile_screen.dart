import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_action_list_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';

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
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(
        backgroundColor: AppColors.appCanvas,
        surfaceTintColor: Colors.transparent,
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
          padding: AppDesignTokens.screenContentPadding(),
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
                      const SizedBox(width: AppDesignTokens.spacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName ?? '—',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
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
            AppCard(
              padding: const EdgeInsets.symmetric(
                vertical: AppDesignTokens.spacingSm,
              ),
              child: Column(
                children: [
                  AppActionListTile(
                    icon: PhosphorIconsBold.signOut,
                    label: l10n.logoutCurrentDevice,
                    onTap: () => context.read<AuthSessionCubit>().logout(),
                  ),
                  const Divider(height: 1),
                  AppActionListTile(
                    icon: PhosphorIconsBold.signOut,
                    label: l10n.logoutAllDevices,
                    isDestructive: true,
                    onTap: () => context.read<AuthSessionCubit>().logoutAll(),
                  ),
                  const Divider(height: 1),
                  AppActionListTile(
                    icon: PhosphorIconsBold.house,
                    label: l10n.backToHome,
                    onTap: () => AuthNavigation.goHome(
                      context: context,
                      role: user?.primaryRole,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
