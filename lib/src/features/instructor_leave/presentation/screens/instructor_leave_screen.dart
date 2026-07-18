import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/coordinators/instructor_leave_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/cubit/instructor_leave_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/widgets/instructor_leave_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/widgets/instructor_leave_skeleton_body.dart';

class InstructorLeaveScreen extends StatelessWidget {
  const InstructorLeaveScreen({super.key});

  static const String routePath = '/instructor/leaves';
  static const String routeName = 'instructor-leaves';

  @override
  Widget build(BuildContext context) {
    return InstructorLeaveScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).instructorLeaveTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child: BlocBuilder<InstructorLeaveCubit, InstructorLeaveState>(
            builder: (context, state) {
              return state.apiState.when(
                initial: () => const InstructorLeaveSkeletonBody(),
                loading: () => const InstructorLeaveSkeletonBody(),
                succeeded: (leaves) => InstructorLeaveBody(leaves: leaves),
                failed: (failure, retry) {
                  final l10n = AppLocalizations.of(context);
                  return Center(
                    child: Padding(
                      padding: PaddingManager.paddingAll16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CoreFailureMessageMapper.messageFor(failure, l10n),
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
