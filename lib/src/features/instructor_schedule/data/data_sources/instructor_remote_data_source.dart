import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_type.dart';

abstract interface class InstructorRemoteDataSource {
  RemoteResponse<InstructorProfileEntity> fetchProfile();
  RemoteResponse<List<InstructorScheduleDayEntity>> fetchWeeklySchedule();
  RemoteResponse<List<InstructorBookingEntity>> fetchDayBookings(DateTime date);
  RemoteResponse<List<InstructorBookingEntity>> fetchWeekBookings(
    DateTime weekStart,
  );
  RemoteResponse<List<InstructorLeaveEntity>> fetchLeaves();
  RemoteResponse<InstructorDuesEntity> fetchDues();
  RemoteResponse<InstructorEarningsEntity> fetchEarningsForDate(DateTime date);
  RemoteResponse<InstructorEarningsEntity> fetchEarningsForMonth(String month);
}

@LazySingleton(as: InstructorRemoteDataSource)
class InstructorRemoteDataSourceImpl implements InstructorRemoteDataSource {
  InstructorRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<InstructorProfileEntity> fetchProfile() async {
    final response = await _apiHandler.get(Endpoints.instructorMeProfile);
    return response.fold(left, (json) {
      try {
        return right(_profileFromJson(_unwrapData(json)));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse instructor profile',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<List<InstructorScheduleDayEntity>>
  fetchWeeklySchedule() async {
    final response = await _apiHandler.get(Endpoints.instructorMeSchedule);
    return response.fold(left, (json) {
      try {
        final schedule = _unwrapData(json)['schedule'];
        if (schedule is! Iterable) {
          return left(
            const InternalServerErrorFailure('Invalid schedule response'),
          );
        }
        return right(
          schedule
              .map(
                (item) => _scheduleDayFromJson(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList(),
        );
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse instructor schedule',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<List<InstructorBookingEntity>> fetchDayBookings(
    DateTime date,
  ) async {
    final dateParam = DateFormat('yyyy-MM-dd').format(date);
    final response = await _apiHandler.get(
      Endpoints.instructorMeBookings,
      queryParameters: {'viewMode': 'day', 'date': dateParam},
    );
    return response.fold(left, (json) {
      try {
        final data = _unwrapData(json);
        final bookings = data['data'];
        if (bookings is! Iterable) {
          return left(
            const InternalServerErrorFailure('Invalid bookings response'),
          );
        }
        return right(
          bookings
              .map(
                (item) =>
                    _bookingFromJson(Map<String, dynamic>.from(item as Map)),
              )
              .toList(),
        );
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse instructor bookings',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<List<InstructorBookingEntity>> fetchWeekBookings(
    DateTime weekStart,
  ) async {
    final weekStartParam = DateFormat('yyyy-MM-dd').format(weekStart);
    final response = await _apiHandler.get(
      Endpoints.instructorMeBookings,
      queryParameters: {'viewMode': 'week', 'weekStart': weekStartParam},
    );
    return response.fold(left, (json) {
      try {
        final data = _unwrapData(json);
        final bookings = data['data'];
        if (bookings is! Iterable) {
          return left(
            const InternalServerErrorFailure('Invalid bookings response'),
          );
        }
        return right(
          bookings
              .map(
                (item) =>
                    _bookingFromJson(Map<String, dynamic>.from(item as Map)),
              )
              .toList(),
        );
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse instructor bookings',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<List<InstructorLeaveEntity>> fetchLeaves() async {
    final response = await _apiHandler.get(Endpoints.instructorMeLeaves);
    return response.fold(left, (json) {
      try {
        final leaves = _unwrapData(json)['leaves'];
        if (leaves is! Iterable) {
          return left(
            const InternalServerErrorFailure('Invalid leaves response'),
          );
        }
        return right(
          leaves
              .map(
                (item) =>
                    _leaveFromJson(Map<String, dynamic>.from(item as Map)),
              )
              .toList(),
        );
      } on Exception {
        return left(
          const InternalServerErrorFailure('Failed to parse instructor leaves'),
        );
      }
    });
  }

  @override
  RemoteResponse<InstructorDuesEntity> fetchDues() async {
    final response = await _apiHandler.get(Endpoints.instructorMeDues);
    return response.fold(left, (json) {
      try {
        final data = _unwrapData(json);
        // Accept mobile-doc shape (dues/grandTotal) and live service shape
        // (perDay/totalOutstanding) so either response maps cleanly.
        final rawList = data['dues'] ?? data['perDay'];
        if (rawList is! Iterable) {
          return left(
            const InternalServerErrorFailure('Invalid dues response'),
          );
        }
        return right(
          InstructorDuesEntity(
            grandTotal:
                (data['grandTotal'] as num?)?.toInt() ??
                (data['totalOutstanding'] as num?)?.toInt() ??
                0,
            dues: rawList.map((item) {
              final map = Map<String, dynamic>.from(item as Map);
              final dateRaw = map['expenseDate'] ?? map['date'];
              return InstructorDueDayEntity(
                expenseDate: DateTime.parse(dateRaw.toString()),
                lessonCount: (map['lessonCount'] as num?)?.toInt() ?? 0,
                dayTotal:
                    (map['dayTotal'] as num?)?.toInt() ??
                    (map['amount'] as num?)?.toInt() ??
                    0,
              );
            }).toList(),
          ),
        );
      } on Exception {
        return left(
          const InternalServerErrorFailure('Failed to parse instructor dues'),
        );
      }
    });
  }

  @override
  RemoteResponse<InstructorEarningsEntity> fetchEarningsForDate(
    DateTime date,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.instructorMeEarnings,
      queryParameters: {'date': DateFormat('yyyy-MM-dd').format(date)},
    );
    return response.fold(left, (json) {
      try {
        return right(_earningsFromJson(_unwrapData(json)));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse instructor earnings',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<InstructorEarningsEntity> fetchEarningsForMonth(
    String month,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.instructorMeEarnings,
      queryParameters: {'month': month},
    );
    return response.fold(left, (json) {
      try {
        return right(_earningsFromJson(_unwrapData(json)));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse instructor earnings',
          ),
        );
      }
    });
  }

  InstructorProfileEntity _profileFromJson(Map<String, dynamic> json) {
    final instructorType = InstructorType.fromApi(
      json['instructorType']?.toString(),
    );
    if (instructorType == null) {
      throw const FormatException('Unknown instructor type');
    }
    return InstructorProfileEntity(
      instructorId: (json['instructorId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      instructorType: instructorType,
      accountStatus: json['accountStatus']?.toString() ?? '',
      sessionWage: (json['sessionWage'] as num?)?.toInt() ?? 0,
      todayLessonsCount: (json['todayLessonsCount'] as num?)?.toInt() ?? 0,
      leaveStatus: json['leaveStatus']?.toString(),
    );
  }

  InstructorScheduleDayEntity _scheduleDayFromJson(Map<String, dynamic> json) {
    final periods = json['periods'];
    return InstructorScheduleDayEntity(
      dayOfWeek: json['dayOfWeek']?.toString() ?? '',
      periods: periods is Iterable
          ? periods.map((item) {
              final map = Map<String, dynamic>.from(item as Map);
              return InstructorSchedulePeriodEntity(
                startTime: map['startTime']?.toString() ?? '',
                endTime: map['endTime']?.toString() ?? '',
              );
            }).toList()
          : const [],
    );
  }

  InstructorBookingEntity _bookingFromJson(Map<String, dynamic> json) {
    final status = InstructorBookingStatus.fromApi(
      json['bookingStatus']?.toString(),
    );
    final trainingType = InstructorType.fromApi(
      json['trainingType']?.toString(),
    );
    if (status == null || trainingType == null) {
      throw const FormatException('Invalid booking payload');
    }
    final studentJson = Map<String, dynamic>.from(json['student'] as Map);
    return InstructorBookingEntity(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'].toString()),
      startTime: json['startTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
      bookingStatus: status,
      paymentStatus: json['paymentStatus']?.toString() ?? '',
      trainingType: trainingType,
      vehicleSource: json['vehicleSource']?.toString() ?? '',
      student: InstructorStudentEntity(
        id: (studentJson['id'] as num).toInt(),
        name: studentJson['name']?.toString() ?? '',
        phone: studentJson['phone']?.toString() ?? '',
      ),
    );
  }

  InstructorLeaveEntity _leaveFromJson(Map<String, dynamic> json) {
    return InstructorLeaveEntity(
      id: (json['id'] as num).toInt(),
      startAt: DateTime.parse(json['startAt'].toString()),
      endAt: DateTime.parse(json['endAt'].toString()),
      reason: json['reason']?.toString(),
      isFullDay: json['isFullDay'] == true,
      createdAt: DateTime.parse(json['createdAt'].toString()),
    );
  }

  InstructorEarningsEntity _earningsFromJson(Map<String, dynamic> json) {
    final period = Map<String, dynamic>.from(json['period'] as Map);
    final sessions = json['sessions'];
    return InstructorEarningsEntity(
      periodType: period['type']?.toString() ?? '',
      date: period['date'] != null
          ? DateTime.parse(period['date'].toString())
          : null,
      month: period['month']?.toString(),
      daySessionsCount: (json['daySessionsCount'] as num?)?.toInt(),
      dayTotal: (json['dayTotal'] as num?)?.toInt(),
      monthSessionsCount: (json['monthSessionsCount'] as num?)?.toInt() ?? 0,
      monthTotal: (json['monthTotal'] as num?)?.toInt() ?? 0,
      sessions: sessions is Iterable
          ? sessions.map((item) {
              final map = Map<String, dynamic>.from(item as Map);
              return InstructorEarningSessionEntity(
                bookingId: (map['bookingId'] as num).toInt(),
                date: DateTime.parse(map['date'].toString()),
                startAt: DateTime.parse(map['startAt'].toString()),
                endAt: DateTime.parse(map['endAt'].toString()),
                studentName: map['studentName']?.toString() ?? '',
                amount: (map['amount'] as num?)?.toInt() ?? 0,
                paidAt: DateTime.parse(map['paidAt'].toString()),
              );
            }).toList()
          : const [],
    );
  }

  Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    return json;
  }
}
