import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/cubit/instructor_dues_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/widgets/instructor_dues_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/widgets/instructor_dues_skeleton_body.dart';

class InstructorDuesScreen extends StatefulWidget {
  const InstructorDuesScreen({super.key});

  static const routePath = '/instructor/dues';
  static const routeName = 'instructor-dues';

  @override
  State<InstructorDuesScreen> createState() => _InstructorDuesScreenState();
}

class _InstructorDuesScreenState extends State<InstructorDuesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorDuesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(title: Text(l10n.instructorDuesTitle)),
      body: BlocBuilder<InstructorDuesCubit, InstructorDuesState>(
        builder: (context, state) => state.apiState.when(
          initial: () => const InstructorDuesSkeletonBody(),
          loading: () => const InstructorDuesSkeletonBody(),
          succeeded: (dues) => InstructorDuesBody(dues: dues),
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
