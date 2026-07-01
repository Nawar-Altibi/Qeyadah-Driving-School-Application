import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
  });

  final String id;
  final String email;
  final String displayName;
  final UserRole role;

  @override
  List<Object?> get props => [id, email, displayName, role];
}
