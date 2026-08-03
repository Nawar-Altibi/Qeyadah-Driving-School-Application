import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/coordinators/student_bookings_list_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_body.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_skeleton_body.dart';

class StudentBookingsListScreen extends StatelessWidget {
  const StudentBookingsListScreen({super.key});

  static const String routePath = '/student/bookings';
  static const String routeName = 'student-bookings';

  @override
  Widget build(BuildContext context) {
    return StudentBookingsListScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).studentBookingsTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child:
              BlocBuilder<StudentBookingsListCubit, StudentBookingsListState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StudentBookingsListFiltersHeader(state: state),
                      Expanded(
                        child: state.apiState.when(
                          initial: () =>
                              const StudentBookingsListSkeletonBody(),
                          loading: () =>
                              const StudentBookingsListSkeletonBody(),
                          succeeded: (page) =>
                              StudentBookingsListBody(state: state, page: page),
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
                        ),
                      ),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}
