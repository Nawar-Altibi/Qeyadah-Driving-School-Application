import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/use_cases/notifications_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/use_cases/student_booking_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/use_cases/student_bookings_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/data/repositories/student_home_repository_impl.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

class MockStudentBookingsRepository extends Mock
    implements StudentBookingsRepository {}

class MockStudentBookingRepository extends Mock
    implements StudentBookingRepository {}

class MockNotificationsRepository extends Mock
    implements NotificationsRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(LoadStudentBookingsParams());
  });

  late MockStudentBookingsRepository bookingsRepository;
  late MockStudentBookingRepository bookingRepository;
  late MockNotificationsRepository notificationsRepository;
  late StudentHomeRepositoryImpl repository;

  setUp(() {
    bookingsRepository = MockStudentBookingsRepository();
    bookingRepository = MockStudentBookingRepository();
    notificationsRepository = MockNotificationsRepository();
    repository = StudentHomeRepositoryImpl(
      LoadStudentBookingsUseCase(bookingsRepository),
      LoadStudentBookingDetailUseCase(bookingsRepository),
      GetPendingStudentBookingHoldUseCase(bookingRepository),
      LoadUnreadNotificationsCountUseCase(notificationsRepository),
    );

    when(
      () => notificationsRepository.getUnreadCount(forceRefresh: any(named: 'forceRefresh')),
    ).thenAnswer((_) async => right(0));
    when(
      () => bookingRepository.getPendingHold(),
    ).thenAnswer((_) async => right(null));
    when(() => bookingsRepository.getBookings(any(), forceRefresh: any(named: 'forceRefresh'))).thenAnswer(
      (_) async => right(
        const StudentBookingsPageEntity(
          items: [],
          total: 0,
          page: 1,
          limit: 50,
          totalPages: 0,
        ),
      ),
    );
  });

  StudentBookingListItemEntity bookedItem({
    required String id,
    required DateTime date,
    required String startTime,
    required String endTime,
    String instructorName = 'Instructor',
    TrainingType trainingType = TrainingType.manual,
    VehicleSource vehicleSource = VehicleSource.schoolCar,
  }) {
    return StudentBookingListItemEntity(
      id: id,
      studentName: 'Student',
      instructorName: instructorName,
      dayName: 'Sunday',
      startTime: startTime,
      endTime: endTime,
      bookingStatus: StudentBookingStatus.booked,
      paymentStatus: StudentPaymentStatus.depositPaid,
      trainingType: trainingType,
      vehicleSource: vehicleSource,
      date: date,
    );
  }

  test(
    'picks the earliest future booked lesson and maps gender from detail',
    () async {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final later = DateTime.now().add(const Duration(days: 3));
      final day = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
      final laterDay = DateTime(later.year, later.month, later.day);

      when(() => bookingsRepository.getBookings(any(), forceRefresh: any(named: 'forceRefresh'))).thenAnswer((
        invocation,
      ) async {
        final params =
            invocation.positionalArguments.first as LoadStudentBookingsParams;
        if (params.bookingStatus == StudentBookingStatus.booked) {
          return right(
            StudentBookingsPageEntity(
              items: [
                bookedItem(
                  id: '20',
                  date: laterDay,
                  startTime: '09:00',
                  endTime: '10:30',
                  instructorName: 'Later Instructor',
                ),
                bookedItem(
                  id: '10',
                  date: day,
                  startTime: '11:00',
                  endTime: '12:30',
                  instructorName: 'Sooner Instructor',
                  trainingType: TrainingType.automatic,
                ),
              ],
              total: 2,
              page: 1,
              limit: 50,
              totalPages: 1,
            ),
          );
        }
        return right(
          const StudentBookingsPageEntity(
            items: [],
            total: 0,
            page: 1,
            limit: 1,
            totalPages: 0,
          ),
        );
      });

      when(() => bookingsRepository.getBookingDetail(10, forceRefresh: any(named: 'forceRefresh'))).thenAnswer(
        (_) async => right(
          StudentBookingDetailEntity(
            booking: StudentBookingDetailBookingEntity(
              id: 10,
              bookingStatus: StudentBookingStatus.booked,
              paymentStatus: StudentPaymentStatus.depositPaid,
              trainingType: TrainingType.automatic,
              vehicleSource: VehicleSource.schoolCar,
              date: day,
              startTime: '11:00',
              endTime: '12:30',
            ),
            student: const StudentBookingDetailPersonEntity(
              id: 1,
              name: 'Student',
            ),
            instructor: const StudentBookingDetailPersonEntity(
              id: 4,
              name: 'Sooner Instructor',
              gender: InstructorGender.female,
            ),
            charges: const [],
          ),
        ),
      );

      final result = await repository.loadDashboard(
        const LoadStudentHomeParams(),
      );
      final dashboard = result.getOrElse(
        (_) => throw StateError('expected right'),
      );

      expect(dashboard.nextLesson, isNotNull);
      expect(dashboard.nextLesson!.instructorName, 'Sooner Instructor');
      expect(dashboard.nextLesson!.instructorIsFemale, isTrue);
      expect(dashboard.nextLesson!.isAutomatic, isTrue);
      expect(dashboard.nextLesson!.status, StudentHomeLessonStatus.confirmed);
    },
  );

  test('returns null nextLesson when there are no future bookings', () async {
    final result = await repository.loadDashboard(
      const LoadStudentHomeParams(),
    );
    final dashboard = result.getOrElse(
      (_) => throw StateError('expected right'),
    );
    expect(dashboard.nextLesson, isNull);
  });

  test(
    'maps an unexpired local hold into a resumable pending payment',
    () async {
      final lockedUntil = DateTime.now().add(
        const Duration(minutes: 12, seconds: 30),
      );
      when(() => bookingRepository.getPendingHold()).thenAnswer(
        (_) async => right(
          StudentBookingHoldEntity(
            booking: const StudentBookingEntity(
              id: 55,
              bookingStatus: StudentBookingStatus.pendingPayment,
              paymentStatus: StudentPaymentStatus.pendingDeposit,
            ),
            paymentRequired: true,
            depositAmount: '2000.00',
            lockedUntil: lockedUntil,
            receiverName: 'Qeyadah ShamCash',
          ),
        ),
      );

      final result = await repository.loadDashboard(
        const LoadStudentHomeParams(),
      );
      final dashboard = result.getOrElse(
        (_) => throw StateError('expected right'),
      );

      expect(dashboard.pendingPayment, isNotNull);
      expect(dashboard.pendingPayment!.canResumePayment, isTrue);
      expect(dashboard.pendingPayment!.bookingId, 55);
      expect(dashboard.pendingPayment!.depositAmount, '2000.00');
      expect(dashboard.pendingPayment!.receiverName, 'Qeyadah ShamCash');
      expect(
        dashboard.pendingPayment!.remainingMinutes,
        greaterThanOrEqualTo(11),
      );
    },
  );

  test('ignores an expired local hold', () async {
    when(() => bookingRepository.getPendingHold()).thenAnswer(
      (_) async => right(
        StudentBookingHoldEntity(
          booking: const StudentBookingEntity(
            id: 55,
            bookingStatus: StudentBookingStatus.pendingPayment,
            paymentStatus: StudentPaymentStatus.pendingDeposit,
          ),
          paymentRequired: true,
          depositAmount: '2000.00',
          lockedUntil: DateTime.now().subtract(const Duration(minutes: 1)),
          receiverName: 'Qeyadah ShamCash',
        ),
      ),
    );

    final result = await repository.loadDashboard(
      const LoadStudentHomeParams(),
    );
    final dashboard = result.getOrElse(
      (_) => throw StateError('expected right'),
    );
    expect(dashboard.pendingPayment, isNull);
  });

  test(
    'falls back to a non-resumable pending banner from server bookings',
    () async {
      when(() => bookingsRepository.getBookings(any(), forceRefresh: any(named: 'forceRefresh'))).thenAnswer((
        invocation,
      ) async {
        final params =
            invocation.positionalArguments.first as LoadStudentBookingsParams;
        if (params.bookingStatus == StudentBookingStatus.pendingPayment) {
          return right(
            StudentBookingsPageEntity(
              items: [
                bookedItem(
                  id: '99',
                  date: DateTime.now().add(const Duration(days: 2)),
                  startTime: '09:00',
                  endTime: '10:30',
                ).copyWithStatus(StudentBookingStatus.pendingPayment),
              ],
              total: 1,
              page: 1,
              limit: 1,
              totalPages: 1,
            ),
          );
        }
        return right(
          const StudentBookingsPageEntity(
            items: [],
            total: 0,
            page: 1,
            limit: 50,
            totalPages: 0,
          ),
        );
      });

      final result = await repository.loadDashboard(
        const LoadStudentHomeParams(),
      );
      final dashboard = result.getOrElse(
        (_) => throw StateError('expected right'),
      );

      expect(dashboard.pendingPayment, isNotNull);
      expect(dashboard.pendingPayment!.canResumePayment, isFalse);
    },
  );

  test('sets hasUnreadNotifications from unread count', () async {
    when(
      () => notificationsRepository.getUnreadCount(forceRefresh: any(named: 'forceRefresh')),
    ).thenAnswer((_) async => right(3));

    final result = await repository.loadDashboard(
      const LoadStudentHomeParams(),
    );
    final dashboard = result.getOrElse(
      (_) => throw StateError('expected right'),
    );
    expect(dashboard.hasUnreadNotifications, isTrue);
  });

  test('soft-fails unread count errors to false', () async {
    when(
      () => notificationsRepository.getUnreadCount(forceRefresh: any(named: 'forceRefresh')),
    ).thenAnswer((_) async => left(const UnknownFailure()));

    final result = await repository.loadDashboard(
      const LoadStudentHomeParams(),
    );
    final dashboard = result.getOrElse(
      (_) => throw StateError('expected right'),
    );
    expect(dashboard.hasUnreadNotifications, isFalse);
  });
}

extension on StudentBookingListItemEntity {
  StudentBookingListItemEntity copyWithStatus(StudentBookingStatus status) {
    return StudentBookingListItemEntity(
      id: id,
      studentName: studentName,
      instructorName: instructorName,
      dayName: dayName,
      startTime: startTime,
      endTime: endTime,
      bookingStatus: status,
      paymentStatus: paymentStatus,
      trainingType: trainingType,
      vehicleSource: vehicleSource,
      vehiclePlate: vehiclePlate,
      date: date,
      remainingAmount: remainingAmount,
    );
  }
}
