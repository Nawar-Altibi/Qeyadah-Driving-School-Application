import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class AuthConstants {
  static const int phoneLength = 10;
  static const int otpLength = 6;
  static const int minPasswordLength = 8;
  static const int otpResendCooldownSeconds = 120;
  static const String deviceName = 'Qeyadah mobile app';
}

abstract final class AuthCredentialsRules {
  static Either<Failure, String> validatePhone(String raw) {
    final phone = raw.trim();
    if (phone.length != AuthConstants.phoneLength) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.invalidPhoneLength),
      );
    }
    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.invalidPhoneFormat),
      );
    }
    return right(phone);
  }

  static Either<Failure, String> validateName(String raw) {
    final name = raw.trim();
    if (name.isEmpty) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.nameRequired),
      );
    }
    if (name.length > 100) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.nameTooLong),
      );
    }
    return right(name);
  }

  static Either<Failure, String> validateEmail(String raw) {
    final email = raw.trim();
    if (email.isEmpty) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.emailRequired),
      );
    }
    final isValid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    if (!isValid) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.invalidEmail),
      );
    }
    return right(email);
  }

  static Either<Failure, String> validatePassword(String raw) {
    final password = raw.trim();
    if (password.length < AuthConstants.minPasswordLength) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.weakPassword),
      );
    }
    return right(password);
  }

  static Either<Failure, String> validateOtp(String raw) {
    final code = raw.trim();
    if (code.length != AuthConstants.otpLength) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.invalidOtpLength),
      );
    }
    if (!RegExp(r'^\d+$').hasMatch(code)) {
      return left(
        const BusinessFailure(message: AuthValidationKeys.invalidOtpFormat),
      );
    }
    return right(code);
  }
}

abstract final class AuthValidationKeys {
  static const invalidPhoneLength = 'auth.invalid_phone_length';
  static const invalidPhoneFormat = 'auth.invalid_phone_format';
  static const invalidOtpLength = 'auth.invalid_otp_length';
  static const invalidOtpFormat = 'auth.invalid_otp_format';
  static const weakPassword = 'auth.weak_password';
  static const passwordMismatch = 'auth.password_mismatch';
  static const nameRequired = 'auth.name_required';
  static const nameTooLong = 'auth.name_too_long';
  static const emailRequired = 'auth.email_required';
  static const invalidEmail = 'auth.invalid_email';
}
