import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_action_list_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_appearance_section.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/utils/logout_confirmation.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/widgets/student_shell_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routePath = '/profile';
  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final session = context.watch<AuthSessionCubit>().currentSession;
    final user = session?.user;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.profileTitle),
        centerTitle: true,
        automaticallyImplyLeading: Navigator.of(context).canPop(),
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: ResponsiveShell(
                child: ListView(
                  padding: AppDesignTokens.screenContentPadding(
                    extraBottom: AppDesignTokens.bottomNavHeight,
                  ),
                  children: [
                    AppCard(
                      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [colors.brandSoft, AppColors.brandMint],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.card, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A0F5132),
                                  blurRadius: 16,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              PhosphorIconsBold.user,
                              color: AppColors.brandPrimary,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: AppDesignTokens.spacingMd),
                          Text(
                            user?.displayName ?? '—',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.phone ?? '—',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.muted, fontSize: 15),
                          ),
                          if (user?.mustChangePassword ?? false) ...[
                            const SizedBox(height: AppDesignTokens.spacingMd),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: colors.warningBg,
                                borderRadius: BorderRadius.circular(
                                  AppDesignTokens.radiusControl,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.all(12),
                                child: Row(
                                  children: [
                                    Icon(
                                      PhosphorIconsBold.warning,
                                      color: colors.warning,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        l10n.mustChangePasswordNotice,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingLg),
                    const AppAppearanceSection(),
                    const SizedBox(height: AppDesignTokens.spacingLg),
                    AppCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDesignTokens.spacingSm,
                        horizontal: AppDesignTokens.spacingXs,
                      ),
                      child: Column(
                        children: [
                          AppActionListTile(
                            icon: PhosphorIconsBold.signOut,
                            label: l10n.logoutCurrentDevice,
                            onTap: () async {
                              final confirmed = await confirmLogout(context);
                              if (!context.mounted || !confirmed) return;
                              await context.read<AuthSessionCubit>().logout();
                            },
                          ),
                          Divider(
                            height: 1,
                            indent: 56,
                            color: colors.line.withValues(alpha: 0.7),
                          ),
                          AppActionListTile(
                            icon: PhosphorIconsBold.signOut,
                            label: l10n.logoutAllDevices,
                            isDestructive: true,
                            onTap: () async {
                              final confirmed = await confirmLogout(
                                context,
                                allDevices: true,
                              );
                              if (!context.mounted || !confirmed) return;
                              await context.read<AuthSessionCubit>().logoutAll();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const StudentShellBottomNav(activeId: 'profile'),
          ],
        ),
      ),
    );
  }
}
