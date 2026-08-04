import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/cache/app_ttl_cache.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/use_cases/notifications_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/use_cases/student_booking_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/use_cases/student_bookings_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

@LazySingleton(as: StudentHomeRepository)
class StudentHomeRepositoryImpl implements StudentHomeRepository {
  StudentHomeRepositoryImpl(
    this._loadStudentBookings,
    this._loadStudentBookingDetail,
    this._getPendingHold,
    this._loadUnreadCount,
  );

  final LoadStudentBookingsUseCase _loadStudentBookings;
  final LoadStudentBookingDetailUseCase _loadStudentBookingDetail;
  final GetPendingStudentBookingHoldUseCase _getPendingHold;
  final LoadUnreadNotificationsCountUseCase _loadUnreadCount;

  static const _dashboardKey = 'dashboard';
  final _dashboardCache = AppTtlCache<StudentHomeDashboardEntity>(
    ttl: const Duration(seconds: 60),
  );

  static const _quickActions = [
    StudentHomeQuickActionType.newBooking,
    StudentHomeQuickActionType.myBookings,
    StudentHomeQuickActionType.certificateRequest,
    StudentHomeQuickActionType.theorySimulation,
  ];

  @override
  FutureEither<StudentHomeDashboardEntity> loadDashboard(
    LoadStudentHomeParams params,
  ) async {
    final forceRefresh = params.forceRefresh;
    if (!forceRefresh) {
      final cached = _dashboardCache.getFresh(_dashboardKey);
      if (cached != null) return right(cached);
    }

    final now = DateTime.now();

    final bookedResult = await _loadStudentBookings(
      LoadStudentBookingsParams(
        bookingStatus: StudentBookingStatus.booked,
        limit: 50,
      ),
      forceRefresh: forceRefresh,
    );
    final bookedPage = bookedResult.fold<StudentBookingsPageEntity?>(
      (_) => null,
      (page) => page,
    );
    if (bookedPage == null) {
      return left(
        bookedResult.fold((failure) => failure, (_) => const UnknownFailure()),
      );
    }

    final nextLesson = await _resolveNextLesson(
      bookedPage.items,
      now,
      forceRefresh: forceRefresh,
    );

    final pendingPayment = await _resolvePendingPayment(
      now,
      forceRefresh: forceRefresh,
    );

    final unreadResult = await _loadUnreadCount(forceRefresh: forceRefresh);
    final hasUnread = unreadResult.fold((_) => false, (count) => count > 0);

    final dashboard = StudentHomeDashboardEntity(
      referenceDate: now,
      hasUnreadNotifications: hasUnread,
      nextLesson: nextLesson,
      pendingPayment: pendingPayment,
      quickActions: _quickActions,
    );
    _dashboardCache.set(_dashboardKey, dashboard);
    return right(dashboard);
  }

  @override
  void invalidateCache() {
    _dashboardCache.invalidate(_dashboardKey);
  }

  Future<StudentHomeNextLessonEntity?> _resolveNextLesson(
    List<StudentBookingListItemEntity> items,
    DateTime now, {
    bool forceRefresh = false,
  }) async {
    StudentBookingListItemEntity? earliest;
    DateTime? earliestStart;

    for (final item in items) {
      final startsAt = _combineDateAndTime(item.date, item.startTime);
      if (startsAt == null) continue;
      if (!startsAt.isAfter(now)) continue;
      if (earliestStart == null || startsAt.isBefore(earliestStart)) {
        earliest = item;
        earliestStart = startsAt;
      }
    }

    if (earliest == null || earliestStart == null) {
      return null;
    }

    final bookingId = int.tryParse(earliest.id);
    if (bookingId == null) {
      return _nextLessonFromListItem(earliest, earliestStart);
    }

    final detailResult = await _loadStudentBookingDetail(
      bookingId,
      forceRefresh: forceRefresh,
    );
    return detailResult.fold(
      (_) => _nextLessonFromListItem(earliest!, earliestStart!),
      (detail) => _nextLessonFromDetail(detail, earliest!, earliestStart!),
    );
  }

  StudentHomeNextLessonEntity _nextLessonFromListItem(
    StudentBookingListItemEntity item,
    DateTime startsAt,
  ) {
    final endsAt =
        _combineDateAndTime(item.date, item.endTime) ??
        startsAt.add(const Duration(minutes: 90));
    return StudentHomeNextLessonEntity(
      startsAt: startsAt,
      endsAt: endsAt,
      instructorName: item.instructorName,
      instructorIsFemale: false,
      isAutomatic: item.trainingType == TrainingType.automatic,
      isSchoolVehicle: item.vehicleSource != VehicleSource.studentCar,
      status: StudentHomeLessonStatus.confirmed,
    );
  }

  StudentHomeNextLessonEntity _nextLessonFromDetail(
    StudentBookingDetailEntity detail,
    StudentBookingListItemEntity listItem,
    DateTime startsAt,
  ) {
    final booking = detail.booking;
    final endsAt =
        _combineDateAndTime(booking.date ?? listItem.date, booking.endTime) ??
        _combineDateAndTime(listItem.date, listItem.endTime) ??
        startsAt.add(const Duration(minutes: 90));
    final trainingType = booking.trainingType ?? listItem.trainingType;
    final vehicleSource = booking.vehicleSource ?? listItem.vehicleSource;

    return StudentHomeNextLessonEntity(
      startsAt: startsAt,
      endsAt: endsAt,
      instructorName: detail.instructor.name.isNotEmpty
          ? detail.instructor.name
          : listItem.instructorName,
      instructorIsFemale: detail.instructor.gender == InstructorGender.female,
      isAutomatic: trainingType == TrainingType.automatic,
      isSchoolVehicle: vehicleSource != VehicleSource.studentCar,
      status: StudentHomeLessonStatus.confirmed,
    );
  }

  Future<StudentHomePendingPaymentEntity?> _resolvePendingPayment(
    DateTime now, {
    bool forceRefresh = false,
  }) async {
    final holdResult = await _getPendingHold();
    final hold = holdResult.fold<StudentBookingHoldEntity?>(
      (_) => null,
      (value) => value,
    );

    if (hold != null) {
      final remaining = hold.lockedUntil.difference(now);
      if (!remaining.isNegative) {
        final totalSeconds = remaining.inSeconds;
        return StudentHomePendingPaymentEntity(
          remainingMinutes: totalSeconds ~/ 60,
          remainingSeconds: totalSeconds % 60,
          bookingId: hold.booking.id,
          depositAmount: hold.depositAmount,
          receiverName: hold.receiverName,
          lockedUntil: hold.lockedUntil,
        );
      }
    }

    final pendingResult = await _loadStudentBookings(
      LoadStudentBookingsParams(
        bookingStatus: StudentBookingStatus.pendingPayment,
        limit: 1,
      ),
      forceRefresh: forceRefresh,
    );

    return pendingResult.fold((_) => null, (page) {
      if (page.items.isEmpty) return null;
      return const StudentHomePendingPaymentEntity(
        remainingMinutes: 0,
        remainingSeconds: 0,
      );
    });
  }

  DateTime? _combineDateAndTime(DateTime? date, String? time) {
    if (date == null || time == null || time.trim().isEmpty) return null;
    final parts = time.trim().split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
