import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_mobile_bottom_nav.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/coordinators/instructor_profile_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/cubit/instructor_profile_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/widgets/instructor_profile_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/widgets/instructor_profile_skeleton_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/navigation/instructor_navigation.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({super.key});

  static const String routePath = '/instructor/profile';
  static const String routeName = 'instructor-profile';

  @override
  Widget build(BuildContext context) {
    return InstructorProfileScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: BlocBuilder<InstructorProfileCubit, InstructorProfileState>(
                  buildWhen: (previous, current) =>
                      previous.apiState != current.apiState,
                  builder: (context, state) {
                    return state.apiState.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const InstructorProfileSkeletonBody(),
                      succeeded: (dashboard) => InstructorProfileBody(
                        dashboard: dashboard,
                      ),
                      failed: (failure, retry) {
                        final l10n = AppLocalizations.of(context);
                        return Center(
                          child: Padding(
                            padding: PaddingManager.paddingAll16,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  CoreFailureMessageMapper.messageFor(
                                    failure,
                                    l10n,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: AppDesignTokens.spacingMd,
                                ),
                                AppButton.primary(
                                  label: l10n.retry,
                                  onPressed: retry,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Positioned(
                left: AppDesignTokens.screenHorizontalPadding,
                right: AppDesignTokens.screenHorizontalPadding,
                bottom: AppDesignTokens.spacing,
                child: AppMobileBottomNav(
                  activeId: 'profile',
                  items: _bottomNavItems(context),
                  onItemSelected: (tabId) =>
                      InstructorNavigation.handleBottomNav(context, tabId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<AppMobileBottomNavItem> _bottomNavItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      AppMobileBottomNavItem(
        id: 'schedule',
        label: l10n.instructorNavSchedule,
        icon: PhosphorIconsBold.calendar,
      ),
      AppMobileBottomNavItem(
        id: 'profile',
        label: l10n.instructorNavProfile,
        icon: PhosphorIconsBold.user,
      ),
    ];
  }
}
