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
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/coordinators/instructor_schedule_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/widgets/instructor_schedule_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/widgets/instructor_schedule_skeleton_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/navigation/instructor_navigation.dart';

class InstructorScheduleScreen extends StatelessWidget {
  const InstructorScheduleScreen({super.key});

  static const String routePath = '/instructor/home';
  static const String routeName = 'instructor-home';

  @override
  Widget build(BuildContext context) {
    return InstructorScheduleScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: ResponsiveShell(
                    child:
                        BlocBuilder<
                          InstructorScheduleCubit,
                          InstructorScheduleState
                        >(
                          buildWhen: (previous, current) =>
                              previous.apiState != current.apiState ||
                              previous.isSilentRefresh !=
                                  current.isSilentRefresh,
                          builder: (context, state) {
                            return state.apiState.when(
                              initial: () =>
                                  const InstructorScheduleSkeletonBody(),
                              loading: () =>
                                  const InstructorScheduleSkeletonBody(),
                              succeeded: (dashboard) =>
                                  InstructorScheduleBody(dashboard: dashboard),
                              failed: (failure, retry) {
                                final l10n = AppLocalizations.of(context);
                                return Center(
                                  child: Padding(
                                    padding: PaddingManager.paddingAll16,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                ),
              ),
              Positioned(
                left: AppDesignTokens.screenHorizontalPadding,
                right: AppDesignTokens.screenHorizontalPadding,
                bottom: AppDesignTokens.spacing,
                child: AppMobileBottomNav(
                  activeId: 'schedule',
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
