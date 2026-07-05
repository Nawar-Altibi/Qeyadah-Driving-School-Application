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
  });

  final String name;
  final String phone;
  final String email;
  final String code;
  final String password;
  final String? deviceName;

  @override
  List<Object?> get props => [name, phone, email, code, password, deviceName];
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
