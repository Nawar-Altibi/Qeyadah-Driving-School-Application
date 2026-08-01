import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';

class StudentPaymentScreenParams extends BaseScreenParams {
  const StudentPaymentScreenParams({required this.args});

  final StudentPaymentHoldArgs args;

  static const String argsExtraKey = 'studentPaymentHoldArgs';

  @override
  Map<String, Object> get extra => {argsExtraKey: args};

  @override
  List<Object?> get props => [args];
}

StudentPaymentHoldArgs? studentPaymentHoldArgsFromExtra(Object? extra) {
  if (extra is! Map) return null;
  final value = extra[StudentPaymentScreenParams.argsExtraKey];
  return value is StudentPaymentHoldArgs ? value : null;
}
