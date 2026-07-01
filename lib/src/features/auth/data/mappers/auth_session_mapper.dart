import 'package:qeyadah_mobile_app/src/features/auth/data/models/auth_session_model.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/entities/user_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

AuthSessionEntity authSessionModelToEntity(AuthSessionModel model) {
  return AuthSessionEntity(
    user: UserEntity(
      id: model.userId,
      phone: model.phone,
      displayName: model.displayName,
      roles: model.roles.map(UserRoleX.fromValue).toList(growable: false),
      permissions: model.permissions,
      mustChangePassword: model.mustChangePassword,
    ),
    accessToken: model.accessToken,
    refreshToken: model.refreshToken,
  );
}

AuthSessionModel authSessionEntityToModel(AuthSessionEntity entity) {
  return AuthSessionModel(
    userId: entity.user.id,
    phone: entity.user.phone,
    displayName: entity.user.displayName,
    roles: entity.user.roles
        .map((role) => role.apiValue)
        .toList(growable: false),
    permissions: entity.user.permissions,
    mustChangePassword: entity.user.mustChangePassword,
    accessToken: entity.accessToken,
    refreshToken: entity.refreshToken,
  );
}
