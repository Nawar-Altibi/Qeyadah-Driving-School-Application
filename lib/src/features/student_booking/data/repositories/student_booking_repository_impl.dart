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
        if (hold.paymentRequired) {
          await _localDataSource.saveHold(hold);
        } else {
          await _localDataSource.clearHold();
        }
        _bookingsRepository.invalidateCache();
        return right(hold);
      },
    );
  }

  @override
  FutureEither<StudentBookingCreditEntity> getMyCredit() async {
    final response = await _remoteDataSource.fetchMyCredit();
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
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

  /// A 409 on booking creation may mean: a pending-payment hold already
  /// exists, the chosen instructor/vehicle slot was taken, or another
  /// student-schedule conflict (e.g. overlapping booking with a different
  /// instructor). The backend does not expose a structured reason, so it is
  /// inferred from the message text; unknown conflicts keep the backend copy.
  Failure _mapCreateBookingFailure(NetworkFailure failure) {
    if (failure is ConflictFailure) {
      return StudentBookingConflictFailure(
        reason: _inferCreateConflictReason(failure.message),
        message: failure.message,
      );
    }
    return NetworkFailureMapper.toDomainFailure(failure);
  }

  StudentBookingConflictReason _inferCreateConflictReason(String message) {
    final normalized = message.toLowerCase();
    if (normalized.contains('pending')) {
      return StudentBookingConflictReason.pendingPaymentExists;
    }

    const studentTimeConflictHints = <String>[
      'already has another booking',
      'exact time',
      'same time',
      'overlapping booking',
      'في نفس الوقت',
      'حجز آخر',
    ];
    for (final hint in studentTimeConflictHints) {
      if (normalized.contains(hint.toLowerCase())) {
        return StudentBookingConflictReason.studentTimeConflict;
      }
    }

    const slotUnavailableHints = <String>[
      'not available',
      'conflicts with an existing reservation',
      'no available vehicle',
      'غير متاح',
      'تم حجز',
      'محجوز',
    ];
    for (final hint in slotUnavailableHints) {
      if (normalized.contains(hint.toLowerCase())) {
        return StudentBookingConflictReason.slotUnavailable;
      }
    }
    return StudentBookingConflictReason.unspecifiedConflict;
  }
}
