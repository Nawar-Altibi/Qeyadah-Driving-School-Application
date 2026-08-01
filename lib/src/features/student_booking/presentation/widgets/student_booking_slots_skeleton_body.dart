import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/widgets/student_booking_slots_body.dart';

/// Shimmer loading state for the student booking slots screen.
class StudentBookingSlotsSkeletonBody extends StatelessWidget {
  const StudentBookingSlotsSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: StudentBookingSlotsBody(
        page: StudentAvailableSlotsPageEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
