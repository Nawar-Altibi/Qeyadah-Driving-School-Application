import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_async_body.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/coordinators/student_bookings_list_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_body.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_skeleton_body.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/widgets/student_shell_bottom_nav.dart';

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
          automaticallyImplyLeading: Navigator.of(context).canPop(),
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: ResponsiveShell(
                  child:
                      BlocBuilder<
                        StudentBookingsListCubit,
                        StudentBookingsListState
                      >(
                        buildWhen: (previous, next) =>
                            previous.apiState != next.apiState ||
                            previous.selectedStatus != next.selectedStatus ||
                            previous.sortOrder != next.sortOrder ||
                            previous.isLoadingMore != next.isLoadingMore ||
                            previous.isRefreshing != next.isRefreshing ||
                            previous.searchQuery != next.searchQuery,
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              StudentBookingsListFiltersHeader(state: state),
                              Expanded(
                                child: AppAsyncBody(
                                  state: state.apiState,
                                  loading:
                                      const StudentBookingsListSkeletonBody(),
                                  builder: (context, page) =>
                                      StudentBookingsListBody(
                                        state: state,
                                        page: page,
                                      ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                ),
              ),
              const StudentShellBottomNav(activeId: 'bookings'),
            ],
          ),
        ),
      ),
    );
  }
}
