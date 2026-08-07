import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Qeyadah'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'student@example.com'**
  String get emailHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @sampleItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sample Items'**
  String get sampleItemsTitle;

  /// No description provided for @sampleItemDetails.
  ///
  /// In en, this message translates to:
  /// **'Item Details'**
  String get sampleItemDetails;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network and try again.'**
  String get errorNoInternet;

  /// No description provided for @errorRequestTimeout.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Check your connection and try again.'**
  String get errorRequestTimeout;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Please check your input and try again.'**
  String get errorValidation;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please sign in again.'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to perform this action.'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested resource was not found.'**
  String get errorNotFound;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServer;

  /// No description provided for @errorFormat.
  ///
  /// In en, this message translates to:
  /// **'Unable to process the response.'**
  String get errorFormat;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your phone and password to follow your bookings and certificates.'**
  String get loginSubtitle;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginButton;

  /// No description provided for @loginEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Student portal'**
  String get loginEyebrow;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeTitle;

  /// No description provided for @loginSecureNote.
  ///
  /// In en, this message translates to:
  /// **'Secure session — you can sign out from your profile page.'**
  String get loginSecureNote;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @createStudentAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new student account'**
  String get createStudentAccount;

  /// No description provided for @phoneValidationError.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 10 digits.'**
  String get phoneValidationError;

  /// No description provided for @otpValidationError.
  ///
  /// In en, this message translates to:
  /// **'Verification code must be 6 digits.'**
  String get otpValidationError;

  /// No description provided for @weakPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get weakPasswordError;

  /// No description provided for @passwordMismatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMismatchError;

  /// No description provided for @nameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Full name is required.'**
  String get nameRequiredError;

  /// No description provided for @nameTooLongError.
  ///
  /// In en, this message translates to:
  /// **'Name is too long.'**
  String get nameTooLongError;

  /// No description provided for @emailValidationError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get emailValidationError;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @newPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordScreenTitle;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get resetPassword;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully. You can sign in now.'**
  String get passwordResetSuccess;

  /// No description provided for @forgotPasswordResend.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get forgotPasswordResend;

  /// No description provided for @forgotPasswordResendAction.
  ///
  /// In en, this message translates to:
  /// **'Resend in {time}'**
  String forgotPasswordResendAction(String time);

  /// No description provided for @resendOtpNow.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendOtpNow;

  /// No description provided for @otpResentSuccess.
  ///
  /// In en, this message translates to:
  /// **'A new verification code was sent.'**
  String get otpResentSuccess;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyOtp;

  /// No description provided for @appBrandTagline.
  ///
  /// In en, this message translates to:
  /// **'Driving school'**
  String get appBrandTagline;

  /// No description provided for @registerScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create student account'**
  String get registerScreenTitle;

  /// No description provided for @registerEyebrow.
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get registerEyebrow;

  /// No description provided for @registerWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Start your journey with us'**
  String get registerWelcomeTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a student account with your name, phone number, email, and password, then activate it via OTP.'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Omar Al-Khatib'**
  String get fullNameHint;

  /// No description provided for @registerNextStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Next step'**
  String get registerNextStepTitle;

  /// No description provided for @registerNextStepBody.
  ///
  /// In en, this message translates to:
  /// **'After creating the account, we will send a 6-digit verification code to your email.'**
  String get registerNextStepBody;

  /// No description provided for @registerSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Create account and send code'**
  String get registerSubmitButton;

  /// No description provided for @registerAlreadyHaveCode.
  ///
  /// In en, this message translates to:
  /// **'I already have the verification code'**
  String get registerAlreadyHaveCode;

  /// No description provided for @registerOtpTimeoutProceed.
  ///
  /// In en, this message translates to:
  /// **'The request took longer than expected, but a verification code may already be in your email. Enter it on the next screen.'**
  String get registerOtpTimeoutProceed;

  /// No description provided for @confirmPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm registration'**
  String get confirmPhoneTitle;

  /// No description provided for @otpEyebrow.
  ///
  /// In en, this message translates to:
  /// **'OTP verification code'**
  String get otpEyebrow;

  /// No description provided for @otpEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the sent code'**
  String get otpEnterTitle;

  /// No description provided for @otpEnterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to the email linked with {phone}. This verification is required before entering the app.'**
  String otpEnterSubtitle(String phone);

  /// No description provided for @confirmAndEnter.
  ///
  /// In en, this message translates to:
  /// **'Confirm number and enter the app'**
  String get confirmAndEnter;

  /// No description provided for @changePhone.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get changePhone;

  /// No description provided for @forgotPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasswordScreenTitle;

  /// No description provided for @accountRecoveryEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Account recovery'**
  String get accountRecoveryEyebrow;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number and we will send an OTP code to set a new password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get sendVerificationCode;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @resetPasswordEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordEyebrow;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify then choose a new password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP sent to your account email, then set a new password.'**
  String get resetPasswordSubtitle;

  /// No description provided for @forcePasswordChangeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get forcePasswordChangeScreenTitle;

  /// No description provided for @forcePasswordChangeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Required security step'**
  String get forcePasswordChangeEyebrow;

  /// No description provided for @forcePasswordChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get forcePasswordChangeTitle;

  /// No description provided for @forcePasswordChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account was created by the administration. Enter the OTP sent to your email and choose a new password before using the app.'**
  String get forcePasswordChangeSubtitle;

  /// No description provided for @savePasswordAndLogin.
  ///
  /// In en, this message translates to:
  /// **'Save password and sign in'**
  String get savePasswordAndLogin;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get profileTitle;

  /// No description provided for @refreshProfile.
  ///
  /// In en, this message translates to:
  /// **'Refresh profile'**
  String get refreshProfile;

  /// No description provided for @mustChangePasswordNotice.
  ///
  /// In en, this message translates to:
  /// **'You will be asked to change your password on next sign-in.'**
  String get mustChangePasswordNotice;

  /// No description provided for @logoutCurrentDevice.
  ///
  /// In en, this message translates to:
  /// **'Log out from this device'**
  String get logoutCurrentDevice;

  /// No description provided for @logoutAllDevices.
  ///
  /// In en, this message translates to:
  /// **'Log out from all devices'**
  String get logoutAllDevices;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get splashLoading;

  /// No description provided for @offlineQueuePending.
  ///
  /// In en, this message translates to:
  /// **'{count} requests pending sync'**
  String offlineQueuePending(int count);

  /// No description provided for @offlineQueueSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing offline requests...'**
  String get offlineQueueSyncing;

  /// No description provided for @emptySampleItems.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get emptySampleItems;

  /// No description provided for @itemIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Item #{id}'**
  String itemIdLabel(int id);

  /// No description provided for @studentHomeGuestName.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get studentHomeGuestName;

  /// No description provided for @studentHomeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String studentHomeGreetingMorning(String name);

  /// No description provided for @studentHomeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String studentHomeGreetingAfternoon(String name);

  /// No description provided for @studentHomeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String studentHomeGreetingEvening(String name);

  /// No description provided for @studentHomeNextLesson.
  ///
  /// In en, this message translates to:
  /// **'Next lesson'**
  String get studentHomeNextLesson;

  /// No description provided for @studentHomeConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get studentHomeConfirmed;

  /// No description provided for @studentHomeInstructorMale.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get studentHomeInstructorMale;

  /// No description provided for @studentHomeInstructorFemale.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get studentHomeInstructorFemale;

  /// No description provided for @studentHomeVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get studentHomeVehicle;

  /// No description provided for @studentHomeAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get studentHomeAutomatic;

  /// No description provided for @studentHomeManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get studentHomeManual;

  /// No description provided for @studentHomeSchoolVehicle.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get studentHomeSchoolVehicle;

  /// No description provided for @studentHomeStudentVehicle.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get studentHomeStudentVehicle;

  /// No description provided for @studentHomeShowMeetingPoint.
  ///
  /// In en, this message translates to:
  /// **'Show meeting point'**
  String get studentHomeShowMeetingPoint;

  /// No description provided for @studentHomePendingPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking awaiting payment'**
  String get studentHomePendingPaymentTitle;

  /// No description provided for @studentHomePendingPaymentMessage.
  ///
  /// In en, this message translates to:
  /// **'You have {time} to enter your ShamCash transaction ID before the slot is released.'**
  String studentHomePendingPaymentMessage(String time);

  /// No description provided for @studentHomeBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account restricted'**
  String get studentHomeBlockedTitle;

  /// No description provided for @studentHomeBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'You can still view your existing bookings and certificates, but you cannot request new services until administration lifts the block. Please contact the school.'**
  String get studentHomeBlockedMessage;

  /// No description provided for @studentHomeQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get studentHomeQuickActions;

  /// No description provided for @studentHomeNewBooking.
  ///
  /// In en, this message translates to:
  /// **'Book a new session'**
  String get studentHomeNewBooking;

  /// No description provided for @studentHomeMyBookings.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get studentHomeMyBookings;

  /// No description provided for @studentHomeCertificateRequest.
  ///
  /// In en, this message translates to:
  /// **'Certificate request'**
  String get studentHomeCertificateRequest;

  /// No description provided for @studentHomeTheorySimulation.
  ///
  /// In en, this message translates to:
  /// **'Theory test practice'**
  String get studentHomeTheorySimulation;

  /// No description provided for @studentHomeNavBookings.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get studentHomeNavBookings;

  /// No description provided for @studentHomeNavCertificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get studentHomeNavCertificate;

  /// No description provided for @studentHomeNavProfile.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get studentHomeNavProfile;

  /// No description provided for @studentHomeFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This feature will be available soon.'**
  String get studentHomeFeatureComingSoon;

  /// No description provided for @studentHomeNoNextLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'No confirmed lesson yet'**
  String get studentHomeNoNextLessonTitle;

  /// No description provided for @studentHomeNoNextLessonBody.
  ///
  /// In en, this message translates to:
  /// **'Create a booking and complete ShamCash payment to confirm it.'**
  String get studentHomeNoNextLessonBody;

  /// No description provided for @studentHomePendingPaymentOpenBookings.
  ///
  /// In en, this message translates to:
  /// **'You have a booking awaiting payment. Open My bookings to continue.'**
  String get studentHomePendingPaymentOpenBookings;

  /// No description provided for @instructorWelcomeBackEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get instructorWelcomeBackEyebrow;

  /// No description provided for @instructorWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'{name}'**
  String instructorWelcomeBack(String name);

  /// No description provided for @instructorGuestName.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get instructorGuestName;

  /// No description provided for @instructorTodaySchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s schedule'**
  String get instructorTodaySchedule;

  /// No description provided for @instructorSessionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sessions'**
  String instructorSessionsCount(int count);

  /// No description provided for @instructorTrainingHoursCount.
  ///
  /// In en, this message translates to:
  /// **'{hours} training hours'**
  String instructorTrainingHoursCount(int hours);

  /// No description provided for @instructorTrainingHoursDecimal.
  ///
  /// In en, this message translates to:
  /// **'{hours} training hours'**
  String instructorTrainingHoursDecimal(double hours);

  /// No description provided for @instructorBookedLabel.
  ///
  /// In en, this message translates to:
  /// **'booked'**
  String get instructorBookedLabel;

  /// No description provided for @instructorDailyTimeline.
  ///
  /// In en, this message translates to:
  /// **'Daily timeline'**
  String get instructorDailyTimeline;

  /// No description provided for @instructorViewDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get instructorViewDay;

  /// No description provided for @instructorViewWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get instructorViewWeek;

  /// No description provided for @instructorWeeklyBookings.
  ///
  /// In en, this message translates to:
  /// **'Weekly bookings'**
  String get instructorWeeklyBookings;

  /// No description provided for @instructorNoSessionsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'No sessions this week'**
  String get instructorNoSessionsThisWeek;

  /// No description provided for @instructorNoSessionsToday.
  ///
  /// In en, this message translates to:
  /// **'No sessions on this day.'**
  String get instructorNoSessionsToday;

  /// No description provided for @instructorBookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get instructorBookingConfirmed;

  /// No description provided for @instructorBookingCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get instructorBookingCompleted;

  /// No description provided for @instructorBookingNoShow.
  ///
  /// In en, this message translates to:
  /// **'No show'**
  String get instructorBookingNoShow;

  /// No description provided for @instructorBookingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get instructorBookingCancelled;

  /// No description provided for @instructorBookingExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get instructorBookingExpired;

  /// No description provided for @instructorBookingPendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending payment'**
  String get instructorBookingPendingPayment;

  /// No description provided for @instructorMinuteUnit.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get instructorMinuteUnit;

  /// No description provided for @instructorDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours and {minutes} minutes'**
  String instructorDurationHoursMinutes(int hours, int minutes);

  /// No description provided for @instructorDurationHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours'**
  String instructorDurationHours(int hours);

  /// No description provided for @instructorDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String instructorDurationMinutes(int minutes);

  /// No description provided for @instructorCurrencyAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} SYP'**
  String instructorCurrencyAmount(int amount);

  /// No description provided for @instructorNavSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get instructorNavSchedule;

  /// No description provided for @instructorNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get instructorNavProfile;

  /// No description provided for @instructorFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This feature will be available soon.'**
  String get instructorFeatureComingSoon;

  /// No description provided for @instructorProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get instructorProfileTitle;

  /// No description provided for @instructorRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'Driving instructor'**
  String get instructorRoleLabel;

  /// No description provided for @instructorProfileData.
  ///
  /// In en, this message translates to:
  /// **'Profile data'**
  String get instructorProfileData;

  /// No description provided for @instructorProfileGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get instructorProfileGender;

  /// No description provided for @instructorProfileGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get instructorProfileGenderMale;

  /// No description provided for @instructorProfileGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get instructorProfileGenderFemale;

  /// No description provided for @instructorProfileTrainingType.
  ///
  /// In en, this message translates to:
  /// **'Training type'**
  String get instructorProfileTrainingType;

  /// No description provided for @instructorProfileAccountStatus.
  ///
  /// In en, this message translates to:
  /// **'Account status'**
  String get instructorProfileAccountStatus;

  /// No description provided for @instructorProfileStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get instructorProfileStatusActive;

  /// No description provided for @instructorProfileSessionWage.
  ///
  /// In en, this message translates to:
  /// **'Session wage'**
  String get instructorProfileSessionWage;

  /// No description provided for @instructorProfileTodayLessons.
  ///
  /// In en, this message translates to:
  /// **'Today\'s lessons'**
  String get instructorProfileTodayLessons;

  /// No description provided for @instructorProfileLeaveStatus.
  ///
  /// In en, this message translates to:
  /// **'Leave status'**
  String get instructorProfileLeaveStatus;

  /// No description provided for @instructorProfileNoLeave.
  ///
  /// In en, this message translates to:
  /// **'No current leave'**
  String get instructorProfileNoLeave;

  /// No description provided for @instructorProfileFullDayLeave.
  ///
  /// In en, this message translates to:
  /// **'Full-day leave'**
  String get instructorProfileFullDayLeave;

  /// No description provided for @instructorProfilePartialLeave.
  ///
  /// In en, this message translates to:
  /// **'Partial leave'**
  String get instructorProfilePartialLeave;

  /// No description provided for @instructorProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Instructor settings'**
  String get instructorProfileSettings;

  /// No description provided for @instructorNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get instructorNotifications;

  /// No description provided for @instructorLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaves list'**
  String get instructorLeaveTitle;

  /// No description provided for @instructorLeaveIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your registered leaves'**
  String get instructorLeaveIntroTitle;

  /// No description provided for @instructorLeaveIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Review the leave periods recorded for your schedule.'**
  String get instructorLeaveIntroBody;

  /// No description provided for @instructorLeaveAdminNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave requests via management'**
  String get instructorLeaveAdminNoticeTitle;

  /// No description provided for @instructorLeaveAdminNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'Review your leaves here. To request a new leave, contact management.'**
  String get instructorLeaveAdminNoticeBody;

  /// No description provided for @instructorLeaveEmpty.
  ///
  /// In en, this message translates to:
  /// **'No registered leaves.'**
  String get instructorLeaveEmpty;

  /// No description provided for @instructorLeaveFullDay.
  ///
  /// In en, this message translates to:
  /// **'Full day · {date}'**
  String instructorLeaveFullDay(String date);

  /// No description provided for @instructorLeaveHourly.
  ///
  /// In en, this message translates to:
  /// **'{date} · {start} to {end}'**
  String instructorLeaveHourly(String date, String start, String end);

  /// No description provided for @instructorLeaveReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get instructorLeaveReasonLabel;

  /// No description provided for @instructorWeeklyScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly schedule'**
  String get instructorWeeklyScheduleTitle;

  /// No description provided for @instructorWeeklyScheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your registered working hours for each day.'**
  String get instructorWeeklyScheduleSubtitle;

  /// No description provided for @instructorDaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get instructorDaySaturday;

  /// No description provided for @instructorDaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get instructorDaySunday;

  /// No description provided for @instructorDayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get instructorDayMonday;

  /// No description provided for @instructorDayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get instructorDayTuesday;

  /// No description provided for @instructorDayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get instructorDayWednesday;

  /// No description provided for @instructorDayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get instructorDayThursday;

  /// No description provided for @instructorDayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get instructorDayFriday;

  /// No description provided for @instructorDayOff.
  ///
  /// In en, this message translates to:
  /// **'Day off'**
  String get instructorDayOff;

  /// No description provided for @instructorDuesTitle.
  ///
  /// In en, this message translates to:
  /// **'Unpaid dues'**
  String get instructorDuesTitle;

  /// No description provided for @instructorDuesGrandTotal.
  ///
  /// In en, this message translates to:
  /// **'Total dues'**
  String get instructorDuesGrandTotal;

  /// No description provided for @instructorDuesDailyDetails.
  ///
  /// In en, this message translates to:
  /// **'Daily details'**
  String get instructorDuesDailyDetails;

  /// No description provided for @instructorDuesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No unpaid dues.'**
  String get instructorDuesEmpty;

  /// No description provided for @instructorDuesLessonCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sessions'**
  String instructorDuesLessonCount(int count);

  /// No description provided for @instructorEarningsTitle.
  ///
  /// In en, this message translates to:
  /// **'Received earnings'**
  String get instructorEarningsTitle;

  /// No description provided for @instructorEarningsDayTotal.
  ///
  /// In en, this message translates to:
  /// **'Day total'**
  String get instructorEarningsDayTotal;

  /// No description provided for @instructorEarningsMonthTotal.
  ///
  /// In en, this message translates to:
  /// **'Month total'**
  String get instructorEarningsMonthTotal;

  /// No description provided for @instructorEarningsSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get instructorEarningsSessions;

  /// No description provided for @instructorEarningsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No earnings recorded for this period.'**
  String get instructorEarningsEmpty;

  /// No description provided for @instructorEarningsPaidAt.
  ///
  /// In en, this message translates to:
  /// **'Paid at: {date}'**
  String instructorEarningsPaidAt(String date);

  /// No description provided for @instructorPeriodDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get instructorPeriodDay;

  /// No description provided for @instructorPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get instructorPeriodMonth;

  /// No description provided for @instructorPeriodPickDay.
  ///
  /// In en, this message translates to:
  /// **'Select day'**
  String get instructorPeriodPickDay;

  /// No description provided for @instructorPeriodPickMonth.
  ///
  /// In en, this message translates to:
  /// **'Select month'**
  String get instructorPeriodPickMonth;

  /// No description provided for @instructorPeriodToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get instructorPeriodToday;

  /// No description provided for @instructorPeriodThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get instructorPeriodThisMonth;

  /// No description provided for @instructorPeriodHintDay.
  ///
  /// In en, this message translates to:
  /// **'Step day by day, or tap the date to pick one.'**
  String get instructorPeriodHintDay;

  /// No description provided for @instructorPeriodHintMonth.
  ///
  /// In en, this message translates to:
  /// **'Step month by month, or tap the month to pick one.'**
  String get instructorPeriodHintMonth;

  /// No description provided for @instructorPeriodPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous period'**
  String get instructorPeriodPrevious;

  /// No description provided for @instructorPeriodNext.
  ///
  /// In en, this message translates to:
  /// **'Next period'**
  String get instructorPeriodNext;

  /// No description provided for @instructorLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get instructorLoadMore;

  /// No description provided for @instructorInvoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get instructorInvoicesTitle;

  /// No description provided for @instructorInvoicesTotalReceived.
  ///
  /// In en, this message translates to:
  /// **'Total received'**
  String get instructorInvoicesTotalReceived;

  /// No description provided for @instructorInvoicesCount.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get instructorInvoicesCount;

  /// No description provided for @instructorInvoicesSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get instructorInvoicesSessions;

  /// No description provided for @instructorInvoicesListTitle.
  ///
  /// In en, this message translates to:
  /// **'Payout invoices'**
  String get instructorInvoicesListTitle;

  /// No description provided for @instructorInvoicesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No invoices recorded for this period.'**
  String get instructorInvoicesEmpty;

  /// No description provided for @instructorInvoicesEntryCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 entry} other{{count} entries}}'**
  String instructorInvoicesEntryCount(int count);

  /// No description provided for @instructorInvoicesPaidAt.
  ///
  /// In en, this message translates to:
  /// **'Paid at: {date}'**
  String instructorInvoicesPaidAt(String date);

  /// No description provided for @instructorInvoiceTypeLessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get instructorInvoiceTypeLessons;

  /// No description provided for @instructorInvoiceTypeBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get instructorInvoiceTypeBonus;

  /// No description provided for @instructorPaymentMethodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get instructorPaymentMethodCash;

  /// No description provided for @instructorPaymentMethodShamCash.
  ///
  /// In en, this message translates to:
  /// **'Sham Cash'**
  String get instructorPaymentMethodShamCash;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsInboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsInboxTitle;

  /// No description provided for @notificationsInboxIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your notifications'**
  String get notificationsInboxIntroTitle;

  /// No description provided for @notificationsInboxIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Stay up to date with bookings, payments, certificates, and schedule updates.'**
  String get notificationsInboxIntroBody;

  /// No description provided for @notificationsInboxListTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get notificationsInboxListTitle;

  /// No description provided for @notificationsInboxEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get notificationsInboxEmpty;

  /// No description provided for @notificationsInboxLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get notificationsInboxLoadMore;

  /// No description provided for @notificationsInboxUnreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String notificationsInboxUnreadCount(int count);

  /// No description provided for @studentHomePendingPaymentCta.
  ///
  /// In en, this message translates to:
  /// **'Tap to complete payment'**
  String get studentHomePendingPaymentCta;

  /// No description provided for @studentBookingPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'New booking'**
  String get studentBookingPreferencesTitle;

  /// No description provided for @studentBookingPreferencesIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferences'**
  String get studentBookingPreferencesIntroTitle;

  /// No description provided for @studentBookingPreferencesIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Select training type, vehicle, and instructor gender to see available slots.'**
  String get studentBookingPreferencesIntroBody;

  /// No description provided for @studentBookingTrainingTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Training type'**
  String get studentBookingTrainingTypeLabel;

  /// No description provided for @studentBookingTrainingTypeManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get studentBookingTrainingTypeManual;

  /// No description provided for @studentBookingTrainingTypeAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get studentBookingTrainingTypeAutomatic;

  /// No description provided for @studentBookingVehicleSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get studentBookingVehicleSourceLabel;

  /// No description provided for @studentBookingVehicleSourceSchool.
  ///
  /// In en, this message translates to:
  /// **'School car'**
  String get studentBookingVehicleSourceSchool;

  /// No description provided for @studentBookingVehicleSourceStudent.
  ///
  /// In en, this message translates to:
  /// **'My own car'**
  String get studentBookingVehicleSourceStudent;

  /// No description provided for @studentBookingInstructorGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Instructor gender'**
  String get studentBookingInstructorGenderLabel;

  /// No description provided for @studentBookingInstructorGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get studentBookingInstructorGenderMale;

  /// No description provided for @studentBookingInstructorGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get studentBookingInstructorGenderFemale;

  /// No description provided for @studentBookingContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get studentBookingContinueButton;

  /// No description provided for @studentBookingSlotsTitle.
  ///
  /// In en, this message translates to:
  /// **'Available slots'**
  String get studentBookingSlotsTitle;

  /// No description provided for @studentBookingSlotsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No slots available'**
  String get studentBookingSlotsEmptyTitle;

  /// No description provided for @studentBookingSlotsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Try different preferences or check back later.'**
  String get studentBookingSlotsEmptyMessage;

  /// No description provided for @studentBookingSlotsSelectedHeading.
  ///
  /// In en, this message translates to:
  /// **'Selected appointment'**
  String get studentBookingSlotsSelectedHeading;

  /// No description provided for @studentBookingSlotsContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue to review'**
  String get studentBookingSlotsContinueButton;

  /// No description provided for @studentBookingReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review booking'**
  String get studentBookingReviewTitle;

  /// No description provided for @studentBookingReviewSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking summary'**
  String get studentBookingReviewSummaryTitle;

  /// No description provided for @studentBookingReviewInstructorLabel.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get studentBookingReviewInstructorLabel;

  /// No description provided for @studentBookingReviewDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get studentBookingReviewDateLabel;

  /// No description provided for @studentBookingReviewTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get studentBookingReviewTimeLabel;

  /// No description provided for @studentBookingReviewTrainingTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Training type'**
  String get studentBookingReviewTrainingTypeLabel;

  /// No description provided for @studentBookingReviewVehicleSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get studentBookingReviewVehicleSourceLabel;

  /// No description provided for @studentBookingReviewCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm booking'**
  String get studentBookingReviewCreateButton;

  /// No description provided for @studentBookingErrorSlotConflict.
  ///
  /// In en, this message translates to:
  /// **'This slot was just booked by someone else. Please choose another one.'**
  String get studentBookingErrorSlotConflict;

  /// No description provided for @studentBookingErrorPendingPaymentExists.
  ///
  /// In en, this message translates to:
  /// **'You already have a booking awaiting payment.'**
  String get studentBookingErrorPendingPaymentExists;

  /// No description provided for @studentBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get studentBookingsTitle;

  /// No description provided for @studentBookingsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get studentBookingsFilterAll;

  /// No description provided for @studentBookingsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by instructor name'**
  String get studentBookingsSearchHint;

  /// No description provided for @studentBookingsSortNewestFirst.
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get studentBookingsSortNewestFirst;

  /// No description provided for @studentBookingsSortOldestFirst.
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get studentBookingsSortOldestFirst;

  /// No description provided for @studentBookingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet'**
  String get studentBookingsEmptyTitle;

  /// No description provided for @studentBookingsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your bookings will show up here once you book a lesson.'**
  String get studentBookingsEmptyMessage;

  /// No description provided for @studentBookingsRemainingAtSchool.
  ///
  /// In en, this message translates to:
  /// **'Remainder {amount} at school'**
  String studentBookingsRemainingAtSchool(String amount);

  /// No description provided for @studentBookingsCurrencyAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} SYP'**
  String studentBookingsCurrencyAmount(String amount);

  /// No description provided for @studentBookingsStatusPendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending payment'**
  String get studentBookingsStatusPendingPayment;

  /// No description provided for @studentBookingsStatusBooked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get studentBookingsStatusBooked;

  /// No description provided for @studentBookingsStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get studentBookingsStatusCompleted;

  /// No description provided for @studentBookingsStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get studentBookingsStatusCancelled;

  /// No description provided for @studentBookingsStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get studentBookingsStatusExpired;

  /// No description provided for @studentBookingsStatusNoShow.
  ///
  /// In en, this message translates to:
  /// **'No show'**
  String get studentBookingsStatusNoShow;

  /// No description provided for @studentBookingsPaymentPendingDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit pending'**
  String get studentBookingsPaymentPendingDeposit;

  /// No description provided for @studentBookingsPaymentDepositPaid.
  ///
  /// In en, this message translates to:
  /// **'Deposit paid'**
  String get studentBookingsPaymentDepositPaid;

  /// No description provided for @studentBookingsPaymentFullyPaid.
  ///
  /// In en, this message translates to:
  /// **'Fully paid'**
  String get studentBookingsPaymentFullyPaid;

  /// No description provided for @studentBookingsPaymentDepositNonRefundable.
  ///
  /// In en, this message translates to:
  /// **'Deposit not refundable'**
  String get studentBookingsPaymentDepositNonRefundable;

  /// No description provided for @studentBookingsPaymentDepositAvailableForRebooking.
  ///
  /// In en, this message translates to:
  /// **'Deposit available for rebooking'**
  String get studentBookingsPaymentDepositAvailableForRebooking;

  /// No description provided for @studentBookingsPaymentDepositUsedInRebooking.
  ///
  /// In en, this message translates to:
  /// **'Deposit used in rebooking'**
  String get studentBookingsPaymentDepositUsedInRebooking;

  /// No description provided for @studentBookingsChargeUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get studentBookingsChargeUnpaid;

  /// No description provided for @studentBookingsChargePartiallyPaid.
  ///
  /// In en, this message translates to:
  /// **'Partially paid'**
  String get studentBookingsChargePartiallyPaid;

  /// No description provided for @studentBookingsChargePaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get studentBookingsChargePaid;

  /// No description provided for @studentBookingsChargeCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get studentBookingsChargeCancelled;

  /// No description provided for @studentBookingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking details'**
  String get studentBookingDetailTitle;

  /// No description provided for @studentBookingDetailCompletePayment.
  ///
  /// In en, this message translates to:
  /// **'Complete payment'**
  String get studentBookingDetailCompletePayment;

  /// No description provided for @studentBookingDetailInstructorTitle.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get studentBookingDetailInstructorTitle;

  /// No description provided for @studentBookingDetailVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get studentBookingDetailVehicleTitle;

  /// No description provided for @studentBookingDetailOwnVehicleNote.
  ///
  /// In en, this message translates to:
  /// **'You\'re using your own car for this lesson.'**
  String get studentBookingDetailOwnVehicleNote;

  /// No description provided for @studentBookingDetailChargesTitle.
  ///
  /// In en, this message translates to:
  /// **'Charges'**
  String get studentBookingDetailChargesTitle;

  /// No description provided for @studentBookingDetailChargesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No charges recorded for this booking yet.'**
  String get studentBookingDetailChargesEmpty;

  /// No description provided for @studentBookingDetailChargeAmountDue.
  ///
  /// In en, this message translates to:
  /// **'Amount due: {amount}'**
  String studentBookingDetailChargeAmountDue(String amount);

  /// No description provided for @studentBookingDetailRemainingCallout.
  ///
  /// In en, this message translates to:
  /// **'Paid {paid} of {total} — remainder {remaining} at school'**
  String studentBookingDetailRemainingCallout(
    String paid,
    String total,
    String remaining,
  );

  /// No description provided for @studentBookingDetailCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get studentBookingDetailCancelButton;

  /// No description provided for @studentBookingDetailDepositRebookTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit available for rebooking'**
  String get studentBookingDetailDepositRebookTitle;

  /// No description provided for @studentBookingDetailDepositRebookMessage.
  ///
  /// In en, this message translates to:
  /// **'Your deposit is being held and can be used toward a new booking.'**
  String get studentBookingDetailDepositRebookMessage;

  /// No description provided for @studentBookingDetailDepositRebookCta.
  ///
  /// In en, this message translates to:
  /// **'Book again'**
  String get studentBookingDetailDepositRebookCta;

  /// No description provided for @studentBookingDetailDepositLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit not refundable'**
  String get studentBookingDetailDepositLostTitle;

  /// No description provided for @studentBookingDetailDepositLostMessage.
  ///
  /// In en, this message translates to:
  /// **'This booking\'s deposit was not refunded per the cancellation policy.'**
  String get studentBookingDetailDepositLostMessage;

  /// No description provided for @studentBookingDetailPendingPaymentNoHoldMessage.
  ///
  /// In en, this message translates to:
  /// **'This booking is awaiting payment, but the payment session could not be found. Please contact support.'**
  String get studentBookingDetailPendingPaymentNoHoldMessage;

  /// No description provided for @studentBookingDetailHoldExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'The payment window for this booking has expired.'**
  String get studentBookingDetailHoldExpiredMessage;

  /// No description provided for @studentBookingDetailHoldExpiredCta.
  ///
  /// In en, this message translates to:
  /// **'New booking'**
  String get studentBookingDetailHoldExpiredCta;

  /// No description provided for @studentBookingDetailCancelSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your booking was cancelled.'**
  String get studentBookingDetailCancelSuccessMessage;

  /// No description provided for @studentBookingDetailCancelSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this booking?'**
  String get studentBookingDetailCancelSheetTitle;

  /// No description provided for @studentBookingDetailCancelSheetMessage.
  ///
  /// In en, this message translates to:
  /// **'Please tell us why you\'re cancelling. This helps us improve.'**
  String get studentBookingDetailCancelSheetMessage;

  /// No description provided for @studentBookingDetailCancelReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancellation reason'**
  String get studentBookingDetailCancelReasonLabel;

  /// No description provided for @studentBookingDetailCancelReasonHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Schedule conflict'**
  String get studentBookingDetailCancelReasonHint;

  /// No description provided for @studentBookingDetailCancelReasonRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a cancellation reason.'**
  String get studentBookingDetailCancelReasonRequired;

  /// No description provided for @studentBookingDetailCancelReasonTooLong.
  ///
  /// In en, this message translates to:
  /// **'Cancellation reason must be at most 255 characters.'**
  String get studentBookingDetailCancelReasonTooLong;

  /// No description provided for @studentBookingDetailCancelSheetKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep booking'**
  String get studentBookingDetailCancelSheetKeep;

  /// No description provided for @studentBookingDetailCancelSheetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get studentBookingDetailCancelSheetConfirm;

  /// No description provided for @studentPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'ShamCash payment'**
  String get studentPaymentTitle;

  /// No description provided for @studentPaymentShamCashTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your ShamCash transfer'**
  String get studentPaymentShamCashTitle;

  /// No description provided for @studentPaymentDepositAmount.
  ///
  /// In en, this message translates to:
  /// **'Deposit amount'**
  String get studentPaymentDepositAmount;

  /// No description provided for @studentPaymentReceiverName.
  ///
  /// In en, this message translates to:
  /// **'Receiver name'**
  String get studentPaymentReceiverName;

  /// No description provided for @studentPaymentCountdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Time remaining'**
  String get studentPaymentCountdownTitle;

  /// No description provided for @studentPaymentCountdownMessage.
  ///
  /// In en, this message translates to:
  /// **'Confirm within {time} or the slot will be released.'**
  String studentPaymentCountdownMessage(String time);

  /// No description provided for @studentPaymentExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Hold expired'**
  String get studentPaymentExpiredTitle;

  /// No description provided for @studentPaymentExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This booking hold has expired. Please start a new booking.'**
  String get studentPaymentExpiredMessage;

  /// No description provided for @studentPaymentTransactionIdLabel.
  ///
  /// In en, this message translates to:
  /// **'ShamCash transaction ID'**
  String get studentPaymentTransactionIdLabel;

  /// No description provided for @studentPaymentTransactionIdHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the 9-digit transaction ID from your ShamCash transfer.'**
  String get studentPaymentTransactionIdHint;

  /// No description provided for @studentPaymentConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm payment'**
  String get studentPaymentConfirmButton;

  /// No description provided for @studentPaymentBackToHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get studentPaymentBackToHomeButton;

  /// No description provided for @studentPaymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed! Your booking is complete.'**
  String get studentPaymentSuccessMessage;

  /// No description provided for @studentPaymentInvalidTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID must be exactly 9 digits.'**
  String get studentPaymentInvalidTransactionId;

  /// No description provided for @studentCertificatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get studentCertificatesTitle;

  /// No description provided for @studentCertificatesActiveRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Active request'**
  String get studentCertificatesActiveRequestTitle;

  /// No description provided for @studentCertificatesCourseNumber.
  ///
  /// In en, this message translates to:
  /// **'Course number {courseNumber}'**
  String studentCertificatesCourseNumber(int courseNumber);

  /// No description provided for @studentCertificatesRequestId.
  ///
  /// In en, this message translates to:
  /// **'Request #{id}'**
  String studentCertificatesRequestId(String id);

  /// No description provided for @studentCertificatesNewRequestFirst.
  ///
  /// In en, this message translates to:
  /// **'Request a certificate for the first time'**
  String get studentCertificatesNewRequestFirst;

  /// No description provided for @studentCertificatesNewRequestExtra.
  ///
  /// In en, this message translates to:
  /// **'Request an additional certificate'**
  String get studentCertificatesNewRequestExtra;

  /// No description provided for @studentCertificatesAvailableTypes.
  ///
  /// In en, this message translates to:
  /// **'Available types: {types}'**
  String studentCertificatesAvailableTypes(String types);

  /// No description provided for @studentCertificatesBlockedWriteHint.
  ///
  /// In en, this message translates to:
  /// **'New certificate requests are unavailable while your account is restricted.'**
  String get studentCertificatesBlockedWriteHint;

  /// No description provided for @studentCertificatesReexamTitle.
  ///
  /// In en, this message translates to:
  /// **'Request a re-exam'**
  String get studentCertificatesReexamTitle;

  /// No description provided for @studentCertificatesReexamTitleTyped.
  ///
  /// In en, this message translates to:
  /// **'Request a {examType} re-exam'**
  String studentCertificatesReexamTitleTyped(String examType);

  /// No description provided for @studentCertificatesReexamFee.
  ///
  /// In en, this message translates to:
  /// **'Fee: {amount} SYP'**
  String studentCertificatesReexamFee(String amount);

  /// No description provided for @studentCertificatesExamScheduled.
  ///
  /// In en, this message translates to:
  /// **'Exam: {label}'**
  String studentCertificatesExamScheduled(String label);

  /// No description provided for @studentCertificatesRegistrationCloses.
  ///
  /// In en, this message translates to:
  /// **'Registration closes: {label}'**
  String studentCertificatesRegistrationCloses(String label);

  /// No description provided for @studentCertificatesRegistrationCountdown.
  ///
  /// In en, this message translates to:
  /// **'Time left to register: {time}'**
  String studentCertificatesRegistrationCountdown(String time);

  /// No description provided for @studentCertificatesReexamCta.
  ///
  /// In en, this message translates to:
  /// **'Request re-exam'**
  String get studentCertificatesReexamCta;

  /// No description provided for @studentCertificatesStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate status'**
  String get studentCertificatesStatusTitle;

  /// No description provided for @studentCertificatesStatusFallback.
  ///
  /// In en, this message translates to:
  /// **'No certificate actions are available right now.'**
  String get studentCertificatesStatusFallback;

  /// No description provided for @studentCertificatesExamTypeTheory.
  ///
  /// In en, this message translates to:
  /// **'theory'**
  String get studentCertificatesExamTypeTheory;

  /// No description provided for @studentCertificatesExamTypePractical.
  ///
  /// In en, this message translates to:
  /// **'practical'**
  String get studentCertificatesExamTypePractical;

  /// No description provided for @studentCertificatesTransmissionManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get studentCertificatesTransmissionManual;

  /// No description provided for @studentCertificatesTransmissionAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get studentCertificatesTransmissionAutomatic;

  /// No description provided for @studentCertificatesStatusWaitingForTrainingSchedule.
  ///
  /// In en, this message translates to:
  /// **'Waiting for training schedule'**
  String get studentCertificatesStatusWaitingForTrainingSchedule;

  /// No description provided for @studentCertificatesStatusInGovernmentTraining.
  ///
  /// In en, this message translates to:
  /// **'In government training'**
  String get studentCertificatesStatusInGovernmentTraining;

  /// No description provided for @studentCertificatesStatusWaitingForTheoreticalExam.
  ///
  /// In en, this message translates to:
  /// **'Waiting for theoretical test'**
  String get studentCertificatesStatusWaitingForTheoreticalExam;

  /// No description provided for @studentCertificatesStatusWaitingForPracticalExam.
  ///
  /// In en, this message translates to:
  /// **'Waiting for practical test'**
  String get studentCertificatesStatusWaitingForPracticalExam;

  /// No description provided for @studentCertificatesStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get studentCertificatesStatusCompleted;

  /// No description provided for @studentCertificatesStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get studentCertificatesStatusFailed;

  /// No description provided for @studentCertificatesStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get studentCertificatesStatusCancelled;

  /// No description provided for @studentCertificatesTimelineSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Request submitted'**
  String get studentCertificatesTimelineSubmitted;

  /// No description provided for @studentCertificatesTimelineGovTraining.
  ///
  /// In en, this message translates to:
  /// **'Government training'**
  String get studentCertificatesTimelineGovTraining;

  /// No description provided for @studentCertificatesTimelineTheoryExam.
  ///
  /// In en, this message translates to:
  /// **'Theoretical exam'**
  String get studentCertificatesTimelineTheoryExam;

  /// No description provided for @studentCertificatesTimelinePracticalExam.
  ///
  /// In en, this message translates to:
  /// **'Practical exam'**
  String get studentCertificatesTimelinePracticalExam;

  /// No description provided for @studentCertificatesTimelineLicense.
  ///
  /// In en, this message translates to:
  /// **'License issued'**
  String get studentCertificatesTimelineLicense;

  /// No description provided for @studentCertificatesCompletedCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Licenses you hold'**
  String get studentCertificatesCompletedCategoriesTitle;

  /// No description provided for @studentCertificatesHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate history'**
  String get studentCertificatesHistoryTitle;

  /// No description provided for @studentCertificatesHistoryCta.
  ///
  /// In en, this message translates to:
  /// **'View certificate history'**
  String get studentCertificatesHistoryCta;

  /// No description provided for @studentCertificatesViewDetailsCta.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get studentCertificatesViewDetailsCta;

  /// No description provided for @studentCertificatesDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate details'**
  String get studentCertificatesDetailTitle;

  /// No description provided for @studentCertificatesFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get studentCertificatesFilterStatus;

  /// No description provided for @studentCertificatesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get studentCertificatesFilterAll;

  /// No description provided for @studentCertificatesHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No certificate requests found.'**
  String get studentCertificatesHistoryEmpty;

  /// No description provided for @studentCertificatesLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get studentCertificatesLoadMore;

  /// No description provided for @studentCertificatesCategory.
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String studentCertificatesCategory(String category);

  /// No description provided for @studentCertificatesRequestedAt.
  ///
  /// In en, this message translates to:
  /// **'Requested: {date}'**
  String studentCertificatesRequestedAt(String date);

  /// No description provided for @studentCertificatesTransmission.
  ///
  /// In en, this message translates to:
  /// **'Transmission: {type}'**
  String studentCertificatesTransmission(String type);

  /// No description provided for @studentCertificatesDocumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get studentCertificatesDocumentsTitle;

  /// No description provided for @studentCertificatesPersonalPhoto.
  ///
  /// In en, this message translates to:
  /// **'Personal photo'**
  String get studentCertificatesPersonalPhoto;

  /// No description provided for @studentCertificatesIdFront.
  ///
  /// In en, this message translates to:
  /// **'ID front'**
  String get studentCertificatesIdFront;

  /// No description provided for @studentCertificatesIdBack.
  ///
  /// In en, this message translates to:
  /// **'ID back'**
  String get studentCertificatesIdBack;

  /// No description provided for @studentCertificatesSessionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Training sessions'**
  String get studentCertificatesSessionsTitle;

  /// No description provided for @studentCertificatesSessionNumber.
  ///
  /// In en, this message translates to:
  /// **'Session {number}'**
  String studentCertificatesSessionNumber(int number);

  /// No description provided for @studentCertificatesExamsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get studentCertificatesExamsTitle;

  /// No description provided for @studentCertificatesNotScheduled.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled'**
  String get studentCertificatesNotScheduled;

  /// No description provided for @studentCertificatesExamResultPass.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get studentCertificatesExamResultPass;

  /// No description provided for @studentCertificatesExamResultFail.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get studentCertificatesExamResultFail;

  /// No description provided for @studentCertificatesExamResultAbsent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get studentCertificatesExamResultAbsent;

  /// No description provided for @studentCertificatesChargesTitle.
  ///
  /// In en, this message translates to:
  /// **'Charges'**
  String get studentCertificatesChargesTitle;

  /// No description provided for @studentCertificatesAmountDue.
  ///
  /// In en, this message translates to:
  /// **'Amount due: {amount} SYP'**
  String studentCertificatesAmountDue(String amount);

  /// No description provided for @studentCertificatesChargeReasonCertificateFee.
  ///
  /// In en, this message translates to:
  /// **'Certificate fee'**
  String get studentCertificatesChargeReasonCertificateFee;

  /// No description provided for @studentCertificatesChargeReasonReexamTheory.
  ///
  /// In en, this message translates to:
  /// **'Theory re-exam fee'**
  String get studentCertificatesChargeReasonReexamTheory;

  /// No description provided for @studentCertificatesChargeReasonReexamPractical.
  ///
  /// In en, this message translates to:
  /// **'Practical re-exam fee'**
  String get studentCertificatesChargeReasonReexamPractical;

  /// No description provided for @studentCertificatesStudentLabel.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get studentCertificatesStudentLabel;

  /// No description provided for @studentCertificatesCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get studentCertificatesCategoryLabel;

  /// No description provided for @studentCertificatesTransmissionLabel.
  ///
  /// In en, this message translates to:
  /// **'Transmission'**
  String get studentCertificatesTransmissionLabel;

  /// No description provided for @studentCertificatesCourseLabel.
  ///
  /// In en, this message translates to:
  /// **'Course number'**
  String get studentCertificatesCourseLabel;

  /// No description provided for @studentCertificatesSectionEmpty.
  ///
  /// In en, this message translates to:
  /// **'No items available.'**
  String get studentCertificatesSectionEmpty;

  /// No description provided for @studentCertificatesSectionEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Details will appear here when available.'**
  String get studentCertificatesSectionEmptyHint;

  /// No description provided for @studentCertificatesDocumentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Not available to view'**
  String get studentCertificatesDocumentUnavailable;

  /// No description provided for @studentCertificatesNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New certificate request'**
  String get studentCertificatesNewTitle;

  /// No description provided for @studentCertificatesTransmissionChoice.
  ///
  /// In en, this message translates to:
  /// **'Transmission type'**
  String get studentCertificatesTransmissionChoice;

  /// No description provided for @studentCertificatesTransportRequested.
  ///
  /// In en, this message translates to:
  /// **'I need school transport'**
  String get studentCertificatesTransportRequested;

  /// No description provided for @studentCertificatesImagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Required photos'**
  String get studentCertificatesImagesTitle;

  /// No description provided for @studentCertificatesImagesHint.
  ///
  /// In en, this message translates to:
  /// **'JPEG, PNG, or WebP. Maximum 5 MB per image.'**
  String get studentCertificatesImagesHint;

  /// No description provided for @studentCertificatesFeeGuidance.
  ///
  /// In en, this message translates to:
  /// **'Transfer approximately 600,000 SYP via ShamCash, then enter the transaction ID.'**
  String get studentCertificatesFeeGuidance;

  /// No description provided for @studentCertificatesSubmitNew.
  ///
  /// In en, this message translates to:
  /// **'Submit certificate request'**
  String get studentCertificatesSubmitNew;

  /// No description provided for @studentCertificatesNewSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your certificate request was submitted successfully.'**
  String get studentCertificatesNewSuccess;

  /// No description provided for @studentCertificatesInvalidImage.
  ///
  /// In en, this message translates to:
  /// **'Choose a JPEG, PNG, or WebP image.'**
  String get studentCertificatesInvalidImage;

  /// No description provided for @studentCertificatesImageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Each image must be 5 MB or smaller.'**
  String get studentCertificatesImageTooLarge;

  /// No description provided for @studentCertificatesReexamPayCta.
  ///
  /// In en, this message translates to:
  /// **'Pay and register for re-exam'**
  String get studentCertificatesReexamPayCta;

  /// No description provided for @studentCertificatesReexamSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your re-exam registration was submitted successfully.'**
  String get studentCertificatesReexamSuccess;

  /// No description provided for @studentCertificatesRegistrationExpired.
  ///
  /// In en, this message translates to:
  /// **'The re-exam registration deadline has passed.'**
  String get studentCertificatesRegistrationExpired;

  /// No description provided for @studentTheoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Theory test practice'**
  String get studentTheoryTitle;

  /// No description provided for @studentTheoryBeforeYouStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you start'**
  String get studentTheoryBeforeYouStartTitle;

  /// No description provided for @studentTheoryIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Practice safety and mechanics questions in the style of the theory test. Answer each question, then review the explanation before moving on.'**
  String get studentTheoryIntroBody;

  /// No description provided for @studentTheoryQuestionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} questions in this round'**
  String studentTheoryQuestionCount(int count);

  /// No description provided for @studentTheoryStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start the test now'**
  String get studentTheoryStartButton;

  /// No description provided for @studentTheoryProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String studentTheoryProgress(int current, int total);

  /// No description provided for @studentTheoryNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get studentTheoryNextButton;

  /// No description provided for @studentTheoryFinishButton.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get studentTheoryFinishButton;

  /// No description provided for @studentTheoryExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get studentTheoryExplanationTitle;

  /// No description provided for @studentTheoryResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Test result'**
  String get studentTheoryResultsTitle;

  /// No description provided for @studentTheoryFinalScoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Final score'**
  String get studentTheoryFinalScoreTitle;

  /// No description provided for @studentTheoryScoreSummary.
  ///
  /// In en, this message translates to:
  /// **'{score} / {total}'**
  String studentTheoryScoreSummary(int score, int total);

  /// No description provided for @studentTheoryResultsBody.
  ///
  /// In en, this message translates to:
  /// **'You can practice again with a new set of questions anytime.'**
  String get studentTheoryResultsBody;

  /// No description provided for @studentTheoryPracticeAgainButton.
  ///
  /// In en, this message translates to:
  /// **'New questions'**
  String get studentTheoryPracticeAgainButton;

  /// No description provided for @studentTheoryBackToHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get studentTheoryBackToHomeButton;

  /// No description provided for @studentTheoryCategorySigns.
  ///
  /// In en, this message translates to:
  /// **'Traffic signs'**
  String get studentTheoryCategorySigns;

  /// No description provided for @studentTheoryCategorySafety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get studentTheoryCategorySafety;

  /// No description provided for @studentTheoryCategoryMechanics.
  ///
  /// In en, this message translates to:
  /// **'Mechanics'**
  String get studentTheoryCategoryMechanics;

  /// No description provided for @studentTheoryCategoryUnknown.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get studentTheoryCategoryUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
