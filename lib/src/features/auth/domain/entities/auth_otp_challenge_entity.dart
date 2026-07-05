import 'package:equatable/equatable.dart';

class AuthOtpChallengeEntity extends Equatable {
  const AuthOtpChallengeEntity({
    required this.message,
    this.developmentCode,
  });

  final String message;
  final String? developmentCode;

  @override
  List<Object?> get props => [message, developmentCode];
}
