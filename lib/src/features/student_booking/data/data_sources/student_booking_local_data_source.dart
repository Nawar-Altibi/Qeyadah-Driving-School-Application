import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

abstract interface class StudentBookingLocalDataSource {
  FutureEither<void> saveHold(StudentBookingHoldEntity hold);
  FutureEither<StudentBookingHoldEntity?> readHold();
  FutureEither<void> clearHold();
}

@LazySingleton(as: StudentBookingLocalDataSource)
class StudentBookingLocalDataSourceImpl
    implements StudentBookingLocalDataSource {
  StudentBookingLocalDataSourceImpl(
    @Named(RawValues.authNamedInstance) this._database,
  );

  final LocalDatabaseInterface _database;

  @override
  FutureEither<void> saveHold(StudentBookingHoldEntity hold) async {
    try {
      final result = await _database.save(
        StorageKeys.studentBookingPendingHold,
        _holdToJson(hold),
      );
      return result.fold(left, (_) => right(null));
    } on Exception catch (_, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<StudentBookingHoldEntity?> readHold() async {
    try {
      final result = await _database.get<Map<dynamic, dynamic>>(
        StorageKeys.studentBookingPendingHold,
      );
      return result.fold(left, (value) {
        if (value == null) return right(null);
        try {
          return right(_holdFromJson(Map<String, dynamic>.from(value)));
        } on Exception {
          return right(null);
        }
      });
    } on Exception catch (_, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<void> clearHold() async {
    final result = await _database.delete(
      StorageKeys.studentBookingPendingHold,
    );
    return result.fold(left, (_) => right(null));
  }

  Map<String, dynamic> _holdToJson(StudentBookingHoldEntity hold) {
    return {
      'depositAmount': hold.depositAmount,
      'lockedUntil': hold.lockedUntil.toIso8601String(),
      'receiverName': hold.receiverName,
      'paymentRequired': hold.paymentRequired,
      'booking': _bookingToJson(hold.booking),
    };
  }

  StudentBookingHoldEntity _holdFromJson(Map<String, dynamic> json) {
    final bookingJson = json['booking'];
    if (bookingJson is! Map) {
      throw const FormatException('Invalid cached booking hold');
    }
    final lockedUntil = DateTime.tryParse(
      json['lockedUntil']?.toString() ?? '',
    );
    if (lockedUntil == null) {
      throw const FormatException('Invalid cached lockedUntil');
    }
    return StudentBookingHoldEntity(
      booking: _bookingFromJson(Map<String, dynamic>.from(bookingJson)),
      paymentRequired: json['paymentRequired'] == true,
      depositAmount: json['depositAmount']?.toString() ?? '0',
      lockedUntil: lockedUntil,
      receiverName: json['receiverName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> _bookingToJson(StudentBookingEntity booking) {
    return {
      'id': booking.id,
      'bookingStatus': booking.bookingStatus.apiValue,
      'paymentStatus': booking.paymentStatus.apiValue,
      'date': booking.date?.toIso8601String(),
      'startTime': booking.startTime,
      'endTime': booking.endTime,
      'trainingType': booking.trainingType?.apiValue,
      'vehicleSource': booking.vehicleSource?.apiValue,
      'lockedUntil': booking.lockedUntil?.toIso8601String(),
      'instructor': booking.instructor == null
          ? null
          : {
              'id': booking.instructor!.id,
              'name': booking.instructor!.name,
              'gender': booking.instructor!.gender.apiValue,
            },
      'vehicle': booking.vehicle == null
          ? null
          : {
              'id': booking.vehicle!.id,
              'source': booking.vehicle!.source?.apiValue,
            },
    };
  }

  StudentBookingEntity _bookingFromJson(Map<String, dynamic> json) {
    final bookingStatus = StudentBookingStatus.fromApi(
      json['bookingStatus']?.toString(),
    );
    final paymentStatus = StudentPaymentStatus.fromApi(
      json['paymentStatus']?.toString(),
    );
    if (bookingStatus == null || paymentStatus == null) {
      throw const FormatException('Invalid cached booking status');
    }
    final instructorJson = json['instructor'];
    final vehicleJson = json['vehicle'];
    return StudentBookingEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
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
          ? StudentBookingInstructorEntity(
              id: (instructorJson['id'] as num?)?.toInt() ?? 0,
              name: instructorJson['name']?.toString() ?? '',
              gender:
                  InstructorGender.fromApi(
                    instructorJson['gender']?.toString(),
                  ) ??
                  InstructorGender.male,
            )
          : null,
      vehicle: vehicleJson is Map
          ? StudentBookingVehicleEntity(
              id: (vehicleJson['id'] as num?)?.toInt() ?? 0,
              source: VehicleSource.fromApi(vehicleJson['source']?.toString()),
            )
          : null,
      lockedUntil: json['lockedUntil'] != null
          ? DateTime.tryParse(json['lockedUntil'].toString())
          : null,
    );
  }
}
