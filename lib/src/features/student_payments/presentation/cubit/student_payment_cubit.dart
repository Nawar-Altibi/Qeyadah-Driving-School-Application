import 'dart:async';

import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/utils/future_either_timeout.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/entities/student_payment_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/params/student_payment_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/use_cases/student_payment_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

part 'student_payment_cubit.freezed.dart';
part 'student_payment_state.dart';
part 'student_payment_effect.dart';

@injectable
class StudentPaymentCubit extends AppCoreCubit<StudentPaymentState> {
  StudentPaymentCubit(this._confirmPaymentUseCase)
    : super(const StudentPaymentState());

  final ConfirmStudentPaymentUseCase _confirmPaymentUseCase;
  Timer? _countdownTimer;

  void initialize(StudentPaymentHoldArgs args) {
    _countdownTimer?.cancel();
    final remaining = _remaining(args.lockedUntil);
    emit(
      state.copyWith(
        args: args,
        remaining: remaining,
        isExpired: remaining <= Duration.zero,
      ),
    );
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _tick(),
    );
  }

  void _tick() {
    final args = state.args;
    if (args == null) return;
    final remaining = _remaining(args.lockedUntil);
    emit(
      state.copyWith(
        remaining: remaining,
        isExpired: remaining <= Duration.zero,
      ),
    );
    if (remaining <= Duration.zero) {
      _countdownTimer?.cancel();
    }
  }

  Duration _remaining(DateTime lockedUntil) {
    final diff = lockedUntil.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  Future<void> confirmPayment(String rawTransactionId) async {
    final args = state.args;
    if (args == null || state.isExpired || state.isSubmitting) return;

    final validationResult = ShamCashValidationRules.validateTransactionId(
      rawTransactionId,
    );
    final transactionId = validationResult.fold<String?>((failure) {
      emit(state.copyWith(effect: StudentPaymentEffectActionFailed(failure)));
      return null;
    }, (value) => value);
    if (transactionId == null) return;

    emit(state.copyWith(isSubmitting: true, effect: null));

    final result = await FutureEitherTimeout.guard(
      _confirmPaymentUseCase(
        ConfirmStudentPaymentParams(
          bookingId: args.bookingId,
          transactionId: transactionId,
        ),
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isSubmitting: false,
          effect: StudentPaymentEffectActionFailed(failure),
        ),
      ),
      (confirmation) {
        _countdownTimer?.cancel();
        emit(
          state.copyWith(
            isSubmitting: false,
            effect: StudentPaymentEffectPaymentConfirmed(confirmation),
          ),
        );
      },
    );
  }

  void clearEffect() {
    emit(state.copyWith(effect: null));
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
