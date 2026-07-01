enum UserRole {
  student('STUDENT'),
  instructor('INSTRUCTOR'),
  manager('MANAGER'),
  receptionist('RECEPTIONIST'),
  accountant('ACCOUNTANT'),
  unknown('UNKNOWN');

  const UserRole(this.apiValue);

  final String apiValue;
}

extension UserRoleX on UserRole {
  bool get canUseMobileApp =>
      this == UserRole.student || this == UserRole.instructor;

  static UserRole fromValue(
    String? value, {
    UserRole fallback = UserRole.unknown,
  }) {
    if (value == null || value.isEmpty) return fallback;
    final normalized = value.trim().toUpperCase();
    return UserRole.values.firstWhere(
      (role) =>
          role.apiValue == normalized || role.name.toUpperCase() == normalized,
      orElse: () => fallback,
    );
  }
}
