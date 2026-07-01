abstract final class Endpoints {
  static const String sampleItems = 'posts';
  static String sampleItemById(String id) => 'posts/$id';
  static const String authLogin = 'auth/login';
  static const String authRefresh = 'auth/refresh';
  static const String authRegisterRequestOtp = 'auth/register/request-otp';
  static const String authRegister = 'auth/register';
  static const String authForgotPassword = 'auth/forgot-password';
  static const String authVerifyOtp = 'auth/verify-otp';
  static const String authResetPassword = 'auth/reset-password';
  static const String authLogout = 'auth/logout';
  static const String authLogoutAll = 'auth/logout-all';
  static const String authMe = 'auth/me';
  static const String authMePermissions = 'auth/me/permissions';
}
