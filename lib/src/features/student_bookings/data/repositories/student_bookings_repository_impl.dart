import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/cache/app_ttl_cache.dart';
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

  final _listCache = AppTtlCache<StudentBookingsPageEntity>(
    ttl: const Duration(seconds: 60),
  );
  final _detailCache = AppTtlCache<StudentBookingDetailEntity>(
    ttl: const Duration(seconds: 60),
  );

  @override
  FutureEither<StudentBookingsPageEntity> getBookings(
    LoadStudentBookingsParams params, {
    bool forceRefresh = false,
  }) async {
    final key = _listKey(params);
    if (!forceRefresh) {
      final cached = _listCache.getFresh(key);
      if (cached != null) return right(cached);
    }

    final response = await _remoteDataSource.fetchBookings(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (page) {
        _listCache.set(key, page);
        return right(page);
      },
    );
  }

  @override
  FutureEither<StudentBookingDetailEntity> getBookingDetail(
    int bookingId, {
    bool forceRefresh = false,
  }) async {
    final key = _detailKey(bookingId);
    if (!forceRefresh) {
      final cached = _detailCache.getFresh(key);
      if (cached != null) return right(cached);
    }

    final response = await _remoteDataSource.fetchBookingDetail(bookingId);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (detail) {
        _detailCache.set(key, detail);
        return right(detail);
      },
    );
  }

  @override
  FutureEither<void> cancelBooking(CancelStudentBookingParams params) async {
    final response = await _remoteDataSource.cancelBooking(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (value) {
        invalidateCache();
        return right(value);
      },
    );
  }

  @override
  void invalidateCache() {
    _listCache.invalidate();
    _detailCache.invalidate();
  }

  String _listKey(LoadStudentBookingsParams params) {
    return 'list:'
        '${params.bookingStatus?.name ?? 'all'}:'
        '${params.search ?? ''}:'
        '${params.page}:'
        '${params.limit}';
  }

  String _detailKey(int bookingId) => 'detail:$bookingId';
}
