import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.phone,
    required this.displayName,
    required this.roles,
    required this.permissions,
    required this.mustChangePassword,
  });

  final String id;
  final String phone;
  final String displayName;
  final List<UserRole> roles;
  final List<String> permissions;
  final bool mustChangePassword;

  UserRole get primaryRole => roles.firstWhere(
    (role) => role.canUseMobileApp,
    orElse: () => UserRole.unknown,
  );

  bool get canUseMobileApp => primaryRole.canUseMobileApp;

  @override
  List<Object?> get props => [
    id,
    phone,
    displayName,
    roles,
    permissions,
    mustChangePassword,
  ];
}
