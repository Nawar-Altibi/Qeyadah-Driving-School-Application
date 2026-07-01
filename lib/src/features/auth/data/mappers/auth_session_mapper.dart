import 'package:qeyadah_mobile_app/src/features/auth/data/models/auth_session_model.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/entities/user_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

AuthSessionEntity authSessionModelToEntity(AuthSessionModel model) {
  return AuthSessionEntity(
    user: UserEntity(
      id: model.userId,
      email: model.email,
      displayName: model.displayName,
      role: UserRoleX.fromValue(model.role),
    ),
    accessToken: model.accessToken,
    refreshToken: model.refreshToken,
  );
}

AuthSessionModel authSessionEntityToModel(AuthSessionEntity entity) {
  return AuthSessionModel(
    userId: entity.user.id,
    email: entity.user.email,
    displayName: entity.user.displayName,
    role: entity.user.role.apiValue,
    accessToken: entity.accessToken,
    refreshToken: entity.refreshToken,
  );
}
