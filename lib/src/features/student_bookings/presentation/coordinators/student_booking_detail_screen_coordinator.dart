import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_booking_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_navigation.dart';

class StudentBookingDetailScreenCoordinator extends StatelessWidget {
  const StudentBookingDetailScreenCoordinator({
    super.key,
    required this.bookingId,
    required this.child,
  });

  final int bookingId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return RouteResumedRefresh(
      onInitialLoad: () =>
          context.read<StudentBookingDetailCubit>().load(bookingId),
      onResumed: () => context.read<StudentBookingDetailCubit>().refresh(),
      child: BlocListener<StudentBookingDetailCubit, StudentBookingDetailState>(
        listenWhen: (previous, current) =>
            previous.effect != current.effect && current.effect != null,
        listener: (context, state) {
          final effect = state.effect;
          if (effect == null) return;

          switch (effect) {
            case StudentBookingDetailEffectNavigateToPayment(:final args):
              StudentPaymentNavigation.pushPayment(
                context: context,
                args: args,
              );
            case StudentBookingDetailEffectPendingPaymentNoHold():
              showErrorMessage(
                message: l10n.studentBookingDetailPendingPaymentNoHoldMessage,
              );
            case StudentBookingDetailEffectHoldExpired():
              _showHoldExpiredMessage(context, l10n);
            case StudentBookingDetailEffectCancelSucceeded():
              showSuccessMessage(
                message: l10n.studentBookingDetailCancelSuccessMessage,
              );
            case StudentBookingDetailEffectActionFailed(:final failure):
              showErrorMessage(
                message: CoreFailureMessageMapper.messageFor(failure, l10n),
              );
          }
          context.read<StudentBookingDetailCubit>().clearEffect();
        },
        child: child,
      ),
    );
  }

  void _showHoldExpiredMessage(BuildContext context, AppLocalizations l10n) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.studentBookingDetailHoldExpiredMessage),
          action: SnackBarAction(
            label: l10n.studentBookingDetailHoldExpiredCta,
            onPressed: () =>
                StudentBookingNavigation.pushPreferences(context: context),
          ),
        ),
      );
  }
}
