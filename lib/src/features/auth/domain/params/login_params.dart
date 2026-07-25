import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable implements Cancelable {
  const LoginParams({
    required this.phone,
    required this.password,
    this.deviceName,
    this.fcmToken,
    this.platform,
    this.cancelRequestAdapter,
  });

  final String phone;
  final String password;
  final String? deviceName;
  final String? fcmToken;
  final String? platform;
  @override
  final CancelRequestAdapter? cancelRequestAdapter;

  @override
  List<Object?> get props => [
    phone,
    password,
    deviceName,
    fcmToken,
    platform,
    cancelRequestAdapter,
  ];

  @override
  LoginParams copyWithCancelRequest(CancelRequestAdapter adapter) {
    return LoginParams(
      phone: phone,
      password: password,
      deviceName: deviceName,
      fcmToken: fcmToken,
      platform: platform,
      cancelRequestAdapter: adapter,
    );
  }
}
