import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

class LoadAvailableSlotsParams extends Equatable {
  const LoadAvailableSlotsParams({
    required this.trainingType,
    required this.vehicleSource,
    required this.instructorGender,
  });

  final TrainingType trainingType;
  final VehicleSource vehicleSource;
  final InstructorGender instructorGender;

  @override
  List<Object?> get props => [trainingType, vehicleSource, instructorGender];
}

class CreateStudentBookingParams extends Equatable {
  const CreateStudentBookingParams({
    required this.instructorId,
    required this.date,
    required this.time,
    required this.trainingType,
    required this.vehicleSource,
  });

  final int instructorId;
  final DateTime date;
  final String time;
  final TrainingType trainingType;
  final VehicleSource vehicleSource;

  @override
  List<Object?> get props => [
    instructorId,
    date,
    time,
    trainingType,
    vehicleSource,
  ];
}
