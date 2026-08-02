import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_booking_detail_body.dart';

/// Shimmer loading state for the student booking detail screen.
class StudentBookingDetailSkeletonBody extends StatelessWidget {
  const StudentBookingDetailSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: StudentBookingDetailBody(
        detail: StudentBookingDetailEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
