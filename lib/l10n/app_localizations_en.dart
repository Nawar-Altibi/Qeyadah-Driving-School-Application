// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Qeyadah';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceSubtitle =>
      'Choose light, dark, or follow your device setting.';

  @override
  String get appearanceSystem => 'Auto';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceDark => 'Dark';

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
  String get appBrandTagline => 'Driving school';

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
  String get refreshProfile => 'Refresh profile';

  @override
  String get mustChangePasswordNotice =>
      'You will be asked to change your password on next sign-in.';

  @override
  String get logoutCurrentDevice => 'Log out from this device';

  @override
  String get logoutAllDevices => 'Log out from all devices';

  @override
  String get logoutConfirmTitle => 'Confirm logout';

  @override
  String get logoutConfirmMessage => 'Do you want to log out from this device?';

  @override
  String get logoutAllConfirmMessage =>
      'Do you want to log out from all devices?';

  @override
  String get logoutConfirmAction => 'Log out';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get splashLoading => 'Loading...';

  @override
  String offlineQueuePending(int count) {
    return '$count requests pending sync';
  }

  @override
  String get offlineQueueSyncing => 'Syncing offline requests...';

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
  String get studentHomeSchoolVehicle => 'School vehicle';

  @override
  String get studentHomeStudentVehicle => 'Student vehicle';

  @override
  String get studentHomeShowMeetingPoint => 'Show meeting point';

  @override
  String get studentHomePendingPaymentTitle => 'Booking awaiting payment';

  @override
  String studentHomePendingPaymentMessage(String time) {
    return 'You have $time to enter your ShamCash transaction ID before the slot is released.';
  }

  @override
  String get studentHomeBlockedTitle => 'Account restricted';

  @override
  String get studentHomeBlockedMessage =>
      'You can still view your existing bookings and certificates, but you cannot request new services until administration lifts the block. Please contact the school.';

  @override
  String get studentHomeQuickActions => 'Quick actions';

  @override
  String get studentHomeNewBooking => 'Book a new session';

  @override
  String get studentHomeMyBookings => 'My bookings';

  @override
  String get studentHomeCertificateRequest => 'Certificate request';

  @override
  String get studentHomeTheorySimulation => 'Theory test practice';

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
  String get studentHomePendingPaymentOpenBookings =>
      'You have a booking awaiting payment. Open My bookings to continue.';

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
  String get instructorViewDay => 'Day';

  @override
  String get instructorViewWeek => 'Week';

  @override
  String get instructorWeeklyBookings => 'Weekly bookings';

  @override
  String get instructorNoSessionsThisWeek => 'No sessions this week';

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
  String get instructorProfileData => 'Profile data';

  @override
  String get instructorProfileGender => 'Gender';

  @override
  String get instructorProfileGenderMale => 'Male';

  @override
  String get instructorProfileGenderFemale => 'Female';

  @override
  String get instructorProfileTrainingType => 'Training type';

  @override
  String get instructorProfileAccountStatus => 'Account status';

  @override
  String get instructorProfileStatusActive => 'Active';

  @override
  String get instructorProfileSessionWage => 'Session wage';

  @override
  String get instructorProfileTodayLessons => 'Today\'s lessons';

  @override
  String get instructorProfileLeaveStatus => 'Leave status';

  @override
  String get instructorProfileNoLeave => 'No current leave';

  @override
  String get instructorProfileFullDayLeave => 'Full-day leave';

  @override
  String get instructorProfilePartialLeave => 'Partial leave';

  @override
  String get instructorProfileSettings => 'Instructor settings';

  @override
  String get instructorNotifications => 'Notifications';

  @override
  String get instructorLeaveTitle => 'Leaves list';

  @override
  String get instructorLeaveIntroTitle => 'Your registered leaves';

  @override
  String get instructorLeaveIntroBody =>
      'Review the leave periods recorded for your schedule.';

  @override
  String get instructorLeaveAdminNoticeTitle => 'Leave requests via management';

  @override
  String get instructorLeaveAdminNoticeBody =>
      'Review your leaves here. To request a new leave, contact management.';

  @override
  String get instructorLeaveEmpty => 'No registered leaves.';

  @override
  String instructorLeaveFullDay(String date) {
    return 'Full day · $date';
  }

  @override
  String instructorLeaveHourly(String date, String start, String end) {
    return '$date · $start to $end';
  }

  @override
  String get instructorLeaveReasonLabel => 'Reason';

  @override
  String get instructorWeeklyScheduleTitle => 'Weekly schedule';

  @override
  String get instructorWeeklyScheduleSubtitle =>
      'Your registered working hours for each day.';

  @override
  String get instructorDaySaturday => 'Saturday';

  @override
  String get instructorDaySunday => 'Sunday';

  @override
  String get instructorDayMonday => 'Monday';

  @override
  String get instructorDayTuesday => 'Tuesday';

  @override
  String get instructorDayWednesday => 'Wednesday';

  @override
  String get instructorDayThursday => 'Thursday';

  @override
  String get instructorDayFriday => 'Friday';

  @override
  String get instructorDayOff => 'Day off';

  @override
  String get instructorDuesTitle => 'Unpaid dues';

  @override
  String get instructorDuesGrandTotal => 'Total dues';

  @override
  String get instructorDuesDailyDetails => 'Daily details';

  @override
  String get instructorDuesEmpty => 'No unpaid dues.';

  @override
  String instructorDuesLessonCount(int count) {
    return '$count sessions';
  }

  @override
  String get instructorEarningsTitle => 'Received earnings';

  @override
  String get instructorEarningsDayTotal => 'Day total';

  @override
  String get instructorEarningsMonthTotal => 'Month total';

  @override
  String get instructorEarningsSessions => 'Sessions';

  @override
  String get instructorEarningsEmpty => 'No earnings recorded for this period.';

  @override
  String get instructorEarningsPaidAt => 'Paid';

  @override
  String get instructorPeriodDay => 'Day';

  @override
  String get instructorPeriodMonth => 'Month';

  @override
  String get instructorPeriodPickDay => 'Select day';

  @override
  String get instructorPeriodPickMonth => 'Select month';

  @override
  String get instructorPeriodToday => 'Today';

  @override
  String get instructorPeriodThisMonth => 'This month';

  @override
  String get instructorPeriodHintDay =>
      'Step day by day, or tap the date to pick one.';

  @override
  String get instructorPeriodHintMonth =>
      'Step month by month, or tap the month to pick one.';

  @override
  String get instructorPeriodPrevious => 'Previous period';

  @override
  String get instructorPeriodNext => 'Next period';

  @override
  String get instructorLoadMore => 'Load more';

  @override
  String get instructorInvoicesTitle => 'Invoices';

  @override
  String get instructorInvoicesTotalReceived => 'Total received';

  @override
  String get instructorInvoicesCount => 'Invoices';

  @override
  String get instructorInvoicesSessions => 'Sessions';

  @override
  String get instructorInvoicesListTitle => 'Payout invoices';

  @override
  String get instructorInvoicesEmpty => 'No invoices recorded for this period.';

  @override
  String instructorInvoicesEntryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String get instructorInvoicesPaidAt => 'Paid';

  @override
  String get instructorInvoiceTypeLessons => 'Lessons';

  @override
  String get instructorInvoiceTypeBonus => 'Bonus';

  @override
  String get instructorPaymentMethodCash => 'Cash';

  @override
  String get instructorPaymentMethodShamCash => 'Sham Cash';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsInboxTitle => 'Notifications';

  @override
  String get notificationsInboxIntroTitle => 'Your notifications';

  @override
  String get notificationsInboxIntroBody =>
      'Stay up to date with bookings, payments, certificates, and schedule updates.';

  @override
  String get notificationsInboxListTitle => 'Recent';

  @override
  String get notificationsInboxEmpty => 'No notifications yet.';

  @override
  String get notificationsInboxLoadMore => 'Load more';

  @override
  String notificationsInboxUnreadCount(int count) {
    return '$count unread';
  }

  @override
  String get studentHomePendingPaymentCta => 'Tap to complete payment';

  @override
  String get studentBookingPreferencesTitle => 'New booking';

  @override
  String get studentBookingPreferencesIntroTitle => 'Choose your preferences';

  @override
  String get studentBookingPreferencesIntroBody =>
      'Select training type, vehicle, and instructor gender to see available slots.';

  @override
  String get studentBookingTrainingTypeLabel => 'Training type';

  @override
  String get studentBookingTrainingTypeManual => 'Manual';

  @override
  String get studentBookingTrainingTypeAutomatic => 'Automatic';

  @override
  String get studentBookingVehicleSourceLabel => 'Vehicle';

  @override
  String get studentBookingVehicleSourceSchool => 'School car';

  @override
  String get studentBookingVehicleSourceStudent => 'My own car';

  @override
  String get studentBookingInstructorGenderLabel => 'Instructor gender';

  @override
  String get studentBookingInstructorGenderMale => 'Male';

  @override
  String get studentBookingInstructorGenderFemale => 'Female';

  @override
  String get studentBookingContinueButton => 'Continue';

  @override
  String get studentBookingSlotsTitle => 'Available slots';

  @override
  String get studentBookingSlotsEmptyTitle => 'No slots available';

  @override
  String get studentBookingSlotsEmptyMessage =>
      'Try different preferences or check back later.';

  @override
  String get studentBookingSlotsSelectedHeading => 'Selected appointment';

  @override
  String get studentBookingSlotsContinueButton => 'Continue to review';

  @override
  String get studentBookingSlotsPricingTitle => 'Lesson pricing';

  @override
  String studentBookingSlotsLessonPrice(String amount) {
    return 'Lesson price: $amount';
  }

  @override
  String studentBookingSlotsDepositAmount(String amount) {
    return 'Required deposit: $amount';
  }

  @override
  String studentBookingSlotsDepositPercentage(int percent) {
    return '($percent% of the lesson price)';
  }

  @override
  String studentBookingSlotsLessonDuration(int minutes) {
    return 'Lesson duration: $minutes minutes';
  }

  @override
  String get studentBookingReviewTitle => 'Review booking';

  @override
  String get studentBookingReviewSummaryTitle => 'Booking summary';

  @override
  String get studentBookingReviewInstructorLabel => 'Instructor';

  @override
  String get studentBookingReviewDateLabel => 'Date';

  @override
  String get studentBookingReviewTimeLabel => 'Time';

  @override
  String get studentBookingReviewTrainingTypeLabel => 'Training type';

  @override
  String get studentBookingReviewVehicleSourceLabel => 'Vehicle';

  @override
  String get studentBookingReviewCreateButton => 'Confirm booking';

  @override
  String get studentBookingReviewCreateWithPaymentButton =>
      'Confirm and continue to payment';

  @override
  String get studentBookingReviewCreateWithoutPaymentButton =>
      'Confirm booking (no payment)';

  @override
  String get studentBookingReviewCreditBannerTitle => 'Saved deposit available';

  @override
  String studentBookingReviewCreditBannerMessage(String amount) {
    return 'You have a saved deposit of $amount. It will be used for this booking and you will not need to pay now.';
  }

  @override
  String get studentBookingReviewDepositBannerTitle => 'Deposit required';

  @override
  String studentBookingReviewDepositBannerMessage(String amount) {
    return 'Required deposit: $amount via ShamCash.';
  }

  @override
  String get studentBookingCreditSuccessTitle => 'Booking confirmed';

  @override
  String get studentBookingCreditSuccessMessage =>
      'Your booking was confirmed using your saved deposit. You can check any remaining amount (if any) in the booking details.';

  @override
  String get studentBookingCreditSuccessViewDetails => 'View booking details';

  @override
  String get studentBookingCreditSuccessBackHome => 'Back to home';

  @override
  String get studentBookingErrorSlotConflict =>
      'This slot was just booked by someone else. Please choose another one.';

  @override
  String get studentBookingErrorPendingPaymentExists =>
      'You already have a booking awaiting payment.';

  @override
  String get studentBookingErrorStudentTimeConflict =>
      'You already have another booking at this time. Please choose a different slot.';

  @override
  String get studentBookingErrorGenericConflict =>
      'Could not confirm the booking due to a conflict. Please choose another slot.';

  @override
  String get studentBookingErrorPaymentHoldIncomplete =>
      'Booking was created but payment details are incomplete. Please contact support.';

  @override
  String get studentBookingsTitle => 'My bookings';

  @override
  String get studentBookingsFilterAll => 'All';

  @override
  String get studentBookingsSearchHint => 'Search by instructor name';

  @override
  String get studentBookingsSortNewestFirst => 'Newest first';

  @override
  String get studentBookingsSortOldestFirst => 'Oldest first';

  @override
  String get studentBookingsEmptyTitle => 'No bookings yet';

  @override
  String get studentBookingsEmptyMessage =>
      'Your bookings will show up here once you book a lesson.';

  @override
  String studentBookingsRemainingAtSchool(String amount) {
    return 'Remainder $amount at school';
  }

  @override
  String studentBookingsCurrencyAmount(String amount) {
    return '$amount SYP';
  }

  @override
  String get studentBookingsStatusPendingPayment => 'Pending payment';

  @override
  String get studentBookingsStatusBooked => 'Booked';

  @override
  String get studentBookingsStatusCompleted => 'Completed';

  @override
  String get studentBookingsStatusCancelled => 'Cancelled';

  @override
  String get studentBookingsStatusExpired => 'Expired';

  @override
  String get studentBookingsStatusNoShow => 'No show';

  @override
  String get studentBookingsPaymentPendingDeposit => 'Deposit pending';

  @override
  String get studentBookingsPaymentDepositPaid => 'Deposit paid';

  @override
  String get studentBookingsPaymentFullyPaid => 'Fully paid';

  @override
  String get studentBookingsPaymentDepositNonRefundable =>
      'Deposit not refundable';

  @override
  String get studentBookingsPaymentDepositAvailableForRebooking =>
      'Deposit available for rebooking';

  @override
  String get studentBookingsPaymentDepositUsedInRebooking =>
      'Deposit used in rebooking';

  @override
  String get studentBookingsChargeUnpaid => 'Unpaid';

  @override
  String get studentBookingsChargePartiallyPaid => 'Partially paid';

  @override
  String get studentBookingsChargePaid => 'Paid';

  @override
  String get studentBookingsChargeCancelled => 'Cancelled';

  @override
  String get studentBookingDetailTitle => 'Booking details';

  @override
  String get studentBookingDetailCompletePayment => 'Complete payment';

  @override
  String get studentBookingDetailInstructorTitle => 'Instructor';

  @override
  String get studentBookingDetailVehicleTitle => 'Vehicle';

  @override
  String get studentBookingDetailOwnVehicleNote =>
      'You\'re using your own car for this lesson.';

  @override
  String get studentBookingDetailChargesTitle => 'Charges';

  @override
  String get studentBookingDetailChargesEmpty =>
      'No charges recorded for this booking yet.';

  @override
  String studentBookingDetailChargeAmountDue(String amount) {
    return 'Amount due: $amount';
  }

  @override
  String studentBookingDetailRemainingCallout(
    String paid,
    String total,
    String remaining,
  ) {
    return 'Paid $paid of $total — remainder $remaining at school';
  }

  @override
  String get studentBookingDetailCancelButton => 'Cancel booking';

  @override
  String get studentBookingDetailDepositRebookTitle =>
      'Deposit available for rebooking';

  @override
  String get studentBookingDetailDepositRebookMessage =>
      'Your deposit is being held and can be used toward a new booking.';

  @override
  String get studentBookingDetailDepositRebookCta => 'Book again';

  @override
  String get studentBookingDetailDepositLostTitle => 'Deposit not refundable';

  @override
  String get studentBookingDetailDepositLostMessage =>
      'This booking\'s deposit was not refunded per the cancellation policy.';

  @override
  String get studentBookingDetailPendingPaymentNoHoldMessage =>
      'This booking is awaiting payment, but the payment session could not be found. Please contact support.';

  @override
  String get studentBookingDetailHoldExpiredMessage =>
      'The payment window for this booking has expired.';

  @override
  String get studentBookingDetailHoldExpiredCta => 'New booking';

  @override
  String get studentBookingDetailCancelSuccessMessage =>
      'Your booking was cancelled.';

  @override
  String get studentBookingDetailCancelSheetTitle => 'Cancel this booking?';

  @override
  String get studentBookingDetailCancelSheetMessage =>
      'Please tell us why you\'re cancelling. This helps us improve.';

  @override
  String get studentBookingDetailCancelReasonLabel => 'Cancellation reason';

  @override
  String get studentBookingDetailCancelReasonHint => 'e.g. Schedule conflict';

  @override
  String get studentBookingDetailCancelReasonRequired =>
      'Please enter a cancellation reason.';

  @override
  String get studentBookingDetailCancelReasonTooLong =>
      'Cancellation reason must be at most 255 characters.';

  @override
  String get studentBookingDetailCancelSheetKeep => 'Keep booking';

  @override
  String get studentBookingDetailCancelSheetConfirm => 'Cancel booking';

  @override
  String get studentPaymentTitle => 'ShamCash payment';

  @override
  String get studentPaymentShamCashTitle => 'Complete your ShamCash transfer';

  @override
  String get studentPaymentDepositAmount => 'Deposit amount';

  @override
  String get studentPaymentReceiverName => 'Receiver name';

  @override
  String get studentPaymentExactAmountWarningTitle =>
      'Send the exact deposit amount';

  @override
  String studentPaymentExactAmountWarningMessage(String amount) {
    return 'Send exactly $amount. No more, no less. If you miss the lesson, the full deposit is forfeited and is not refunded. Any amount above the deposit is also forfeited.';
  }

  @override
  String get studentPaymentCountdownTitle => 'Time remaining';

  @override
  String studentPaymentCountdownMessage(String time) {
    return 'Confirm within $time or the slot will be released.';
  }

  @override
  String get studentPaymentExpiredTitle => 'Hold expired';

  @override
  String get studentPaymentExpiredMessage =>
      'This booking hold has expired. Please start a new booking.';

  @override
  String get studentPaymentTransactionIdLabel => 'ShamCash transaction ID';

  @override
  String get studentPaymentTransactionIdHint =>
      'Enter the 9-digit transaction ID from your ShamCash transfer.';

  @override
  String get studentPaymentConfirmButton => 'Confirm payment';

  @override
  String get studentPaymentBackToHomeButton => 'Back to home';

  @override
  String get studentPaymentSuccessMessage =>
      'Payment confirmed! Your booking is complete.';

  @override
  String get studentPaymentInvalidTransactionId =>
      'Transaction ID must be exactly 9 digits.';

  @override
  String get studentCertificatesTitle => 'Certificates';

  @override
  String get studentCertificatesActiveRequestTitle => 'Active request';

  @override
  String studentCertificatesCourseNumber(int courseNumber) {
    return 'Course number $courseNumber';
  }

  @override
  String studentCertificatesRequestId(String id) {
    return 'Request #$id';
  }

  @override
  String get studentCertificatesNewRequestFirst =>
      'Request a certificate for the first time';

  @override
  String get studentCertificatesNewRequestExtra =>
      'Request an additional certificate';

  @override
  String studentCertificatesAvailableTypes(String types) {
    return 'Available types: $types';
  }

  @override
  String get studentCertificatesBlockedWriteHint =>
      'New certificate requests are unavailable while your account is restricted.';

  @override
  String get studentCertificatesReexamTitle => 'Request a re-exam';

  @override
  String studentCertificatesReexamTitleTyped(String examType) {
    return 'Request a $examType re-exam';
  }

  @override
  String studentCertificatesReexamFee(String amount) {
    return 'Fee: $amount SYP';
  }

  @override
  String studentCertificatesExamScheduled(String label) {
    return 'Exam: $label';
  }

  @override
  String studentCertificatesRegistrationCloses(String label) {
    return 'Registration closes: $label';
  }

  @override
  String studentCertificatesRegistrationCountdown(String time) {
    return 'Time left to register: $time';
  }

  @override
  String get studentCertificatesReexamCta => 'Request re-exam';

  @override
  String get studentCertificatesStatusTitle => 'Certificate status';

  @override
  String get studentCertificatesStatusFallback =>
      'No certificate actions are available right now.';

  @override
  String get studentCertificatesExamTypeTheory => 'theory';

  @override
  String get studentCertificatesExamTypePractical => 'practical';

  @override
  String get studentCertificatesTransmissionManual => 'Manual';

  @override
  String get studentCertificatesTransmissionAutomatic => 'Automatic';

  @override
  String get studentCertificatesStatusWaitingForTrainingSchedule =>
      'Waiting for training schedule';

  @override
  String get studentCertificatesStatusInGovernmentTraining =>
      'In government training';

  @override
  String get studentCertificatesStatusWaitingForTheoreticalExam =>
      'Waiting for theoretical test';

  @override
  String get studentCertificatesStatusWaitingForPracticalExam =>
      'Waiting for practical test';

  @override
  String get studentCertificatesStatusCompleted => 'Completed';

  @override
  String get studentCertificatesStatusFailed => 'Failed';

  @override
  String get studentCertificatesStatusCancelled => 'Cancelled';

  @override
  String get studentCertificatesTimelineSubmitted => 'Request submitted';

  @override
  String get studentCertificatesTimelineGovTraining => 'Government training';

  @override
  String get studentCertificatesTimelineTheoryExam => 'Theoretical exam';

  @override
  String get studentCertificatesTimelinePracticalExam => 'Practical exam';

  @override
  String get studentCertificatesTimelineLicense => 'License issued';

  @override
  String get studentCertificatesCompletedCategoriesTitle => 'Licenses you hold';

  @override
  String get studentCertificatesHistoryTitle => 'Certificate history';

  @override
  String get studentCertificatesHistoryCta => 'View certificate history';

  @override
  String get studentCertificatesViewDetailsCta => 'View details';

  @override
  String get studentCertificatesDetailTitle => 'Certificate details';

  @override
  String get studentCertificatesFilterStatus => 'Status';

  @override
  String get studentCertificatesFilterAll => 'All statuses';

  @override
  String get studentCertificatesHistoryEmpty =>
      'No certificate requests found.';

  @override
  String get studentCertificatesLoadMore => 'Load more';

  @override
  String studentCertificatesCategory(String category) {
    return 'Category: $category';
  }

  @override
  String studentCertificatesRequestedAt(String date) {
    return 'Requested: $date';
  }

  @override
  String studentCertificatesTransmission(String type) {
    return 'Transmission: $type';
  }

  @override
  String get studentCertificatesDocumentsTitle => 'Documents';

  @override
  String get studentCertificatesPersonalPhoto => 'Personal photo';

  @override
  String get studentCertificatesIdFront => 'ID front';

  @override
  String get studentCertificatesIdBack => 'ID back';

  @override
  String get studentCertificatesSessionsTitle => 'Training sessions';

  @override
  String studentCertificatesSessionNumber(int number) {
    return 'Session $number';
  }

  @override
  String get studentCertificatesExamsTitle => 'Tests';

  @override
  String get studentCertificatesNotScheduled => 'Not scheduled';

  @override
  String get studentCertificatesExamResultPass => 'Passed';

  @override
  String get studentCertificatesExamResultFail => 'Failed';

  @override
  String get studentCertificatesExamResultAbsent => 'Absent';

  @override
  String get studentCertificatesChargesTitle => 'Charges';

  @override
  String studentCertificatesAmountDue(String amount) {
    return 'Amount due: $amount SYP';
  }

  @override
  String get studentCertificatesChargeReasonCertificateFee => 'Certificate fee';

  @override
  String get studentCertificatesChargeReasonReexamTheory =>
      'Theory re-exam fee';

  @override
  String get studentCertificatesChargeReasonReexamPractical =>
      'Practical re-exam fee';

  @override
  String get studentCertificatesStudentLabel => 'Student';

  @override
  String get studentCertificatesCategoryLabel => 'Category';

  @override
  String get studentCertificatesTransmissionLabel => 'Transmission';

  @override
  String get studentCertificatesCourseLabel => 'Course number';

  @override
  String get studentCertificatesSectionEmpty => 'No items available.';

  @override
  String get studentCertificatesSectionEmptyHint =>
      'Details will appear here when available.';

  @override
  String get studentCertificatesDocumentUnavailable => 'Not available to view';

  @override
  String get studentCertificatesNewTitle => 'New certificate request';

  @override
  String get studentCertificatesTransmissionChoice => 'Transmission type';

  @override
  String get studentCertificatesTransportRequested => 'I need school transport';

  @override
  String get studentCertificatesImagesTitle => 'Required photos';

  @override
  String get studentCertificatesImagesHint =>
      'JPEG, PNG, or WebP. Maximum 5 MB per image.';

  @override
  String get studentCertificatesFeeGuidance =>
      'Transfer approximately 600,000 SYP via ShamCash, then enter the transaction ID.';

  @override
  String get studentCertificatesSubmitNew => 'Submit certificate request';

  @override
  String get studentCertificatesNewSuccess =>
      'Your certificate request was submitted successfully.';

  @override
  String get studentCertificatesInvalidImage =>
      'Choose a JPEG, PNG, or WebP image.';

  @override
  String get studentCertificatesImageTooLarge =>
      'Each image must be 5 MB or smaller.';

  @override
  String get studentCertificatesReexamPayCta => 'Pay and register for re-exam';

  @override
  String get studentCertificatesReexamSuccess =>
      'Your re-exam registration was submitted successfully.';

  @override
  String get studentCertificatesRegistrationExpired =>
      'The re-exam registration deadline has passed.';

  @override
  String get studentTheoryTitle => 'Theory test practice';

  @override
  String get studentTheoryBeforeYouStartTitle => 'Before you start';

  @override
  String get studentTheoryIntroBody =>
      'Practice safety and mechanics questions in the style of the theory test. Answer each question, then review the explanation before moving on.';

  @override
  String studentTheoryQuestionCount(int count) {
    return '$count questions in this round';
  }

  @override
  String get studentTheoryStartButton => 'Start the test now';

  @override
  String studentTheoryProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get studentTheoryNextButton => 'Next';

  @override
  String get studentTheoryFinishButton => 'Finish';

  @override
  String get studentTheoryExplanationTitle => 'Explanation';

  @override
  String get studentTheoryResultsTitle => 'Test result';

  @override
  String get studentTheoryFinalScoreTitle => 'Final score';

  @override
  String studentTheoryScoreSummary(int score, int total) {
    return '$score / $total';
  }

  @override
  String get studentTheoryResultsBody =>
      'You can practice again with a new set of questions anytime.';

  @override
  String get studentTheoryPracticeAgainButton => 'New questions';

  @override
  String get studentTheoryBackToHomeButton => 'Back to home';

  @override
  String get studentTheoryCategorySigns => 'Traffic signs';

  @override
  String get studentTheoryCategorySafety => 'Safety';

  @override
  String get studentTheoryCategoryMechanics => 'Mechanics';

  @override
  String get studentTheoryCategoryUnknown => 'General';
}
