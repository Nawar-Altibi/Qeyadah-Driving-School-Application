import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

abstract interface class StudentBookingsRemoteDataSource {
  RemoteResponse<StudentBookingsPageEntity> fetchBookings(
    LoadStudentBookingsParams params,
  );

  RemoteResponse<StudentBookingDetailEntity> fetchBookingDetail(int bookingId);

  RemoteResponse<void> cancelBooking(CancelStudentBookingParams params);
}

@LazySingleton(as: StudentBookingsRemoteDataSource)
class StudentBookingsRemoteDataSourceImpl
    implements StudentBookingsRemoteDataSource {
  StudentBookingsRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<StudentBookingsPageEntity> fetchBookings(
    LoadStudentBookingsParams params,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.studentBookings,
      queryParameters: {
        if (params.bookingStatus != null)
          'bookingStatus': params.bookingStatus!.apiValue,
        if (params.search != null && params.search!.trim().isNotEmpty)
          'search': params.search!.trim(),
        'page': params.page,
        'limit': params.limit,
      },
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_pageFromJson(json));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse bookings list response',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<StudentBookingDetailEntity> fetchBookingDetail(
    int bookingId,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.studentBookingById(bookingId),
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_detailFromJson(json));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse booking detail response',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<void> cancelBooking(CancelStudentBookingParams params) async {
    final response = await _apiHandler.post(
      Endpoints.studentBookingCancel(params.bookingId),
      body: {'cancellationReason': params.cancellationReason},
      isAuthorized: true,
    );
    return response.fold(left, (_) => right(null));
  }

  StudentBookingsPageEntity _pageFromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Iterable) {
      throw const FormatException('Invalid bookings list response');
    }
    final meta = json['meta'] is Map
        ? Map<String, dynamic>.from(json['meta'] as Map)
        : const <String, dynamic>{};
    return StudentBookingsPageEntity(
      items: data
          .map(
            (item) => _listItemFromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
      total: _parseInt(meta['total']) ?? 0,
      page: _parseInt(meta['page']) ?? 1,
      limit: _parseInt(meta['limit']) ?? StudentBookingsPagination.defaultLimit,
      totalPages: _parseInt(meta['totalPages']) ?? 1,
    );
  }

  StudentBookingListItemEntity _listItemFromJson(Map<String, dynamic> json) {
    final bookingStatus = StudentBookingStatus.fromApi(
      json['bookingStatus']?.toString(),
    );
    final paymentStatus = StudentPaymentStatus.fromApi(
      json['paymentStatus']?.toString(),
    );
    if (bookingStatus == null || paymentStatus == null) {
      throw const FormatException('Invalid booking status in list item');
    }
    return StudentBookingListItemEntity(
      id: json['id']?.toString() ?? '',
      studentName: json['studentName']?.toString() ?? '',
      instructorName: json['instructorName']?.toString() ?? '',
      trainingType: TrainingType.fromApi(json['trainingType']?.toString()),
      vehicleSource: VehicleSource.fromApi(json['vehicleSource']?.toString()),
      vehiclePlate: json['vehiclePlate']?.toString(),
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,
      dayName: json['dayName']?.toString() ?? '',
      startTime: json['startTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
      bookingStatus: bookingStatus,
      paymentStatus: paymentStatus,
      remainingAmount: json['remainingAmount']?.toString(),
    );
  }

  StudentBookingDetailEntity _detailFromJson(Map<String, dynamic> json) {
    final bookingJson = json['booking'];
    final studentJson = json['student'];
    final instructorJson = json['instructor'];
    final vehicleJson = json['vehicle'];
    final chargesJson = json['charges'];
    if (bookingJson is! Map || studentJson is! Map || instructorJson is! Map) {
      throw const FormatException('Invalid booking detail response');
    }
    return StudentBookingDetailEntity(
      booking: _detailBookingFromJson(Map<String, dynamic>.from(bookingJson)),
      student: _personFromJson(Map<String, dynamic>.from(studentJson)),
      instructor: _personFromJson(Map<String, dynamic>.from(instructorJson)),
      vehicle: vehicleJson is Map
          ? _vehicleFromJson(Map<String, dynamic>.from(vehicleJson))
          : null,
      charges: chargesJson is Iterable
          ? chargesJson
                .map(
                  (charge) =>
                      _chargeFromJson(Map<String, dynamic>.from(charge as Map)),
                )
                .toList()
          : const [],
    );
  }

  StudentBookingDetailBookingEntity _detailBookingFromJson(
    Map<String, dynamic> json,
  ) {
    final bookingStatus = StudentBookingStatus.fromApi(
      json['bookingStatus']?.toString(),
    );
    final paymentStatus = StudentPaymentStatus.fromApi(
      json['paymentStatus']?.toString(),
    );
    if (bookingStatus == null || paymentStatus == null) {
      throw const FormatException('Invalid booking status in detail response');
    }
    return StudentBookingDetailBookingEntity(
      id: _parseInt(json['id']) ?? 0,
      bookingStatus: bookingStatus,
      paymentStatus: paymentStatus,
      trainingType: TrainingType.fromApi(json['trainingType']?.toString()),
      vehicleSource: VehicleSource.fromApi(json['vehicleSource']?.toString()),
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,
      dayName: json['dayName']?.toString(),
      startTime: json['startTime']?.toString(),
      endTime: json['endTime']?.toString(),
      lockedUntil: json['lockedUntil'] != null
          ? DateTime.tryParse(json['lockedUntil'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  StudentBookingDetailPersonEntity _personFromJson(Map<String, dynamic> json) {
    return StudentBookingDetailPersonEntity(
      id: _parseInt(json['id']) ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString(),
    );
  }

  StudentBookingDetailVehicleEntity _vehicleFromJson(
    Map<String, dynamic> json,
  ) {
    return StudentBookingDetailVehicleEntity(
      id: _parseInt(json['id']) ?? 0,
      source: VehicleSource.fromApi(json['source']?.toString()),
      plateNumber: (json['plateNumber'] ?? json['plate'])?.toString(),
    );
  }

  StudentBookingChargeEntity _chargeFromJson(Map<String, dynamic> json) {
    final chargeStatus =
        StudentChargeStatus.fromApi(json['chargeStatus']?.toString()) ??
        StudentChargeStatus.unpaid;
    final paymentsJson = json['payments'];
    return StudentBookingChargeEntity(
      id: _parseInt(json['id']) ?? 0,
      chargeReason: json['chargeReason']?.toString() ?? '',
      amountDue: json['amountDue']?.toString() ?? '0',
      chargeStatus: chargeStatus,
      payments: paymentsJson is Iterable
          ? paymentsJson
                .map(
                  (payment) => _paymentFromJson(
                    Map<String, dynamic>.from(payment as Map),
                  ),
                )
                .toList()
          : const [],
    );
  }

  StudentBookingChargePaymentEntity _paymentFromJson(
    Map<String, dynamic> json,
  ) {
    return StudentBookingChargePaymentEntity(
      id: _parseInt(json['id']) ?? 0,
      amountPaid: json['amountPaid']?.toString() ?? '0',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      receivedAt:
          DateTime.tryParse(json['receivedAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  int? _parseInt(Object? raw) {
    if (raw == null) return null;
    if (raw is num) return raw.toInt();
    return int.tryParse(raw.toString());
  }
}
