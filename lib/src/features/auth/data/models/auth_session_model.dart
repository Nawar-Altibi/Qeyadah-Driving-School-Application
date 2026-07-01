import 'package:json_annotation/json_annotation.dart';

part 'auth_session_model.g.dart';

@JsonSerializable()
class AuthSessionModel {
  const AuthSessionModel({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.role,
    required this.accessToken,
    this.refreshToken,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  final String userId;
  final String email;
  final String displayName;
  final String role;
  final String accessToken;
  final String? refreshToken;

  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);
}
