import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_earnings/presentation/cubit/instructor_earnings_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_earnings/presentation/widgets/instructor_earnings_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_earnings/presentation/widgets/instructor_earnings_skeleton_body.dart';

class InstructorEarningsScreen extends StatefulWidget {
  const InstructorEarningsScreen({super.key});

  static const routePath = '/instructor/earnings';
  static const routeName = 'instructor-earnings';

  @override
  State<InstructorEarningsScreen> createState() =>
      _InstructorEarningsScreenState();
}

class _InstructorEarningsScreenState extends State<InstructorEarningsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorEarningsCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(title: Text(l10n.instructorEarningsTitle)),
      body: BlocBuilder<InstructorEarningsCubit, InstructorEarningsState>(
        builder: (context, state) => state.apiState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const InstructorEarningsSkeletonBody(),
          succeeded: (earnings) =>
              InstructorEarningsBody(state: state, earnings: earnings),
          failed: (failure, retry) => Center(
            child: AppButton.primary(
              label: CoreFailureMessageMapper.messageFor(failure, l10n),
              onPressed: retry,
            ),
          ),
        ),
      ),
    );
  }
}
