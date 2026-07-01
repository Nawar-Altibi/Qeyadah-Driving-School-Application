import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

class PermissionGuard {
  const PermissionGuard();

  bool canAccess({required UserRole userRole, required UserRole requiredRole}) {
    if (requiredRole == UserRole.user) return true;
    return userRole == UserRole.admin;
  }
}

class PermissionRequirement extends Equatable {
  const PermissionRequirement(this.requiredRole);

  final UserRole requiredRole;

  @override
  List<Object?> get props => [requiredRole];
}
