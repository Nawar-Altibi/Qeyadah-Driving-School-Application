import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/coordinators/student_booking_screen_coordinators.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/widgets/student_booking_slots_body.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/widgets/student_booking_slots_skeleton_body.dart';

class StudentBookingSlotsScreen extends StatefulWidget {
  const StudentBookingSlotsScreen({super.key});

  static const String routePath = '/student/booking/slots';
  static const String routeName = 'student-booking-slots';

  @override
  State<StudentBookingSlotsScreen> createState() =>
      _StudentBookingSlotsScreenState();
}

class _StudentBookingSlotsScreenState extends State<StudentBookingSlotsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<StudentBookingCubit>().loadSlots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StudentBookingSlotsScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).studentBookingSlotsTitle),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ResponsiveShell(
            child: BlocBuilder<StudentBookingCubit, StudentBookingState>(
              buildWhen: (previous, current) =>
                  previous.apiState != current.apiState,
              builder: (context, state) {
                return state.apiState.when(
                  initial: () => const StudentBookingSlotsSkeletonBody(),
                  loading: () => const StudentBookingSlotsSkeletonBody(),
                  succeeded: (page) => StudentBookingSlotsBody(page: page),
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
      ),
    );
  }
}
