import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/coordinators/student_booking_detail_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_booking_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_booking_detail_body.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_booking_detail_skeleton_body.dart';

class StudentBookingDetailScreen extends StatelessWidget {
  const StudentBookingDetailScreen({super.key, required this.bookingId});

  static const String routePath = '/student/bookings/detail';
  static const String routeName = 'student-booking-detail';

  final int bookingId;

  @override
  Widget build(BuildContext context) {
    return StudentBookingDetailScreenCoordinator(
      bookingId: bookingId,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).studentBookingDetailTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child:
              BlocBuilder<StudentBookingDetailCubit, StudentBookingDetailState>(
                builder: (context, state) {
                  return state.apiState.when(
                    initial: () => const StudentBookingDetailSkeletonBody(),
                    loading: () => const StudentBookingDetailSkeletonBody(),
                    succeeded: (detail) => StudentBookingDetailBody(
                      detail: detail,
                      isCancelling: state.isCancelling,
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
