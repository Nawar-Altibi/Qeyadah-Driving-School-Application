import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_body.dart';

/// Shimmer loading state for the student bookings list screen.
class StudentBookingsListSkeletonBody extends StatelessWidget {
  const StudentBookingsListSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: StudentBookingsListBody(
        state: const StudentBookingsListState(),
        page: StudentBookingsPageEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
