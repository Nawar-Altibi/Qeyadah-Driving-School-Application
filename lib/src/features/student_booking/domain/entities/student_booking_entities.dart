import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

/// Student-selected filters used to query available booking slots.
///
/// All three filters are required by the backend contract; there is no
/// "no preference" option, so sensible defaults are always selected.
class StudentBookingFiltersEntity extends Equatable {
  const StudentBookingFiltersEntity({
    this.trainingType = TrainingType.manual,
    this.vehicleSource = VehicleSource.schoolCar,
    this.instructorGender = InstructorGender.male,
  });

  final TrainingType trainingType;
  final VehicleSource vehicleSource;
  final InstructorGender instructorGender;

  StudentBookingFiltersEntity copyWith({
    TrainingType? trainingType,
    VehicleSource? vehicleSource,
    InstructorGender? instructorGender,
  }) {
    return StudentBookingFiltersEntity(
      trainingType: trainingType ?? this.trainingType,
      vehicleSource: vehicleSource ?? this.vehicleSource,
      instructorGender: instructorGender ?? this.instructorGender,
    );
  }

  @override
  List<Object?> get props => [trainingType, vehicleSource, instructorGender];
}

class StudentBookingInstructorEntity extends Equatable {
  const StudentBookingInstructorEntity({
    required this.id,
    required this.name,
    required this.gender,
  });

  factory StudentBookingInstructorEntity.placeholder({int id = 1}) {
    return StudentBookingInstructorEntity(
      id: id,
      name: 'Placeholder Instructor Name',
      gender: InstructorGender.male,
    );
  }

  final int id;
  final String name;
  final InstructorGender gender;

  @override
  List<Object?> get props => [id, name, gender];
}

class StudentBookingSlotEntity extends Equatable {
  const StudentBookingSlotEntity({
    required this.date,
    required this.dayName,
    required this.startTime,
    required this.endTime,
  });

  final DateTime date;
  final String dayName;
  final String startTime;
  final String endTime;

  @override
  List<Object?> get props => [date, dayName, startTime, endTime];
}

class StudentAvailableInstructorSlotsEntity extends Equatable {
  const StudentAvailableInstructorSlotsEntity({
    required this.instructor,
    required this.slots,
  });

  factory StudentAvailableInstructorSlotsEntity.placeholder({int id = 1}) {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    return StudentAvailableInstructorSlotsEntity(
      instructor: StudentBookingInstructorEntity.placeholder(id: id),
      slots: [
        StudentBookingSlotEntity(
          date: date,
          dayName: 'Saturday',
          startTime: '09:00',
          endTime: '10:00',
        ),
        StudentBookingSlotEntity(
          date: date,
          dayName: 'Saturday',
          startTime: '11:00',
          endTime: '12:00',
        ),
      ],
    );
  }

  final StudentBookingInstructorEntity instructor;
  final List<StudentBookingSlotEntity> slots;

  @override
  List<Object?> get props => [instructor, slots];
}

class StudentAvailableSlotsPageEntity extends Equatable {
  const StudentAvailableSlotsPageEntity({required this.instructors});

  factory StudentAvailableSlotsPageEntity.placeholder() {
    return StudentAvailableSlotsPageEntity(
      instructors: [
        StudentAvailableInstructorSlotsEntity.placeholder(),
        StudentAvailableInstructorSlotsEntity.placeholder(id: 2),
      ],
    );
  }

  final List<StudentAvailableInstructorSlotsEntity> instructors;

  bool get hasAnySlots =>
      instructors.any((instructor) => instructor.slots.isNotEmpty);

  @override
  List<Object?> get props => [instructors];
}

/// The instructor + slot picked by the student on the slots screen.
class StudentBookingSelectionEntity extends Equatable {
  const StudentBookingSelectionEntity({
    required this.instructor,
    required this.slot,
  });

  final StudentBookingInstructorEntity instructor;
  final StudentBookingSlotEntity slot;

  @override
  List<Object?> get props => [instructor, slot];
}

class StudentBookingVehicleEntity extends Equatable {
  const StudentBookingVehicleEntity({required this.id, this.source});

  final int id;
  final VehicleSource? source;

  @override
  List<Object?> get props => [id, source];
}

/// The booking resource as returned by the backend after creation or
/// payment confirmation.
class StudentBookingEntity extends Equatable {
  const StudentBookingEntity({
    required this.id,
    required this.bookingStatus,
    required this.paymentStatus,
    this.date,
    this.startTime,
    this.endTime,
    this.trainingType,
    this.vehicleSource,
    this.instructor,
    this.vehicle,
    this.lockedUntil,
  });

  final int id;
  final StudentBookingStatus bookingStatus;
  final StudentPaymentStatus paymentStatus;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final TrainingType? trainingType;
  final VehicleSource? vehicleSource;
  final StudentBookingInstructorEntity? instructor;
  final StudentBookingVehicleEntity? vehicle;
  final DateTime? lockedUntil;

  @override
  List<Object?> get props => [
    id,
    bookingStatus,
    paymentStatus,
    date,
    startTime,
    endTime,
    trainingType,
    vehicleSource,
    instructor,
    vehicle,
    lockedUntil,
  ];
}

/// The full "create booking" response: the booking plus ShamCash payment
/// hold details required to render the payment screen.
class StudentBookingHoldEntity extends Equatable {
  const StudentBookingHoldEntity({
    required this.booking,
    required this.paymentRequired,
    required this.depositAmount,
    required this.lockedUntil,
    required this.receiverName,
  });

  final StudentBookingEntity booking;
  final bool paymentRequired;
  final String depositAmount;
  final DateTime lockedUntil;
  final String receiverName;

  @override
  List<Object?> get props => [
    booking,
    paymentRequired,
    depositAmount,
    lockedUntil,
    receiverName,
  ];
}
