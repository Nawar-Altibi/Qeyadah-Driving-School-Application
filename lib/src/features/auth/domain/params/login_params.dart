import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable implements Cancelable {
  const LoginParams({
    required this.phone,
    required this.password,
    this.cancelRequestAdapter,
  });

  final String phone;
  final String password;
  @override
  final CancelRequestAdapter? cancelRequestAdapter;

  @override
  List<Object?> get props => [phone, password, cancelRequestAdapter];

  @override
  LoginParams copyWithCancelRequest(CancelRequestAdapter adapter) {
    return LoginParams(
      phone: phone,
      password: password,
      cancelRequestAdapter: adapter,
    );
  }
}
