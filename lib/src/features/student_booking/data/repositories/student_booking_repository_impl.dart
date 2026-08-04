import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/data/data_sources/student_booking_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/data/data_sources/student_booking_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/failures/student_booking_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart';

@LazySingleton(as: StudentBookingRepository)
class StudentBookingRepositoryImpl implements StudentBookingRepository {
  StudentBookingRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._bookingsRepository,
  );

  final StudentBookingRemoteDataSource _remoteDataSource;
  final StudentBookingLocalDataSource _localDataSource;
  final StudentBookingsRepository _bookingsRepository;

  @override
  FutureEither<StudentAvailableSlotsPageEntity> getAvailableSlots(
    LoadAvailableSlotsParams params,
  ) async {
    final response = await _remoteDataSource.fetchAvailableSlots(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<StudentBookingHoldEntity> createBooking(
    CreateStudentBookingParams params,
  ) async {
    final response = await _remoteDataSource.createBooking(params);
    return response.fold(
      (failure) async => left(_mapCreateBookingFailure(failure)),
      (hold) async {
        await _localDataSource.saveHold(hold);
        _bookingsRepository.invalidateCache();
        return right(hold);
      },
    );
  }

  @override
  FutureEither<StudentBookingHoldEntity?> getPendingHold() {
    return _localDataSource.readHold();
  }

  @override
  FutureEither<void> clearPendingHold() {
    return _localDataSource.clearHold();
  }

  /// A 409 on booking creation either means the slot was just taken by
  /// someone else, or the student already has a PENDING_PAYMENT booking.
  /// The backend does not expose a structured reason, so it is inferred
  /// from the message text.
  Failure _mapCreateBookingFailure(NetworkFailure failure) {
    if (failure is ConflictFailure) {
      final normalizedMessage = failure.message.toLowerCase();
      final isPendingPaymentConflict = normalizedMessage.contains('pending');
      return StudentBookingConflictFailure(
        reason: isPendingPaymentConflict
            ? StudentBookingConflictReason.pendingPaymentExists
            : StudentBookingConflictReason.slotUnavailable,
        message: failure.message,
      );
    }
    return NetworkFailureMapper.toDomainFailure(failure);
  }
}
