import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

abstract interface class StudentBookingRemoteDataSource {
  RemoteResponse<StudentAvailableSlotsPageEntity> fetchAvailableSlots(
    LoadAvailableSlotsParams params,
  );

  RemoteResponse<StudentBookingHoldEntity> createBooking(
    CreateStudentBookingParams params,
  );

  RemoteResponse<StudentBookingCreditEntity> fetchMyCredit();
}

@LazySingleton(as: StudentBookingRemoteDataSource)
class StudentBookingRemoteDataSourceImpl
    implements StudentBookingRemoteDataSource {
  StudentBookingRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<StudentAvailableSlotsPageEntity> fetchAvailableSlots(
    LoadAvailableSlotsParams params,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.studentBookingsAvailableSlots,
      queryParameters: {
        'trainingType': params.trainingType.apiValue,
        'vehicleSource': params.vehicleSource.apiValue,
        'instructorGender': params.instructorGender.apiValue,
      },
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_availableSlotsPageFromJson(json));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse available slots response',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<StudentBookingHoldEntity> createBooking(
    CreateStudentBookingParams params,
  ) async {
    final response = await _apiHandler.post(
      Endpoints.studentBookings,
      body: {
        'instructorId': params.instructorId,
        'date': DateFormat('yyyy-MM-dd').format(params.date),
        'time': params.time,
        'trainingType': params.trainingType.apiValue,
        'vehicleSource': params.vehicleSource.apiValue,
      },
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_holdFromJson(_unwrapData(json)));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse booking creation response',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<StudentBookingCreditEntity> fetchMyCredit() async {
    final response = await _apiHandler.get(
      Endpoints.studentBookingsMyCredit,
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_creditFromJson(_unwrapData(json)));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse my-credit response',
          ),
        );
      }
    });
  }

  StudentBookingCreditEntity _creditFromJson(Map<String, dynamic> json) {
    final hasCredit = json['hasCredit'] == true;
    if (!hasCredit) {
      return const StudentBookingCreditEntity.none();
    }
    return StudentBookingCreditEntity(
      hasCredit: true,
      creditFromBookingId: json['creditFromBookingId']?.toString(),
      creditAmount: json['creditAmount']?.toString(),
    );
  }

  StudentAvailableSlotsPageEntity _availableSlotsPageFromJson(
    Map<String, dynamic> json,
  ) {
    final data = json['data'];
    if (data is! Map) {
      throw const FormatException(
        'Invalid available slots response: expected data object',
      );
    }
    final dataMap = Map<String, dynamic>.from(data);
    final instructorsRaw = dataMap['instructors'];
    if (instructorsRaw is! Iterable) {
      throw const FormatException(
        'Invalid available slots response: missing instructors',
      );
    }
    final pricingRaw = dataMap['pricing'];
    if (pricingRaw is! Map) {
      throw const FormatException(
        'Invalid available slots response: missing pricing',
      );
    }
    return StudentAvailableSlotsPageEntity(
      pricing: _pricingFromJson(Map<String, dynamic>.from(pricingRaw)),
      instructors: instructorsRaw
          .map(
            (item) => _instructorSlotsFromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
    );
  }

  StudentBookingPricingEntity _pricingFromJson(Map<String, dynamic> json) {
    final percentageRaw = json['depositPercentage'];
    final durationRaw = json['lessonDurationMinutes'];
    return StudentBookingPricingEntity(
      lessonPrice: json['lessonPrice']?.toString() ?? '0',
      depositAmount: json['depositAmount']?.toString() ?? '0',
      depositPercentage: percentageRaw is num
          ? percentageRaw.toInt()
          : int.tryParse(percentageRaw?.toString() ?? '') ?? 0,
      lessonDurationMinutes: durationRaw is num
          ? durationRaw.toInt()
          : int.tryParse(durationRaw?.toString() ?? '') ?? 0,
    );
  }

  StudentAvailableInstructorSlotsEntity _instructorSlotsFromJson(
    Map<String, dynamic> json,
  ) {
    final instructorJson = Map<String, dynamic>.from(json['instructor'] as Map);
    final slotsJson = json['slots'];
    return StudentAvailableInstructorSlotsEntity(
      instructor: _instructorFromJson(instructorJson),
      slots: slotsJson is Iterable
          ? slotsJson
                .map(
                  (item) =>
                      _slotFromJson(Map<String, dynamic>.from(item as Map)),
                )
                .toList()
          : const [],
    );
  }

  StudentBookingInstructorEntity _instructorFromJson(
    Map<String, dynamic> json,
  ) {
    final gender = InstructorGender.fromApi(json['gender']?.toString());
    if (gender == null) {
      throw const FormatException('Invalid instructor gender');
    }
    return StudentBookingInstructorEntity(
      id: _parseId(json['id']),
      name: json['name']?.toString() ?? '',
      gender: gender,
    );
  }

  StudentBookingSlotEntity _slotFromJson(Map<String, dynamic> json) {
    return StudentBookingSlotEntity(
      date: DateTime.parse(json['date'].toString()),
      dayName: json['dayName']?.toString() ?? '',
      startTime: json['startTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
    );
  }

  StudentBookingHoldEntity _holdFromJson(Map<String, dynamic> json) {
    final bookingJson = Map<String, dynamic>.from(json['booking'] as Map);
    final paymentRequired = json['paymentRequired'] == true;
    final lockedUntilRaw = json['lockedUntil'] ?? bookingJson['lockedUntil'];
    final depositAmount = json['depositAmount']?.toString();
    final receiverName = json['receiverName']?.toString() ?? '';

    DateTime? lockedUntil;
    if (lockedUntilRaw != null) {
      lockedUntil = DateTime.tryParse(lockedUntilRaw.toString());
    }

    if (paymentRequired) {
      if (depositAmount == null || depositAmount.isEmpty) {
        throw const FormatException(
          'Missing depositAmount in payment-required booking response',
        );
      }
      if (lockedUntil == null) {
        throw const FormatException(
          'Missing lockedUntil in payment-required booking response',
        );
      }
    }

    return StudentBookingHoldEntity(
      booking: _bookingFromJson(bookingJson),
      paymentRequired: paymentRequired,
      depositAmount: depositAmount,
      lockedUntil: lockedUntil,
      receiverName: receiverName,
    );
  }

  StudentBookingEntity _bookingFromJson(Map<String, dynamic> json) {
    final bookingStatus = StudentBookingStatus.fromApi(
      json['bookingStatus']?.toString(),
    );
    final paymentStatus = StudentPaymentStatus.fromApi(
      json['paymentStatus']?.toString(),
    );
    if (bookingStatus == null || paymentStatus == null) {
      throw const FormatException('Invalid booking payload');
    }
    final instructorJson = json['instructor'];
    final vehicleJson = json['vehicle'];
    final lockedUntilRaw = json['lockedUntil'];
    return StudentBookingEntity(
      id: _parseId(json['id']),
      bookingStatus: bookingStatus,
      paymentStatus: paymentStatus,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,
      startTime: json['startTime']?.toString(),
      endTime: json['endTime']?.toString(),
      trainingType: TrainingType.fromApi(json['trainingType']?.toString()),
      vehicleSource: VehicleSource.fromApi(json['vehicleSource']?.toString()),
      instructor: instructorJson is Map
          ? _instructorFromJson(Map<String, dynamic>.from(instructorJson))
          : null,
      vehicle: vehicleJson is Map
          ? _vehicleFromJson(Map<String, dynamic>.from(vehicleJson))
          : null,
      lockedUntil: lockedUntilRaw != null
          ? DateTime.tryParse(lockedUntilRaw.toString())
          : null,
    );
  }

  StudentBookingVehicleEntity _vehicleFromJson(Map<String, dynamic> json) {
    return StudentBookingVehicleEntity(
      id: _parseId(json['id']),
      source: VehicleSource.fromApi(json['source']?.toString()),
    );
  }

  int _parseId(Object? raw) {
    if (raw is num) return raw.toInt();
    return int.tryParse(raw?.toString() ?? '') ?? 0;
  }

  Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    return json;
  }
}
