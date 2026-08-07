import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/use_cases/student_booking_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_navigation.dart';

/// Listens for the preferences -> slots navigation effect.
class StudentBookingPreferencesScreenCoordinator extends StatelessWidget {
  const StudentBookingPreferencesScreenCoordinator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBookingCubit, StudentBookingState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case StudentBookingEffectNavigateToSlots():
            StudentBookingNavigation.pushSlots(context: context);
          case StudentBookingEffectNavigateToReview():
          case StudentBookingEffectBookingCreated():
          case StudentBookingEffectSlotConflict():
          case StudentBookingEffectBackendConflict():
          case StudentBookingEffectPendingPaymentConflict():
          case StudentBookingEffectActionFailed():
            break;
        }
        context.read<StudentBookingCubit>().clearEffect();
      },
      child: child,
    );
  }
}

/// Listens for the slots -> review navigation effect.
class StudentBookingSlotsScreenCoordinator extends StatelessWidget {
  const StudentBookingSlotsScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBookingCubit, StudentBookingState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case StudentBookingEffectNavigateToReview():
            StudentBookingNavigation.pushReview(context: context);
          case StudentBookingEffectNavigateToSlots():
          case StudentBookingEffectBookingCreated():
          case StudentBookingEffectSlotConflict():
          case StudentBookingEffectBackendConflict():
          case StudentBookingEffectPendingPaymentConflict():
          case StudentBookingEffectActionFailed():
            break;
        }
        context.read<StudentBookingCubit>().clearEffect();
      },
      child: child,
    );
  }
}

/// Listens for booking creation, conflict, and failure effects raised from
/// the review screen's "confirm booking" action.
class StudentBookingReviewScreenCoordinator extends StatelessWidget {
  const StudentBookingReviewScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<StudentBookingCubit, StudentBookingState>(
      listenWhen: (previous, current) =>
          previous.effect != current.effect && current.effect != null,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        switch (effect) {
          case StudentBookingEffectBookingCreated(:final hold):
            if (hold.paymentRequired) {
              StudentPaymentNavigation.pushPayment(
                context: context,
                args: StudentPaymentHoldArgs(
                  bookingId: hold.booking.id,
                  depositAmount: hold.depositAmount,
                  receiverName: hold.receiverName,
                  lockedUntil: hold.lockedUntil,
                ),
              );
            } else {
              StudentBookingNavigation.goHome(context: context);
            }
          case StudentBookingEffectSlotConflict():
            showErrorMessage(message: l10n.studentBookingErrorSlotConflict);
            Navigator.of(context).pop();
            context.read<StudentBookingCubit>().loadSlots();
          case StudentBookingEffectBackendConflict(:final failure):
            showErrorMessage(
              message: failure.message.isNotEmpty
                  ? failure.message
                  : l10n.errorGeneric,
            );
          case StudentBookingEffectPendingPaymentConflict():
            showErrorMessage(
              message: l10n.studentBookingErrorPendingPaymentExists,
            );
            _resumePendingPayment(context);
          case StudentBookingEffectActionFailed(:final failure):
            showErrorMessage(
              message: CoreFailureMessageMapper.messageFor(failure, l10n),
            );
          case StudentBookingEffectNavigateToSlots():
          case StudentBookingEffectNavigateToReview():
            break;
        }
        context.read<StudentBookingCubit>().clearEffect();
      },
      child: child,
    );
  }

  /// The student already has a PENDING_PAYMENT booking; look it up locally
  /// and resume the payment screen for it instead of leaving them stranded.
  Future<void> _resumePendingPayment(BuildContext context) async {
    final result = await getIt<GetPendingStudentBookingHoldUseCase>()();
    if (!context.mounted) return;

    final hold = result.fold((_) => null, (hold) => hold);
    if (hold == null) {
      StudentBookingNavigation.goHome(context: context);
      return;
    }

    StudentPaymentNavigation.goToPayment(
      context: context,
      args: StudentPaymentHoldArgs(
        bookingId: hold.booking.id,
        depositAmount: hold.depositAmount,
        receiverName: hold.receiverName,
        lockedUntil: hold.lockedUntil,
      ),
    );
  }
}
