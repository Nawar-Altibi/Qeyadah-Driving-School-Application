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

  static const String instructorMeProfile = 'instructor/me/profile';
  static const String instructorMeSchedule = 'instructor/me/schedule';
  static const String instructorMeBookings = 'instructor/me/bookings';
  static const String instructorMeLeaves = 'instructor/me/leaves';
  static const String instructorMeDues = 'instructor/me/dues';
  static const String instructorMeEarnings = 'instructor/me/earnings';
  static const String instructorMePayments = 'instructor/me/payments';
  static const String instructorMeNotifications = 'instructor/me/notifications';

  static const String devicesToken = 'devices/token';
  static const String notifications = 'notifications';
  static const String notificationsUnreadCount = 'notifications/unread-count';
  static const String notificationsReadAll = 'notifications/read-all';
  static String notificationRead(int id) => 'notifications/$id/read';
}
