import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

/// A single row in the student "My Bookings" list.
class StudentBookingListItemEntity extends Equatable {
  const StudentBookingListItemEntity({
    required this.id,
    required this.studentName,
    required this.instructorName,
    required this.dayName,
    required this.startTime,
    required this.endTime,
    required this.bookingStatus,
    required this.paymentStatus,
    this.trainingType,
    this.vehicleSource,
    this.vehiclePlate,
    this.date,
    this.remainingAmount,
  });

  factory StudentBookingListItemEntity.placeholder({String id = '1'}) {
    final today = DateTime.now();
    return StudentBookingListItemEntity(
      id: id,
      studentName: 'Placeholder Student',
      instructorName: 'Placeholder Instructor',
      trainingType: TrainingType.manual,
      vehicleSource: VehicleSource.schoolCar,
      date: DateTime(today.year, today.month, today.day),
      dayName: 'Saturday',
      startTime: '09:00',
      endTime: '10:00',
      bookingStatus: StudentBookingStatus.booked,
      paymentStatus: StudentPaymentStatus.depositPaid,
      remainingAmount: '500',
    );
  }

  final String id;
  final String studentName;
  final String instructorName;
  final TrainingType? trainingType;
  final VehicleSource? vehicleSource;
  final String? vehiclePlate;
  final DateTime? date;
  final String dayName;
  final String startTime;
  final String endTime;
  final StudentBookingStatus bookingStatus;
  final StudentPaymentStatus paymentStatus;
  final String? remainingAmount;

  bool get isCancellable =>
      bookingStatus == StudentBookingStatus.booked ||
      bookingStatus == StudentBookingStatus.pendingPayment;

  @override
  List<Object?> get props => [
    id,
    studentName,
    instructorName,
    trainingType,
    vehicleSource,
    vehiclePlate,
    date,
    dayName,
    startTime,
    endTime,
    bookingStatus,
    paymentStatus,
    remainingAmount,
  ];
}

/// A page of [StudentBookingListItemEntity], mirroring the backend
/// `{ data, meta }` pagination envelope.
class StudentBookingsPageEntity extends Equatable {
  const StudentBookingsPageEntity({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory StudentBookingsPageEntity.placeholder() {
    return StudentBookingsPageEntity(
      items: [
        StudentBookingListItemEntity.placeholder(),
        StudentBookingListItemEntity.placeholder(id: '2'),
        StudentBookingListItemEntity.placeholder(id: '3'),
      ],
      total: 3,
      page: 1,
      limit: 20,
      totalPages: 1,
    );
  }

  final List<StudentBookingListItemEntity> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  bool get hasMorePages => page < totalPages;

  StudentBookingsPageEntity appendPage(StudentBookingsPageEntity next) {
    return StudentBookingsPageEntity(
      items: [...items, ...next.items],
      total: next.total,
      page: next.page,
      limit: next.limit,
      totalPages: next.totalPages,
    );
  }

  @override
  List<Object?> get props => [items, total, page, limit, totalPages];
}

/// A minimal person reference (student or instructor) embedded in the
/// booking detail response.
class StudentBookingDetailPersonEntity extends Equatable {
  const StudentBookingDetailPersonEntity({
    required this.id,
    required this.name,
    this.phone,
    this.gender,
  });

  factory StudentBookingDetailPersonEntity.placeholder({int id = 1}) {
    return StudentBookingDetailPersonEntity(
      id: id,
      name: 'Placeholder Name',
      phone: '0999000000',
    );
  }

  final int id;
  final String name;
  final String? phone;
  final InstructorGender? gender;

  @override
  List<Object?> get props => [id, name, phone, gender];
}

class StudentBookingDetailVehicleEntity extends Equatable {
  const StudentBookingDetailVehicleEntity({
    required this.id,
    this.source,
    this.plateNumber,
  });

  final int id;
  final VehicleSource? source;
  final String? plateNumber;

  @override
  List<Object?> get props => [id, source, plateNumber];
}

/// The booking resource as returned by the booking detail endpoint.
class StudentBookingDetailBookingEntity extends Equatable {
  const StudentBookingDetailBookingEntity({
    required this.id,
    required this.bookingStatus,
    required this.paymentStatus,
    this.trainingType,
    this.vehicleSource,
    this.date,
    this.dayName,
    this.startTime,
    this.endTime,
    this.lockedUntil,
    this.createdAt,
  });

  final int id;
  final StudentBookingStatus bookingStatus;
  final StudentPaymentStatus paymentStatus;
  final TrainingType? trainingType;
  final VehicleSource? vehicleSource;
  final DateTime? date;
  final String? dayName;
  final String? startTime;
  final String? endTime;
  final DateTime? lockedUntil;
  final DateTime? createdAt;

  bool get isCancellable =>
      bookingStatus == StudentBookingStatus.booked ||
      bookingStatus == StudentBookingStatus.pendingPayment;

  @override
  List<Object?> get props => [
    id,
    bookingStatus,
    paymentStatus,
    trainingType,
    vehicleSource,
    date,
    dayName,
    startTime,
    endTime,
    lockedUntil,
    createdAt,
  ];
}

class StudentBookingChargePaymentEntity extends Equatable {
  const StudentBookingChargePaymentEntity({
    required this.id,
    required this.amountPaid,
    required this.paymentMethod,
    required this.receivedAt,
  });

  final int id;
  final String amountPaid;
  final String paymentMethod;
  final DateTime receivedAt;

  @override
  List<Object?> get props => [id, amountPaid, paymentMethod, receivedAt];
}

class StudentBookingChargeEntity extends Equatable {
  const StudentBookingChargeEntity({
    required this.id,
    required this.chargeReason,
    required this.amountDue,
    required this.chargeStatus,
    required this.payments,
  });

  final int id;
  final String chargeReason;
  final String amountDue;
  final StudentChargeStatus chargeStatus;
  final List<StudentBookingChargePaymentEntity> payments;

  /// Sum of all payments recorded against this charge.
  double get totalPaid => StudentBookingAmountCalculator.sumPayments(payments);

  /// `amountDue - totalPaid`, parsed carefully from backend strings.
  double get remaining =>
      StudentBookingAmountCalculator.computeRemaining(amountDue, payments);

  @override
  List<Object?> get props => [
    id,
    chargeReason,
    amountDue,
    chargeStatus,
    payments,
  ];
}

/// The full aggregate returned by `GET student/bookings/:id`.
class StudentBookingDetailEntity extends Equatable {
  const StudentBookingDetailEntity({
    required this.booking,
    required this.student,
    required this.instructor,
    required this.charges,
    this.vehicle,
  });

  factory StudentBookingDetailEntity.placeholder() {
    return StudentBookingDetailEntity(
      booking: const StudentBookingDetailBookingEntity(
        id: 1,
        bookingStatus: StudentBookingStatus.booked,
        paymentStatus: StudentPaymentStatus.depositPaid,
        trainingType: TrainingType.manual,
        vehicleSource: VehicleSource.schoolCar,
        dayName: 'Saturday',
        startTime: '09:00',
        endTime: '10:00',
      ),
      student: StudentBookingDetailPersonEntity.placeholder(),
      instructor: StudentBookingDetailPersonEntity.placeholder(id: 2),
      vehicle: const StudentBookingDetailVehicleEntity(
        id: 1,
        source: VehicleSource.schoolCar,
        plateNumber: '12345',
      ),
      charges: [
        StudentBookingChargeEntity(
          id: 1,
          chargeReason: 'Deposit',
          amountDue: '1000',
          chargeStatus: StudentChargeStatus.partiallyPaid,
          payments: [
            StudentBookingChargePaymentEntity(
              id: 1,
              amountPaid: '500',
              paymentMethod: 'SHAM_CASH',
              receivedAt: DateTime.now(),
            ),
          ],
        ),
      ],
    );
  }

  final StudentBookingDetailBookingEntity booking;
  final StudentBookingDetailPersonEntity student;
  final StudentBookingDetailPersonEntity instructor;
  final StudentBookingDetailVehicleEntity? vehicle;
  final List<StudentBookingChargeEntity> charges;

  double get totalAmountDue => charges.fold<double>(
    0,
    (sum, charge) => sum + (double.tryParse(charge.amountDue) ?? 0),
  );

  double get totalPaid =>
      charges.fold<double>(0, (sum, charge) => sum + charge.totalPaid);

  double get totalRemaining => totalAmountDue - totalPaid;

  @override
  List<Object?> get props => [booking, student, instructor, vehicle, charges];
}

/// Where a cancelled booking's deposit ended up, derived from the fresh
/// [StudentPaymentStatus] returned after a cancellation.
enum StudentBookingDepositOutcome { availableForRebooking, nonRefundable, none }

abstract final class StudentBookingDepositOutcomeMapper {
  static StudentBookingDepositOutcome fromPaymentStatus(
    StudentPaymentStatus status,
  ) {
    return switch (status) {
      StudentPaymentStatus.depositAvailableForRebooking =>
        StudentBookingDepositOutcome.availableForRebooking,
      StudentPaymentStatus.depositNonRefundable =>
        StudentBookingDepositOutcome.nonRefundable,
      StudentPaymentStatus.pendingDeposit ||
      StudentPaymentStatus.depositPaid ||
      StudentPaymentStatus.fullyPaid ||
      StudentPaymentStatus.depositUsedInRebooking =>
        StudentBookingDepositOutcome.none,
    };
  }
}

/// Computes remaining/paid amounts from backend string amounts, which may
/// contain decimals and must be parsed carefully (never trust `int.parse`).
abstract final class StudentBookingAmountCalculator {
  static double sumPayments(List<StudentBookingChargePaymentEntity> payments) {
    return payments.fold<double>(
      0,
      (sum, payment) => sum + (double.tryParse(payment.amountPaid) ?? 0),
    );
  }

  static double computeRemaining(
    String amountDue,
    List<StudentBookingChargePaymentEntity> payments,
  ) {
    final due = double.tryParse(amountDue) ?? 0;
    final paid = sumPayments(payments);
    final remaining = due - paid;
    return remaining < 0 ? 0 : remaining;
  }
}
