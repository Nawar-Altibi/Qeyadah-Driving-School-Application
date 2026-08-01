import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/entities/student_payment_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/params/student_payment_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';

abstract interface class StudentPaymentRemoteDataSource {
  RemoteResponse<StudentPaymentConfirmationEntity> confirmPayment(
    ConfirmStudentPaymentParams params,
  );
}

@LazySingleton(as: StudentPaymentRemoteDataSource)
class StudentPaymentRemoteDataSourceImpl
    implements StudentPaymentRemoteDataSource {
  StudentPaymentRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<StudentPaymentConfirmationEntity> confirmPayment(
    ConfirmStudentPaymentParams params,
  ) async {
    final response = await _apiHandler.post(
      Endpoints.studentBookingConfirmPayment(params.bookingId),
      body: {'transactionId': params.transactionId},
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(
          _confirmationFromJson(_unwrapData(json), params.bookingId),
        );
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse payment confirmation response',
          ),
        );
      }
    });
  }

  StudentPaymentConfirmationEntity _confirmationFromJson(
    Map<String, dynamic> json,
    int fallbackBookingId,
  ) {
    final bookingJson = json['booking'];
    final source = bookingJson is Map
        ? Map<String, dynamic>.from(bookingJson)
        : json;
    final bookingStatus = StudentBookingStatus.fromApi(
      source['bookingStatus']?.toString(),
    );
    final paymentStatus = StudentPaymentStatus.fromApi(
      source['paymentStatus']?.toString(),
    );
    if (bookingStatus == null || paymentStatus == null) {
      throw const FormatException('Invalid payment confirmation payload');
    }
    final rawId = source['id'] ?? source['bookingId'];
    return StudentPaymentConfirmationEntity(
      bookingId: rawId != null
          ? (int.tryParse(rawId.toString()) ?? fallbackBookingId)
          : fallbackBookingId,
      bookingStatus: bookingStatus,
      paymentStatus: paymentStatus,
    );
  }

  Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    return json;
  }
}
