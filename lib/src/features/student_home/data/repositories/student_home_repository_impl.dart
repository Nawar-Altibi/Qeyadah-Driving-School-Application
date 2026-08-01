import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart';

abstract interface class StudentHomeRemoteDataSource {
  RemoteResponse<StudentHomeDashboardEntity> fetchDashboard(
    LoadStudentHomeParams params,
  );
}

@LazySingleton(as: StudentHomeRemoteDataSource)
class StudentHomeRemoteDataSourceImpl implements StudentHomeRemoteDataSource {
  @override
  RemoteResponse<StudentHomeDashboardEntity> fetchDashboard(
    LoadStudentHomeParams params,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final referenceDate = DateTime(2025, 6, 25);
    final lessonStart = DateTime(2025, 6, 25, 11);
    final lessonEnd = DateTime(2025, 6, 25, 12, 30);

    return right(
      StudentHomeDashboardEntity(
        referenceDate: referenceDate,
        hasUnreadNotifications: true,
        nextLesson: StudentHomeNextLessonEntity(
          startsAt: lessonStart,
          endsAt: lessonEnd,
          instructorName: 'لينا درويش',
          instructorIsFemale: true,
          isAutomatic: true,
          isSchoolVehicle: true,
          status: StudentHomeLessonStatus.confirmed,
          meetingPointLabel: 'مدرسة قيادة',
        ),
        pendingPayment: StudentHomePendingPaymentEntity(
          remainingMinutes: 9,
          remainingSeconds: 42,
          bookingId: 4821,
          depositAmount: '25000',
          receiverName: 'مدرسة قيادة - شام كاش',
          lockedUntil: DateTime.now().add(
            const Duration(minutes: 9, seconds: 42),
          ),
        ),
        quickActions: const [
          StudentHomeQuickActionType.newBooking,
          StudentHomeQuickActionType.myBookings,
          StudentHomeQuickActionType.certificateRequest,
          StudentHomeQuickActionType.theorySimulation,
        ],
        trainingProgress: const StudentHomeTrainingProgressEntity(
          completedHours: 12,
          totalHours: 20,
        ),
      ),
    );
  }
}

@LazySingleton(as: StudentHomeRepository)
class StudentHomeRepositoryImpl implements StudentHomeRepository {
  StudentHomeRepositoryImpl(this._remoteDataSource);

  final StudentHomeRemoteDataSource _remoteDataSource;

  @override
  FutureEither<StudentHomeDashboardEntity> loadDashboard(
    LoadStudentHomeParams params,
  ) async {
    final response = await _remoteDataSource.fetchDashboard(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }
}
