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

  /// No description provided for @errorBusiness.
  ///
  /// In en, this message translates to:
  /// **'{message}'**
  String errorBusiness(String message);

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

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a strong password for your account.'**
  String get newPasswordSubtitle;

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

  /// No description provided for @forgotPasswordOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your phone number'**
  String get forgotPasswordOtpTitle;

  /// No description provided for @forgotPasswordOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your phone'**
  String get forgotPasswordOtpSubtitle;

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

  /// No description provided for @forgotPasswordComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Password recovery will be available soon.'**
  String get forgotPasswordComingSoon;

  /// No description provided for @appBrandTagline.
  ///
  /// In en, this message translates to:
  /// **'Driving school'**
  String get appBrandTagline;

  /// No description provided for @loginDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Demo: 0999400001 / Test@12345'**
  String get loginDemoHint;

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

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileName;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get profilePhone;

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

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

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

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

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

  /// No description provided for @studentHomeQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get studentHomeQuickActions;

  /// No description provided for @studentHomeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get studentHomeViewAll;

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
  /// **'Theory simulation'**
  String get studentHomeTheorySimulation;

  /// No description provided for @studentHomeTrainingProgress.
  ///
  /// In en, this message translates to:
  /// **'Training progress'**
  String get studentHomeTrainingProgress;

  /// No description provided for @studentHomeTrainingProgressDetail.
  ///
  /// In en, this message translates to:
  /// **'Completed {completed} of {total} hours'**
  String studentHomeTrainingProgressDetail(int completed, int total);

  /// No description provided for @studentHomeTrainingProgressFootnote.
  ///
  /// In en, this message translates to:
  /// **'After completing training, administration will follow up on theory and practical exam appointments.'**
  String get studentHomeTrainingProgressFootnote;

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

  /// No description provided for @instructorLiveSchedule.
  ///
  /// In en, this message translates to:
  /// **'Live schedule'**
  String get instructorLiveSchedule;

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

  /// No description provided for @instructorRequestLeave.
  ///
  /// In en, this message translates to:
  /// **'Request leave'**
  String get instructorRequestLeave;

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

  /// No description provided for @instructorProfileBio.
  ///
  /// In en, this message translates to:
  /// **'I help students build confidence and safe driving habits, one session at a time.'**
  String get instructorProfileBio;

  /// No description provided for @instructorContactManagement.
  ///
  /// In en, this message translates to:
  /// **'Contact management'**
  String get instructorContactManagement;

  /// No description provided for @instructorMetricMonthSessions.
  ///
  /// In en, this message translates to:
  /// **'Month sessions'**
  String get instructorMetricMonthSessions;

  /// No description provided for @instructorMetricMonthEarnings.
  ///
  /// In en, this message translates to:
  /// **'Month earnings'**
  String get instructorMetricMonthEarnings;

  /// No description provided for @instructorMetricVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get instructorMetricVehicle;

  /// No description provided for @instructorAccountPreferences.
  ///
  /// In en, this message translates to:
  /// **'Account & preferences'**
  String get instructorAccountPreferences;

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

  /// No description provided for @instructorSchedulePreferences.
  ///
  /// In en, this message translates to:
  /// **'Schedule preferences'**
  String get instructorSchedulePreferences;

  /// No description provided for @instructorLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get instructorLanguage;

  /// No description provided for @instructorNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get instructorNotifications;

  /// No description provided for @instructorAppVersion.
  ///
  /// In en, this message translates to:
  /// **'Qeyadah Instructor · v2.4.0'**
  String get instructorAppVersion;

  /// No description provided for @instructorLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Request leave'**
  String get instructorLeaveTitle;

  /// No description provided for @instructorLeaveIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your leave time'**
  String get instructorLeaveIntroTitle;

  /// No description provided for @instructorLeaveIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a suitable period and we will check conflicts before sending the request to management.'**
  String get instructorLeaveIntroBody;

  /// No description provided for @instructorLeaveHourlyTab.
  ///
  /// In en, this message translates to:
  /// **'Hourly leave'**
  String get instructorLeaveHourlyTab;

  /// No description provided for @instructorLeaveDailyTab.
  ///
  /// In en, this message translates to:
  /// **'Daily leave'**
  String get instructorLeaveDailyTab;

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
  /// **'No registered leaves in this category.'**
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

  /// No description provided for @instructorAvailableSlot.
  ///
  /// In en, this message translates to:
  /// **'Available slot'**
  String get instructorAvailableSlot;

  /// No description provided for @instructorLeavePeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Leave period'**
  String get instructorLeavePeriodLabel;

  /// No description provided for @instructorLeaveDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get instructorLeaveDateLabel;

  /// No description provided for @instructorLeaveFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get instructorLeaveFromLabel;

  /// No description provided for @instructorLeaveToLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get instructorLeaveToLabel;

  /// No description provided for @instructorLeaveReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get instructorLeaveReasonLabel;

  /// No description provided for @instructorLeaveOptional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get instructorLeaveOptional;

  /// No description provided for @instructorLeaveReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Example: personal appointment'**
  String get instructorLeaveReasonHint;

  /// No description provided for @instructorLeaveRequestedDuration.
  ///
  /// In en, this message translates to:
  /// **'Requested duration'**
  String get instructorLeaveRequestedDuration;

  /// No description provided for @instructorLeaveNoConflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Period is available'**
  String get instructorLeaveNoConflictTitle;

  /// No description provided for @instructorLeaveNoConflictBody.
  ///
  /// In en, this message translates to:
  /// **'No lessons overlap the selected leave period.'**
  String get instructorLeaveNoConflictBody;

  /// No description provided for @instructorLeaveConflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking conflict detected'**
  String get instructorLeaveConflictTitle;

  /// No description provided for @instructorLeaveConflictBody.
  ///
  /// In en, this message translates to:
  /// **'Management will be notified about {count} conflicting booking(s) before approval.'**
  String instructorLeaveConflictBody(int count);

  /// No description provided for @instructorLeaveConflictBadge.
  ///
  /// In en, this message translates to:
  /// **'Conflict'**
  String get instructorLeaveConflictBadge;

  /// No description provided for @instructorLeaveCheckingConflicts.
  ///
  /// In en, this message translates to:
  /// **'Checking this day\'s bookings...'**
  String get instructorLeaveCheckingConflicts;

  /// No description provided for @instructorLeaveSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send request'**
  String get instructorLeaveSubmit;

  /// No description provided for @instructorCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get instructorCancel;
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
