class AuthSessionModel {
  const AuthSessionModel({
    required this.userId,
    required this.phone,
    required this.displayName,
    required this.roles,
    required this.permissions,
    required this.mustChangePassword,
    required this.accessToken,
    this.refreshToken,
    this.accountStatus = 'ACTIVE',
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      userId: (json['userId'] ?? json['id'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      displayName: (json['displayName'] ?? json['name'] ?? '').toString(),
      roles: _stringList(json['roles'] ?? json['role']),
      permissions: _stringList(json['permissions']),
      mustChangePassword: json['mustChangePassword'] == true,
      accessToken: (json['accessToken'] ?? '').toString(),
      refreshToken: json['refreshToken']?.toString(),
      accountStatus: (json['accountStatus'] ?? 'ACTIVE').toString(),
    );
  }

  final String userId;
  final String phone;
  final String displayName;
  final List<String> roles;
  final List<String> permissions;
  final bool mustChangePassword;
  final String accessToken;
  final String? refreshToken;
  final String accountStatus;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'phone': phone,
      'displayName': displayName,
      'roles': roles,
      'permissions': permissions,
      'mustChangePassword': mustChangePassword,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accountStatus': accountStatus,
    };
  }
}

List<String> _stringList(Object? value) {
  if (value is Iterable) {
    return value.map((item) => item.toString()).toList(growable: false);
  }
  if (value is String && value.trim().isNotEmpty) {
    return [value.trim()];
  }
  return const [];
}
