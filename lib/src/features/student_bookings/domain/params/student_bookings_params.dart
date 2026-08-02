import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';

abstract final class StudentBookingsPagination {
  static const int defaultLimit = 20;
  static const int maxLimit = 50;
}

class LoadStudentBookingsParams extends Equatable {
  LoadStudentBookingsParams({
    this.bookingStatus,
    this.search,
    this.page = 1,
    int limit = StudentBookingsPagination.defaultLimit,
  }) : limit = limit.clamp(1, StudentBookingsPagination.maxLimit);

  final StudentBookingStatus? bookingStatus;
  final String? search;
  final int page;
  final int limit;

  @override
  List<Object?> get props => [bookingStatus, search, page, limit];
}

class CancelStudentBookingParams extends Equatable {
  const CancelStudentBookingParams({
    required this.bookingId,
    required this.cancellationReason,
  });

  final int bookingId;
  final String cancellationReason;

  @override
  List<Object?> get props => [bookingId, cancellationReason];
}
