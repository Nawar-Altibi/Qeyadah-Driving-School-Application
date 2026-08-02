import 'package:equatable/equatable.dart';

class RequestRegistrationOtpParams extends Equatable {
  const RequestRegistrationOtpParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  final String name;
  final String phone;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, phone, email, password];
}

class RegisterStudentParams extends Equatable {
  const RegisterStudentParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.code,
    required this.password,
    this.deviceName,
    this.fcmToken,
    this.platform,
  });

  final String name;
  final String phone;
  final String email;
  final String code;
  final String password;
  final String? deviceName;
  final String? fcmToken;
  final String? platform;

  @override
  List<Object?> get props => [
    name,
    phone,
    email,
    code,
    password,
    deviceName,
    fcmToken,
    platform,
  ];
}

class RegisterDraft {
  const RegisterDraft({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  final String name;
  final String phone;
  final String email;
  final String password;
}
