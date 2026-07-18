import 'package:coore/lib.dart';

sealed class AppFailure extends Failure {
  const AppFailure(super.message, {super.stackTrace});
}

final class FormatFailure extends AppFailure {
  const FormatFailure({String message = 'Format failure', super.stackTrace})
    : super(message);
}

final class BusinessFailure extends AppFailure {
  const BusinessFailure({String message = 'Business failure', super.stackTrace})
    : super(message);
}

final class AuthFailure extends AppFailure {
  const AuthFailure({String message = 'Auth failure', super.stackTrace})
    : super(message);
}

final class OperationCancelledFailure extends AppFailure {
  const OperationCancelledFailure({
    String message = 'Operation cancelled',
    super.stackTrace,
  }) : super(message);
}
