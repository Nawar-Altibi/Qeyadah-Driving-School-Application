import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/entities/user_entity.dart';

class AuthSessionEntity extends Equatable {
  const AuthSessionEntity({
    required this.user,
    required this.accessToken,
    this.refreshToken,
  });

  final UserEntity user;
  final String accessToken;
  final String? refreshToken;

  bool get isAuthenticated => accessToken.isNotEmpty;

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}
