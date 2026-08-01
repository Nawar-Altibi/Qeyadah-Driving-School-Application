import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/entities/student_payment_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/params/student_payment_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/repositories/student_payment_repository.dart';

@injectable
class ConfirmStudentPaymentUseCase {
  const ConfirmStudentPaymentUseCase(this._repository);

  final StudentPaymentRepository _repository;

  FutureEither<StudentPaymentConfirmationEntity> call(
    ConfirmStudentPaymentParams params,
  ) {
    return _repository.confirmPayment(params);
  }
}
