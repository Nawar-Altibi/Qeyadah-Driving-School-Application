import 'package:equatable/equatable.dart';

class ForgotPasswordParams extends Equatable {
  const ForgotPasswordParams({required this.phone});

  final String phone;

  @override
  List<Object?> get props => [phone];
}

class VerifyPasswordResetOtpParams extends Equatable {
  const VerifyPasswordResetOtpParams({
    required this.phone,
    required this.code,
  });

  final String phone;
  final String code;

  @override
  List<Object?> get props => [phone, code];
}

class ResetPasswordParams extends Equatable {
  const ResetPasswordParams({
    required this.resetToken,
    required this.newPassword,
  });

  final String resetToken;
  final String newPassword;

  @override
  List<Object?> get props => [resetToken, newPassword];
}
