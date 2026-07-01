enum UserRole { user, admin }

extension UserRoleX on UserRole {
  String get apiValue => name;

  static UserRole fromValue(
    String? value, {
    UserRole fallback = UserRole.user,
  }) {
    if (value == null || value.isEmpty) return fallback;
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => fallback,
    );
  }
}
