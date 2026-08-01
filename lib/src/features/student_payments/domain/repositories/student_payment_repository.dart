import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/entities/student_payment_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/params/student_payment_params.dart';

abstract interface class StudentPaymentRepository {
  FutureEither<StudentPaymentConfirmationEntity> confirmPayment(
    ConfirmStudentPaymentParams params,
  );
}
