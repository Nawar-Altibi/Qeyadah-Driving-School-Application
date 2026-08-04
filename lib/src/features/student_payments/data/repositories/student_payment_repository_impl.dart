import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/data/data_sources/student_payment_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/entities/student_payment_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/params/student_payment_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/repositories/student_payment_repository.dart';

@LazySingleton(as: StudentPaymentRepository)
class StudentPaymentRepositoryImpl implements StudentPaymentRepository {
  StudentPaymentRepositoryImpl(
    this._remoteDataSource,
    this._bookingRepository,
    this._bookingsRepository,
  );

  final StudentPaymentRemoteDataSource _remoteDataSource;
  final StudentBookingRepository _bookingRepository;
  final StudentBookingsRepository _bookingsRepository;

  @override
  FutureEither<StudentPaymentConfirmationEntity> confirmPayment(
    ConfirmStudentPaymentParams params,
  ) async {
    final response = await _remoteDataSource.confirmPayment(params);
    return response.fold(
      (failure) async => left(NetworkFailureMapper.toDomainFailure(failure)),
      (confirmation) async {
        await _bookingRepository.clearPendingHold();
        _bookingsRepository.invalidateCache();
        return right(confirmation);
      },
    );
  }
}
