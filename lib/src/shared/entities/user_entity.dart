import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/account_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.phone,
    required this.displayName,
    required this.roles,
    required this.permissions,
    required this.mustChangePassword,
    required this.accountStatus,
  });

  final String id;
  final String phone;
  final String displayName;
  final List<UserRole> roles;
  final List<String> permissions;
  final bool mustChangePassword;
  final AccountStatus accountStatus;

  UserRole get primaryRole => roles.firstWhere(
    (role) => role.canUseMobileApp,
    orElse: () => UserRole.unknown,
  );

  bool get canUseMobileApp => primaryRole.canUseMobileApp;

  bool get isBlocked => accountStatus == AccountStatus.blocked;

  @override
  List<Object?> get props => [
    id,
    phone,
    displayName,
    roles,
    permissions,
    mustChangePassword,
    accountStatus,
  ];
}
