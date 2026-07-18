import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/cubit/instructor_earnings_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/widgets/instructor_earnings_body.dart';

/// Shimmer loading state for the instructor earnings screen.
class InstructorEarningsSkeletonBody extends StatelessWidget {
  const InstructorEarningsSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorEarningsBody(
        state: InstructorEarningsState.initial(),
        earnings: InstructorEarningsEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
