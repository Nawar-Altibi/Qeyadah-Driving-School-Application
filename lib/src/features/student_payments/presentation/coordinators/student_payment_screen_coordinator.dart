import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/cubit/student_payment_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/mappers/student_payment_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_navigation.dart';

class StudentPaymentScreenCoordinator extends StatelessWidget {
  const StudentPaymentScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<StudentPaymentCubit, StudentPaymentState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case StudentPaymentEffectPaymentConfirmed():
            showSuccessMessage(message: l10n.studentPaymentSuccessMessage);
            StudentPaymentNavigation.goHome(context: context);
          case StudentPaymentEffectActionFailed(:final failure):
            showErrorMessage(
              message: StudentPaymentFailureMessageMapper.messageFor(
                failure,
                l10n,
              ),
            );
        }
        context.read<StudentPaymentCubit>().clearEffect();
      },
      child: child,
    );
  }
}
