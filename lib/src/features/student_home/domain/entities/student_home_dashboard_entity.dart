import 'package:equatable/equatable.dart';

enum StudentHomeQuickActionType {
  newBooking,
  myBookings,
  certificateRequest,
  theorySimulation,
}

enum StudentHomeLessonStatus { confirmed, pending }

class StudentHomeNextLessonEntity extends Equatable {
  const StudentHomeNextLessonEntity({
    required this.startsAt,
    required this.endsAt,
    required this.instructorName,
    required this.instructorIsFemale,
    required this.isAutomatic,
    required this.isSchoolVehicle,
    required this.status,
    this.meetingPointLabel,
  });

  final DateTime startsAt;
  final DateTime endsAt;
  final String instructorName;
  final bool instructorIsFemale;
  final bool isAutomatic;
  final bool isSchoolVehicle;
  final StudentHomeLessonStatus status;
  final String? meetingPointLabel;

  @override
  List<Object?> get props => [
    startsAt,
    endsAt,
    instructorName,
    instructorIsFemale,
    isAutomatic,
    isSchoolVehicle,
    status,
    meetingPointLabel,
  ];
}

class StudentHomePendingPaymentEntity extends Equatable {
  const StudentHomePendingPaymentEntity({
    required this.remainingMinutes,
    required this.remainingSeconds,
  });

  final int remainingMinutes;
  final int remainingSeconds;

  @override
  List<Object?> get props => [remainingMinutes, remainingSeconds];
}

class StudentHomeTrainingProgressEntity extends Equatable {
  const StudentHomeTrainingProgressEntity({
    required this.completedHours,
    required this.totalHours,
  });

  final int completedHours;
  final int totalHours;

  int get progressPercent {
    if (totalHours <= 0) {
      return 0;
    }
    return ((completedHours / totalHours) * 100).round();
  }

  @override
  List<Object?> get props => [completedHours, totalHours];
}

class StudentHomeDashboardEntity extends Equatable {
  const StudentHomeDashboardEntity({
    required this.referenceDate,
    required this.hasUnreadNotifications,
    required this.quickActions,
    required this.trainingProgress,
    this.nextLesson,
    this.pendingPayment,
  });

  final DateTime referenceDate;
  final bool hasUnreadNotifications;
  final StudentHomeNextLessonEntity? nextLesson;
  final StudentHomePendingPaymentEntity? pendingPayment;
  final List<StudentHomeQuickActionType> quickActions;
  final StudentHomeTrainingProgressEntity trainingProgress;

  @override
  List<Object?> get props => [
    referenceDate,
    hasUnreadNotifications,
    nextLesson,
    pendingPayment,
    quickActions,
    trainingProgress,
  ];
}
