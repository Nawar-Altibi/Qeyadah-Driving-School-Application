import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/data/data_sources/student_bookings_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart';

@LazySingleton(as: StudentBookingsRepository)
class StudentBookingsRepositoryImpl implements StudentBookingsRepository {
  StudentBookingsRepositoryImpl(this._remoteDataSource);

  final StudentBookingsRemoteDataSource _remoteDataSource;

  @override
  FutureEither<StudentBookingsPageEntity> getBookings(
    LoadStudentBookingsParams params,
  ) async {
    final response = await _remoteDataSource.fetchBookings(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<StudentBookingDetailEntity> getBookingDetail(
    int bookingId,
  ) async {
    final response = await _remoteDataSource.fetchBookingDetail(bookingId);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<void> cancelBooking(CancelStudentBookingParams params) async {
    final response = await _remoteDataSource.cancelBooking(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }
}
