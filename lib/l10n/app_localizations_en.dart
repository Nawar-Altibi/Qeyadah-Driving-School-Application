// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Drive Wise';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailHint => 'student@example.com';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get password => 'Password';

  @override
  String get home => 'Home';

  @override
  String get sampleItemsTitle => 'Sample Items';

  @override
  String get sampleItemDetails => 'Item Details';

  @override
  String get retry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNoInternet =>
      'No internet connection. Check your network and try again.';

  @override
  String get errorRequestTimeout =>
      'The request timed out. Check your connection and try again.';

  @override
  String get errorValidation => 'Please check your input and try again.';

  @override
  String get errorUnauthorized => 'Session expired. Please sign in again.';

  @override
  String get errorForbidden =>
      'You do not have permission to perform this action.';

  @override
  String get errorNotFound => 'The requested resource was not found.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorFormat => 'Unable to process the response.';

  @override
  String errorBusiness(String message) {
    return '$message';
  }

  @override
  String get loginSubtitle =>
      'Sign in with your phone and password to follow your bookings and certificates.';

  @override
  String get loginButton => 'Sign in';

  @override
  String get loginEyebrow => 'Student portal';

  @override
  String get loginWelcomeTitle => 'Welcome back';

  @override
  String get loginSecureNote =>
      'Secure session — you can sign out from your profile page.';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get createStudentAccount => 'Create a new student account';

  @override
  String get phoneValidationError => 'Phone number must be 10 digits.';

  @override
  String get otpValidationError => 'Verification code must be 6 digits.';

  @override
  String get weakPasswordError => 'Password must be at least 8 characters.';

  @override
  String get passwordMismatchError => 'Passwords do not match.';

  @override
  String get nameRequiredError => 'Full name is required.';

  @override
  String get nameTooLongError => 'Name is too long.';

  @override
  String get emailValidationError => 'Enter a valid email address.';

  @override
  String get newPassword => 'New password';

  @override
  String get newPasswordTitle => 'Set a new password';

  @override
  String get newPasswordSubtitle =>
      'Choose a strong password for your account.';

  @override
  String get newPasswordScreenTitle => 'New password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get resetPassword => 'Update password';

  @override
  String get passwordResetSuccess =>
      'Password updated successfully. You can sign in now.';

  @override
  String get forgotPasswordOtpTitle => 'Verify your phone number';

  @override
  String get forgotPasswordOtpSubtitle =>
      'Enter the verification code sent to your phone';

  @override
  String get forgotPasswordResend => 'Didn\'t receive the code?';

  @override
  String forgotPasswordResendAction(String time) {
    return 'Resend in $time';
  }

  @override
  String get resendOtpNow => 'Resend code';

  @override
  String get otpResentSuccess => 'A new verification code was sent.';

  @override
  String get verifyOtp => 'Verify';

  @override
  String get forgotPasswordComingSoon =>
      'Password recovery will be available soon.';

  @override
  String get appBrandTagline => 'Driving school';

  @override
  String get loginDemoHint => 'Demo: 0999400001 / Test@12345';

  @override
  String get registerScreenTitle => 'Create student account';

  @override
  String get registerEyebrow => 'New account';

  @override
  String get registerWelcomeTitle => 'Start your journey with us';

  @override
  String get registerSubtitle =>
      'Create a student account with your name, phone number, email, and password, then activate it via OTP.';

  @override
  String get fullName => 'Full name';

  @override
  String get fullNameHint => 'Omar Al-Khatib';

  @override
  String get registerNextStepTitle => 'Next step';

  @override
  String get registerNextStepBody =>
      'After creating the account, we will send a 6-digit verification code to your email.';

  @override
  String get registerSubmitButton => 'Create account and send code';

  @override
  String get registerAlreadyHaveCode => 'I already have the verification code';

  @override
  String get registerOtpTimeoutProceed =>
      'The request took longer than expected, but a verification code may already be in your email. Enter it on the next screen.';

  @override
  String get confirmPhoneTitle => 'Confirm registration';

  @override
  String get otpEyebrow => 'OTP verification code';

  @override
  String get otpEnterTitle => 'Enter the sent code';

  @override
  String otpEnterSubtitle(String phone) {
    return 'We sent a 6-digit code to the email linked with $phone. This verification is required before entering the app.';
  }

  @override
  String get confirmAndEnter => 'Confirm number and enter the app';

  @override
  String get changePhone => 'Change phone number';

  @override
  String get forgotPasswordScreenTitle => 'Forgot password';

  @override
  String get accountRecoveryEyebrow => 'Account recovery';

  @override
  String get forgotPasswordTitle => 'Forgot your password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your phone number and we will send an OTP code to set a new password.';

  @override
  String get sendVerificationCode => 'Send verification code';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get resetPasswordEyebrow => 'Reset password';

  @override
  String get resetPasswordTitle => 'Verify then choose a new password';

  @override
  String get resetPasswordSubtitle =>
      'Enter the OTP sent to your account email, then set a new password.';

  @override
  String get forcePasswordChangeScreenTitle => 'Change password';

  @override
  String get forcePasswordChangeEyebrow => 'Required security step';

  @override
  String get forcePasswordChangeTitle => 'Set a new password';

  @override
  String get forcePasswordChangeSubtitle =>
      'Your account was created by the administration. Enter the OTP sent to your email and choose a new password before using the app.';

  @override
  String get savePasswordAndLogin => 'Save password and sign in';

  @override
  String get profileTitle => 'My account';

  @override
  String get profileName => 'Name';

  @override
  String get profilePhone => 'Phone number';

  @override
  String get refreshProfile => 'Refresh profile';

  @override
  String get mustChangePasswordNotice =>
      'You will be asked to change your password on next sign-in.';

  @override
  String get logoutCurrentDevice => 'Log out from this device';

  @override
  String get logoutAllDevices => 'Log out from all devices';

  @override
  String get backToHome => 'Back to home';

  @override
  String get splashLoading => 'Loading...';

  @override
  String offlineQueuePending(int count) {
    return '$count requests pending sync';
  }

  @override
  String get offlineQueueSyncing => 'Syncing offline requests...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get emptySampleItems => 'No items found';

  @override
  String itemIdLabel(int id) {
    return 'Item #$id';
  }

  @override
  String get studentHomeGuestName => 'Student';

  @override
  String studentHomeGreetingMorning(String name) {
    return 'Good morning, $name';
  }

  @override
  String studentHomeGreetingAfternoon(String name) {
    return 'Good afternoon, $name';
  }

  @override
  String studentHomeGreetingEvening(String name) {
    return 'Good evening, $name';
  }

  @override
  String get studentHomeNextLesson => 'Next lesson';

  @override
  String get studentHomeConfirmed => 'Confirmed';

  @override
  String get studentHomeInstructorMale => 'Instructor';

  @override
  String get studentHomeInstructorFemale => 'Instructor';

  @override
  String get studentHomeVehicle => 'Vehicle';

  @override
  String get studentHomeAutomatic => 'Automatic';

  @override
  String get studentHomeManual => 'Manual';

  @override
  String get studentHomeSchoolVehicle => 'School';

  @override
  String get studentHomeStudentVehicle => 'Student';

  @override
  String get studentHomeShowMeetingPoint => 'Show meeting point';

  @override
  String get studentHomePendingPaymentTitle => 'Booking awaiting payment';

  @override
  String studentHomePendingPaymentMessage(String time) {
    return 'You have $time to enter your ShamCash transaction ID before the slot is released.';
  }

  @override
  String get studentHomeQuickActions => 'Quick actions';

  @override
  String get studentHomeViewAll => 'View all';

  @override
  String get studentHomeNewBooking => 'Book a new session';

  @override
  String get studentHomeMyBookings => 'My bookings';

  @override
  String get studentHomeCertificateRequest => 'Certificate request';

  @override
  String get studentHomeTheorySimulation => 'Theory simulation';

  @override
  String get studentHomeTrainingProgress => 'Training progress';

  @override
  String studentHomeTrainingProgressDetail(int completed, int total) {
    return 'Completed $completed of $total hours';
  }

  @override
  String get studentHomeTrainingProgressFootnote =>
      'After completing training, administration will follow up on theory and practical exam appointments.';

  @override
  String get studentHomeNavBookings => 'My bookings';

  @override
  String get studentHomeNavCertificate => 'Certificate';

  @override
  String get studentHomeNavProfile => 'My account';

  @override
  String get studentHomeFeatureComingSoon =>
      'This feature will be available soon.';

  @override
  String get studentHomeNoNextLessonTitle => 'No confirmed lesson yet';

  @override
  String get studentHomeNoNextLessonBody =>
      'Create a booking and complete ShamCash payment to confirm it.';

  @override
  String get instructorWelcomeBackEyebrow => 'Welcome back';

  @override
  String instructorWelcomeBack(String name) {
    return '$name';
  }

  @override
  String get instructorGuestName => 'Instructor';

  @override
  String get instructorTodaySchedule => 'Today\'s schedule';

  @override
  String instructorSessionsCount(int count) {
    return '$count sessions';
  }

  @override
  String instructorTrainingHoursCount(int hours) {
    return '$hours training hours';
  }

  @override
  String instructorTrainingHoursDecimal(double hours) {
    return '$hours training hours';
  }

  @override
  String get instructorBookedLabel => 'booked';

  @override
  String get instructorDailyTimeline => 'Daily timeline';

  @override
  String get instructorLiveSchedule => 'Live schedule';

  @override
  String get instructorNoSessionsToday => 'No sessions on this day.';

  @override
  String get instructorBookingConfirmed => 'Confirmed';

  @override
  String get instructorBookingCompleted => 'Completed';

  @override
  String get instructorBookingNoShow => 'No show';

  @override
  String get instructorBookingCancelled => 'Cancelled';

  @override
  String get instructorBookingExpired => 'Expired';

  @override
  String get instructorBookingPendingPayment => 'Pending payment';

  @override
  String get instructorMinuteUnit => 'min';

  @override
  String instructorDurationHoursMinutes(int hours, int minutes) {
    return '$hours hours and $minutes minutes';
  }

  @override
  String instructorDurationHours(int hours) {
    return '$hours hours';
  }

  @override
  String instructorDurationMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String instructorCurrencyAmount(int amount) {
    return '$amount SYP';
  }

  @override
  String get instructorRequestLeave => 'Request leave';

  @override
  String get instructorNavSchedule => 'Schedule';

  @override
  String get instructorNavProfile => 'Profile';

  @override
  String get instructorFeatureComingSoon =>
      'This feature will be available soon.';

  @override
  String get instructorProfileTitle => 'Profile';

  @override
  String get instructorRoleLabel => 'Driving instructor';

  @override
  String get instructorProfileBio =>
      'I help students build confidence and safe driving habits, one session at a time.';

  @override
  String get instructorContactManagement => 'Contact management';

  @override
  String get instructorMetricMonthSessions => 'Month sessions';

  @override
  String get instructorMetricMonthEarnings => 'Month earnings';

  @override
  String get instructorMetricVehicle => 'Vehicle';

  @override
  String get instructorAccountPreferences => 'Account & preferences';

  @override
  String get instructorProfileData => 'Profile data';

  @override
  String get instructorSchedulePreferences => 'Schedule preferences';

  @override
  String get instructorLanguage => 'Language';

  @override
  String get instructorNotifications => 'Notifications';

  @override
  String get instructorAppVersion => 'Qeyadah Instructor · v2.4.0';

  @override
  String get instructorLeaveTitle => 'Request leave';

  @override
  String get instructorLeaveIntroTitle => 'Plan your leave time';

  @override
  String get instructorLeaveIntroBody =>
      'The app shows your registered leaves. New leave requests are submitted through management.';

  @override
  String get instructorLeaveHourlyTab => 'Hourly leave';

  @override
  String get instructorLeaveDailyTab => 'Daily leave';

  @override
  String get instructorLeaveAdminNoticeTitle => 'Leave requests via management';

  @override
  String get instructorLeaveAdminNoticeBody =>
      'Review your leaves here. To request a new leave, contact management.';

  @override
  String get instructorLeaveEmpty => 'No registered leaves in this category.';

  @override
  String instructorLeaveFullDay(String date) {
    return 'Full day · $date';
  }

  @override
  String instructorLeaveHourly(String date, String start, String end) {
    return '$date · $start to $end';
  }

  @override
  String get instructorCancel => 'Cancel';
}
