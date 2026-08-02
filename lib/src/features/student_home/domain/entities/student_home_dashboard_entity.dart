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
    this.bookingId,
    this.depositAmount,
    this.receiverName,
    this.lockedUntil,
  });

  final int remainingMinutes;
  final int remainingSeconds;

  /// When present, the pending payment banner can deep-link straight to the
  /// ShamCash payment screen to resume this specific booking hold.
  final int? bookingId;
  final String? depositAmount;
  final String? receiverName;
  final DateTime? lockedUntil;

  bool get canResumePayment =>
      bookingId != null &&
      depositAmount != null &&
      receiverName != null &&
      lockedUntil != null;

  @override
  List<Object?> get props => [
    remainingMinutes,
    remainingSeconds,
    bookingId,
    depositAmount,
    receiverName,
    lockedUntil,
  ];
}

class StudentHomeDashboardEntity extends Equatable {
  const StudentHomeDashboardEntity({
    required this.referenceDate,
    required this.hasUnreadNotifications,
    required this.quickActions,
    this.nextLesson,
    this.pendingPayment,
  });

  final DateTime referenceDate;
  final bool hasUnreadNotifications;
  final StudentHomeNextLessonEntity? nextLesson;
  final StudentHomePendingPaymentEntity? pendingPayment;
  final List<StudentHomeQuickActionType> quickActions;

  @override
  List<Object?> get props => [
    referenceDate,
    hasUnreadNotifications,
    nextLesson,
    pendingPayment,
    quickActions,
  ];
}
