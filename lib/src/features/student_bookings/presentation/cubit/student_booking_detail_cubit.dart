import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/utils/future_either_timeout.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/failures/student_bookings_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/use_cases/student_bookings_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';

part 'student_booking_detail_cubit.freezed.dart';
part 'student_booking_detail_state.dart';
part 'student_booking_detail_effect.dart';

@injectable
class StudentBookingDetailCubit
    extends
        AppCoreCoreCubit<
          StudentBookingDetailState,
          StudentBookingDetailEntity
        > {
  StudentBookingDetailCubit(
    this._loadDetailUseCase,
    this._cancelBookingUseCase,
    this._studentBookingRepository,
  ) : super(const StudentBookingDetailState());

  final LoadStudentBookingDetailUseCase _loadDetailUseCase;
  final CancelStudentBookingUseCase _cancelBookingUseCase;

  /// Reused from the booking-creation feature purely to read/clear the
  /// locally cached ShamCash hold when resuming payment or cancelling.
  final StudentBookingRepository _studentBookingRepository;

  int _loadGeneration = 0;

  @override
  ApiState<StudentBookingDetailEntity> getApiState(
    StudentBookingDetailState state,
  ) => state.apiState;

  @override
  StudentBookingDetailState setApiState(
    StudentBookingDetailState state,
    ApiState<StudentBookingDetailEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load(int bookingId, {bool silent = false}) async {
    final generation = ++_loadGeneration;
    emit(
      state.copyWith(
        bookingId: bookingId,
        apiState: silent ? state.apiState : const ApiState.loading(),
      ),
    );

    final result = await _loadDetailUseCase(bookingId);
    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          apiState: ApiState.failed(
            failure,
            retryFunction: () => load(bookingId),
          ),
        ),
      ),
      (detail) => emit(state.copyWith(apiState: ApiState.succeeded(detail))),
    );
  }

  Future<void> refresh() async {
    final bookingId = state.bookingId;
    if (bookingId == null) return;
    await load(bookingId, silent: true);
  }

  /// Attempts to resume the ShamCash payment for a PENDING_PAYMENT booking.
  Future<void> resumePendingPayment() async {
    final detail = state.apiState.maybeWhen(
      succeeded: (value) => value,
      orElse: () => null,
    );
    if (detail == null) return;

    final holdResult = await _studentBookingRepository.getPendingHold();
    final hold = holdResult.fold((_) => null, (value) => value);

    if (hold == null || hold.booking.id != detail.booking.id) {
      emit(
        state.copyWith(
          effect: const StudentBookingDetailEffectPendingPaymentNoHold(),
        ),
      );
      return;
    }

    if (hold.lockedUntil.isAfter(DateTime.now())) {
      emit(
        state.copyWith(
          effect: StudentBookingDetailEffectNavigateToPayment(
            StudentPaymentHoldArgs(
              bookingId: hold.booking.id,
              depositAmount: hold.depositAmount,
              receiverName: hold.receiverName,
              lockedUntil: hold.lockedUntil,
            ),
          ),
        ),
      );
      return;
    }

    await _studentBookingRepository.clearPendingHold();
    emit(state.copyWith(effect: const StudentBookingDetailEffectHoldExpired()));
  }

  Future<void> cancel(String rawReason) async {
    final bookingId = state.bookingId;
    if (bookingId == null || state.isCancelling) return;

    final validation = StudentBookingsCancelReasonRules.validateReason(
      rawReason,
    );
    final reason = validation.fold((failure) {
      emit(
        state.copyWith(effect: StudentBookingDetailEffectActionFailed(failure)),
      );
      return null;
    }, (value) => value);
    if (reason == null) return;

    emit(state.copyWith(isCancelling: true, effect: null));

    final result = await FutureEitherTimeout.guard(
      _cancelBookingUseCase(
        CancelStudentBookingParams(
          bookingId: bookingId,
          cancellationReason: reason,
        ),
      ),
    );

    final cancelFailure = result.fold((failure) => failure, (_) => null);
    if (cancelFailure != null) {
      emit(
        state.copyWith(
          isCancelling: false,
          effect: StudentBookingDetailEffectActionFailed(cancelFailure),
        ),
      );
      return;
    }

    await _clearHoldIfMatches(bookingId);

    final detailResult = await _loadDetailUseCase(bookingId);
    detailResult.fold(
      (failure) => emit(
        state.copyWith(
          isCancelling: false,
          apiState: ApiState.failed(
            failure,
            retryFunction: () => load(bookingId),
          ),
        ),
      ),
      (detail) => emit(
        state.copyWith(
          isCancelling: false,
          apiState: ApiState.succeeded(detail),
          effect: const StudentBookingDetailEffectCancelSucceeded(),
        ),
      ),
    );
  }

  Future<void> _clearHoldIfMatches(int bookingId) async {
    final holdResult = await _studentBookingRepository.getPendingHold();
    final hold = holdResult.fold((_) => null, (value) => value);
    if (hold != null && hold.booking.id == bookingId) {
      await _studentBookingRepository.clearPendingHold();
    }
  }

  void clearEffect() {
    emit(state.copyWith(effect: null));
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
