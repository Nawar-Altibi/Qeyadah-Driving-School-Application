import 'package:qeyadah_mobile_app/src/shared/enums/instructor_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_day_of_week.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_invoice_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_payment_method.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_type.dart';

enum InstructorBookingsViewMode {
  day,
  week;

  String get apiValue => name;
}

class InstructorProfileEntity {
  const InstructorProfileEntity({
    required this.instructorId,
    required this.userId,
    required this.name,
    required this.gender,
    required this.instructorType,
    required this.accountStatus,
    required this.sessionWage,
    required this.todayLessonsCount,
    this.leaveStatus,
  });

  factory InstructorProfileEntity.placeholder() =>
      const InstructorProfileEntity(
        instructorId: 0,
        userId: 0,
        name: '',
        gender: 'MALE',
        instructorType: InstructorType.manual,
        accountStatus: 'ACTIVE',
        sessionWage: 100,
        todayLessonsCount: 3,
      );

  final int instructorId;
  final int userId;
  final String name;
  final String gender;
  final InstructorType instructorType;
  final String accountStatus;
  final int sessionWage;
  final int todayLessonsCount;
  final String? leaveStatus;
}

class InstructorStudentEntity {
  const InstructorStudentEntity({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory InstructorStudentEntity.placeholder() =>
      const InstructorStudentEntity(
        id: 0,
        name: 'Placeholder Student Name',
        phone: '0999000000',
      );

  final int id;
  final String name;
  final String phone;
}

class InstructorBookingEntity {
  const InstructorBookingEntity({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.trainingType,
    required this.vehicleSource,
    required this.student,
  });

  final int id;
  final DateTime date;
  final String startTime;
  final String endTime;
  final InstructorBookingStatus bookingStatus;
  final String paymentStatus;
  final InstructorType trainingType;
  final String vehicleSource;
  final InstructorStudentEntity student;

  factory InstructorBookingEntity.placeholder({DateTime? date, int id = 1}) {
    final resolvedDate = date ?? DateTime(2026, 7, 5);
    return InstructorBookingEntity(
      id: id,
      date: resolvedDate,
      startTime: '09:00',
      endTime: '10:00',
      bookingStatus: InstructorBookingStatus.booked,
      paymentStatus: 'PAID',
      trainingType: InstructorType.manual,
      vehicleSource: 'SCHOOL',
      student: InstructorStudentEntity.placeholder(),
    );
  }

  DateTime get startDateTime => _combineDateAndTime(date, startTime);
  DateTime get endDateTime => _combineDateAndTime(date, endTime);

  Duration get duration => endDateTime.difference(startDateTime);

  static DateTime _combineDateAndTime(DateTime date, String time) {
    final parts = time.split(':');
    final hour = int.tryParse(parts.first) ?? 0;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}

class InstructorSchedulePeriodEntity {
  const InstructorSchedulePeriodEntity({
    required this.startTime,
    required this.endTime,
  });

  final String startTime;
  final String endTime;
}

class InstructorScheduleDayEntity {
  const InstructorScheduleDayEntity({
    required this.dayOfWeek,
    required this.periods,
  });

  factory InstructorScheduleDayEntity.placeholderForDate(DateTime date) {
    return InstructorScheduleDayEntity(
      dayOfWeek: InstructorDayOfWeek.fromDateTime(date).apiValue,
      periods: const [
        InstructorSchedulePeriodEntity(startTime: '08:00', endTime: '18:00'),
      ],
    );
  }

  final String dayOfWeek;
  final List<InstructorSchedulePeriodEntity> periods;
}

class InstructorLeaveEntity {
  const InstructorLeaveEntity({
    required this.id,
    required this.startAt,
    required this.endAt,
    this.reason,
    required this.isFullDay,
    required this.createdAt,
  });

  factory InstructorLeaveEntity.placeholder({
    bool isFullDay = false,
    int id = 1,
  }) {
    return InstructorLeaveEntity(
      id: id,
      startAt: DateTime(2026, 7, 10, 9),
      endAt: DateTime(2026, 7, 10, 17),
      reason: 'Placeholder leave reason text',
      isFullDay: isFullDay,
      createdAt: DateTime(2026, 7),
    );
  }

  final int id;
  final DateTime startAt;
  final DateTime endAt;
  final String? reason;
  final bool isFullDay;
  final DateTime createdAt;
}

class InstructorDueDayEntity {
  const InstructorDueDayEntity({
    required this.expenseDate,
    required this.lessonCount,
    required this.dayTotal,
  });

  factory InstructorDueDayEntity.placeholder({int offsetDays = 0}) {
    final now = DateTime.now();
    final day = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: offsetDays));
    return InstructorDueDayEntity(
      expenseDate: day,
      lessonCount: 3,
      dayTotal: 1500,
    );
  }

  final DateTime expenseDate;
  final int lessonCount;
  final int dayTotal;
}

class InstructorDuesEntity {
  const InstructorDuesEntity({required this.dues, required this.grandTotal});

  factory InstructorDuesEntity.placeholder() => InstructorDuesEntity(
    grandTotal: 4500,
    dues: [
      InstructorDueDayEntity.placeholder(),
      InstructorDueDayEntity.placeholder(offsetDays: 1),
      InstructorDueDayEntity.placeholder(offsetDays: 2),
    ],
  );

  final List<InstructorDueDayEntity> dues;
  final int grandTotal;
}

class InstructorEarningSessionEntity {
  const InstructorEarningSessionEntity({
    required this.bookingId,
    required this.date,
    required this.startAt,
    required this.endAt,
    required this.studentName,
    required this.amount,
    required this.paidAt,
  });

  final int bookingId;
  final DateTime date;
  final DateTime startAt;
  final DateTime endAt;
  final String studentName;
  final int amount;
  final DateTime paidAt;
}

class InstructorEarningsEntity {
  const InstructorEarningsEntity({
    required this.periodType,
    this.date,
    this.month,
    this.daySessionsCount,
    this.dayTotal,
    required this.monthSessionsCount,
    required this.monthTotal,
    required this.sessions,
  });

  factory InstructorEarningsEntity.placeholder() {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day, 9);
    return InstructorEarningsEntity(
      periodType: 'day',
      date: day,
      month: '${now.year}-${now.month.toString().padLeft(2, '0')}',
      daySessionsCount: 3,
      dayTotal: 1500,
      monthSessionsCount: 12,
      monthTotal: 6000,
      sessions: [
        InstructorEarningSessionEntity(
          bookingId: 1,
          date: day,
          startAt: day,
          endAt: day.add(const Duration(hours: 1, minutes: 30)),
          studentName: 'Placeholder Student',
          amount: 500,
          paidAt: day,
        ),
        InstructorEarningSessionEntity(
          bookingId: 2,
          date: day,
          startAt: day.add(const Duration(hours: 2)),
          endAt: day.add(const Duration(hours: 3, minutes: 30)),
          studentName: 'Placeholder Student',
          amount: 500,
          paidAt: day,
        ),
      ],
    );
  }

  final String periodType;
  final DateTime? date;
  final String? month;
  final int? daySessionsCount;
  final int? dayTotal;
  final int monthSessionsCount;
  final int monthTotal;
  final List<InstructorEarningSessionEntity> sessions;
}

class InstructorInvoiceEntity {
  const InstructorInvoiceEntity({
    required this.paidAt,
    required this.type,
    required this.amount,
    required this.entryCount,
    required this.paymentMethod,
    required this.expenseIds,
  });

  factory InstructorInvoiceEntity.placeholder({int offsetMinutes = 0}) {
    final now = DateTime.now();
    return InstructorInvoiceEntity(
      paidAt: now.subtract(Duration(minutes: offsetMinutes)),
      type: offsetMinutes == 0
          ? InstructorInvoiceType.lessons
          : InstructorInvoiceType.bonus,
      amount: offsetMinutes == 0 ? 2000 : 10000,
      entryCount: offsetMinutes == 0 ? 4 : 1,
      paymentMethod: offsetMinutes == 0
          ? InstructorPaymentMethod.cash
          : InstructorPaymentMethod.shamCash,
      expenseIds: offsetMinutes == 0 ? const [86, 87, 88, 89] : const [98],
    );
  }

  final DateTime paidAt;
  final InstructorInvoiceType type;
  final int amount;
  final int entryCount;
  final InstructorPaymentMethod paymentMethod;
  final List<int> expenseIds;
}

class InstructorInvoicesPageEntity {
  const InstructorInvoicesPageEntity({
    this.periodType,
    this.date,
    this.month,
    required this.totalReceived,
    required this.sessionCount,
    required this.invoiceCount,
    required this.invoices,
    required this.page,
    required this.totalPages,
  });

  factory InstructorInvoicesPageEntity.placeholder() {
    final now = DateTime.now();
    return InstructorInvoicesPageEntity(
      periodType: 'month',
      month: '${now.year}-${now.month.toString().padLeft(2, '0')}',
      totalReceived: 12000,
      sessionCount: 5,
      invoiceCount: 2,
      invoices: [
        InstructorInvoiceEntity.placeholder(),
        InstructorInvoiceEntity.placeholder(offsetMinutes: 5),
      ],
      page: 1,
      totalPages: 1,
    );
  }

  final String? periodType;
  final DateTime? date;
  final String? month;
  final int totalReceived;
  final int sessionCount;
  final int invoiceCount;
  final List<InstructorInvoiceEntity> invoices;
  final int page;
  final int totalPages;

  bool get hasMorePages => page < totalPages;

  InstructorInvoicesPageEntity appendPage(InstructorInvoicesPageEntity next) {
    return InstructorInvoicesPageEntity(
      periodType: next.periodType ?? periodType,
      date: next.date ?? date,
      month: next.month ?? month,
      totalReceived: next.totalReceived,
      sessionCount: next.sessionCount,
      invoiceCount: next.invoiceCount,
      invoices: [...invoices, ...next.invoices],
      page: next.page,
      totalPages: next.totalPages,
    );
  }
}

class InstructorScheduleDashboardEntity {
  const InstructorScheduleDashboardEntity({
    required this.profile,
    required this.selectedDate,
    required this.viewMode,
    required this.bookings,
    required this.weeklySchedule,
  });

  factory InstructorScheduleDashboardEntity.placeholder() {
    final today = DateTime.now();
    final selectedDate = DateTime(today.year, today.month, today.day);
    return InstructorScheduleDashboardEntity(
      profile: InstructorProfileEntity.placeholder(),
      selectedDate: selectedDate,
      viewMode: InstructorBookingsViewMode.day,
      bookings: List<InstructorBookingEntity>.generate(
        3,
        (index) => InstructorBookingEntity.placeholder(
          date: selectedDate,
          id: index + 1,
        ),
      ),
      weeklySchedule: [
        InstructorScheduleDayEntity.placeholderForDate(selectedDate),
      ],
    );
  }

  final InstructorProfileEntity profile;
  final DateTime selectedDate;
  final InstructorBookingsViewMode viewMode;
  final List<InstructorBookingEntity> bookings;
  final List<InstructorScheduleDayEntity> weeklySchedule;

  Map<DateTime, List<InstructorBookingEntity>> get bookingsByDate {
    final grouped = <DateTime, List<InstructorBookingEntity>>{};
    final sortedBookings = [...bookings]
      ..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
    for (final booking in sortedBookings) {
      final date = DateTime(
        booking.date.year,
        booking.date.month,
        booking.date.day,
      );
      grouped.putIfAbsent(date, () => []).add(booking);
    }
    return grouped;
  }

  int get sessionCount => bookings
      .where(
        (b) =>
            b.bookingStatus == InstructorBookingStatus.booked ||
            b.bookingStatus == InstructorBookingStatus.completed,
      )
      .length;

  double get trainingHours {
    var totalMinutes = 0;
    for (final booking in bookings) {
      if (booking.bookingStatus == InstructorBookingStatus.cancelled ||
          booking.bookingStatus == InstructorBookingStatus.expired) {
        continue;
      }
      totalMinutes += booking.duration.inMinutes;
    }
    return totalMinutes / 60;
  }

  int get bookedPercent {
    final daySchedule = weeklySchedule.firstWhere(
      (day) =>
          day.dayOfWeek ==
          InstructorDayOfWeek.fromDateTime(selectedDate).apiValue,
      orElse: () =>
          const InstructorScheduleDayEntity(dayOfWeek: '', periods: []),
    );
    var availableMinutes = 0;
    for (final period in daySchedule.periods) {
      availableMinutes += _minutesBetween(period.startTime, period.endTime);
    }
    if (availableMinutes <= 0) return 0;
    final bookedMinutes = bookings
        .where(
          (b) =>
              b.bookingStatus != InstructorBookingStatus.cancelled &&
              b.bookingStatus != InstructorBookingStatus.expired,
        )
        .fold<int>(0, (sum, b) => sum + b.duration.inMinutes);
    return ((bookedMinutes / availableMinutes) * 100).round().clamp(0, 100);
  }

  static int _minutesBetween(String start, String end) {
    final startParts = start.split(':');
    final endParts = end.split(':');
    final startMinutes =
        (int.tryParse(startParts[0]) ?? 0) * 60 +
        (int.tryParse(startParts[1]) ?? 0);
    final endMinutes =
        (int.tryParse(endParts[0]) ?? 0) * 60 +
        (int.tryParse(endParts[1]) ?? 0);
    return endMinutes - startMinutes;
  }
}

class InstructorProfileDashboardEntity {
  const InstructorProfileDashboardEntity({required this.profile});

  factory InstructorProfileDashboardEntity.placeholder() =>
      InstructorProfileDashboardEntity(
        profile: InstructorProfileEntity.placeholder(),
      );

  final InstructorProfileEntity profile;
}
