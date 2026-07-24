import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/coordinators/instructor_notifications_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/cubit/instructor_notifications_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/widgets/instructor_notifications_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/widgets/instructor_notifications_skeleton_body.dart';

class InstructorNotificationsScreen extends StatelessWidget {
  const InstructorNotificationsScreen({super.key});

  static const String routePath = '/instructor/notifications';
  static const String routeName = 'instructor-notifications';

  @override
  Widget build(BuildContext context) {
    return InstructorNotificationsScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).instructorNotificationsTitle,
          ),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child:
              BlocBuilder<
                InstructorNotificationsCubit,
                InstructorNotificationsState
              >(
                builder: (context, state) {
                  return state.apiState.when(
                    initial: () => const InstructorNotificationsSkeletonBody(),
                    loading: () => const InstructorNotificationsSkeletonBody(),
                    succeeded: (page) =>
                        InstructorNotificationsBody(state: state, page: page),
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
                              const SizedBox(height: AppDesignTokens.spacingMd),
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
    );
  }
}
