// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'قيادة';

  @override
  String get welcome => 'مرحباً';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get emailHint => 'student@example.com';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get password => 'كلمة المرور';

  @override
  String get home => 'الرئيسية';

  @override
  String get sampleItemsTitle => 'عناصر تجريبية';

  @override
  String get sampleItemDetails => 'تفاصيل العنصر';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get errorGeneric => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get errorNoInternet =>
      'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.';

  @override
  String get errorRequestTimeout =>
      'انتهت مهلة الطلب. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get errorValidation => 'يرجى التحقق من المدخلات والمحاولة مرة أخرى.';

  @override
  String get errorUnauthorized => 'انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get errorForbidden => 'ليس لديك صلاحية لتنفيذ هذا الإجراء.';

  @override
  String get errorNotFound => 'المورد المطلوب غير موجود.';

  @override
  String get errorServer => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get errorFormat => 'تعذر معالجة الاستجابة.';

  @override
  String errorBusiness(String message) {
    return '$message';
  }

  @override
  String get loginSubtitle =>
      'سجّل الدخول برقم الهاتف وكلمة المرور لمتابعة حجوزاتك وشهاداتك.';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginEyebrow => 'بوابة الطالب';

  @override
  String get loginWelcomeTitle => 'أهلاً بعودتك';

  @override
  String get loginSecureNote => 'جلسة آمنة، ويمكنك تسجيل الخروج من صفحة حسابي.';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get createStudentAccount => 'إنشاء حساب طالب جديد';

  @override
  String get phoneValidationError => 'يجب أن يتكون رقم الهاتف من 10 أرقام.';

  @override
  String get otpValidationError => 'يجب أن يتكون رمز التحقق من 6 أرقام.';

  @override
  String get weakPasswordError => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.';

  @override
  String get passwordMismatchError => 'كلمتا المرور غير متطابقتين.';

  @override
  String get nameRequiredError => 'الاسم الكامل مطلوب.';

  @override
  String get nameTooLongError => 'الاسم طويل جداً.';

  @override
  String get emailValidationError => 'أدخل بريداً إلكترونياً صالحاً.';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get newPasswordTitle => 'تعيين كلمة مرور جديدة';

  @override
  String get newPasswordSubtitle => 'اختر كلمة مرور قوية لحسابك.';

  @override
  String get newPasswordScreenTitle => 'كلمة مرور جديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get resetPassword => 'تحديث كلمة المرور';

  @override
  String get passwordResetSuccess =>
      'تم تحديث كلمة المرور بنجاح. يمكنك تسجيل الدخول الآن.';

  @override
  String get forgotPasswordOtpTitle => 'تحقق من رقم هاتفك';

  @override
  String get forgotPasswordOtpSubtitle => 'أدخل رمز التحقق المرسل إلى هاتفك';

  @override
  String get forgotPasswordResend => 'لم يصلك الرمز؟';

  @override
  String forgotPasswordResendAction(String time) {
    return 'إعادة الإرسال خلال $time';
  }

  @override
  String get resendOtpNow => 'إعادة إرسال الرمز';

  @override
  String get otpResentSuccess => 'تم إرسال رمز تحقق جديد.';

  @override
  String get verifyOtp => 'تحقق';

  @override
  String get forgotPasswordComingSoon =>
      'سيتم تفعيل استعادة كلمة المرور قريباً.';

  @override
  String get appBrandTagline => 'مدرسة تعليم القيادة';

  @override
  String get loginDemoHint => 'تجريبي: 0999400001 / Test@12345';

  @override
  String get registerScreenTitle => 'إنشاء حساب طالب';

  @override
  String get registerEyebrow => 'حساب جديد';

  @override
  String get registerWelcomeTitle => 'ابدأ رحلتك معنا';

  @override
  String get registerSubtitle =>
      'أنشئ حساب طالب باسمك ورقم هاتفك وبريدك الإلكتروني وكلمة المرور، ثم فعّل الحساب عبر رمز OTP.';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get fullNameHint => 'عمر الخطيب';

  @override
  String get registerNextStepTitle => 'الخطوة التالية';

  @override
  String get registerNextStepBody =>
      'بعد إنشاء الحساب سنرسل رمز تحقق من 6 أرقام إلى بريدك الإلكتروني.';

  @override
  String get registerSubmitButton => 'إنشاء الحساب وإرسال الكود';

  @override
  String get registerAlreadyHaveCode => 'لدي رمز التحقق بالفعل';

  @override
  String get registerOtpTimeoutProceed =>
      'استغرق الطلب وقتاً أطول من المعتاد، لكن قد يكون رمز التحقق قد أُرسل إلى بريدك. أدخل الرمز في الشاشة التالية.';

  @override
  String get confirmPhoneTitle => 'تأكيد التسجيل';

  @override
  String get otpEyebrow => 'رمز التحقق OTP';

  @override
  String get otpEnterTitle => 'أدخل الرمز المرسل';

  @override
  String otpEnterSubtitle(String phone) {
    return 'أرسلنا رمزاً من 6 خانات إلى البريد الإلكتروني المرتبط بالرقم $phone. هذا التحقق مطلوب قبل دخول الطالب إلى التطبيق.';
  }

  @override
  String get confirmAndEnter => 'تأكيد الرقم والدخول للتطبيق';

  @override
  String get changePhone => 'تغيير رقم الهاتف';

  @override
  String get forgotPasswordScreenTitle => 'نسيان كلمة المرور';

  @override
  String get accountRecoveryEyebrow => 'استعادة الحساب';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل رقم هاتفك وسنرسل لك رمز OTP لتعيين كلمة مرور جديدة.';

  @override
  String get sendVerificationCode => 'إرسال كود التحقق';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String get resetPasswordEyebrow => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordTitle => 'تحقق ثم اختر كلمة جديدة';

  @override
  String get resetPasswordSubtitle =>
      'أدخل رمز OTP المرسل إلى بريد حسابك، ثم عيّن كلمة مرور جديدة.';

  @override
  String get forcePasswordChangeScreenTitle => 'تغيير كلمة المرور';

  @override
  String get forcePasswordChangeEyebrow => 'خطوة أمان مطلوبة';

  @override
  String get forcePasswordChangeTitle => 'عيّن كلمة مرور جديدة';

  @override
  String get forcePasswordChangeSubtitle =>
      'تم إنشاء حسابك من قبل الإدارة. أدخل رمز OTP المرسل إلى بريدك الإلكتروني واختر كلمة مرور جديدة قبل استخدام التطبيق.';

  @override
  String get savePasswordAndLogin => 'حفظ كلمة المرور وتسجيل الدخول';

  @override
  String get profileTitle => 'حسابي';

  @override
  String get profileName => 'الاسم';

  @override
  String get profilePhone => 'رقم الهاتف';

  @override
  String get refreshProfile => 'تحديث الملف';

  @override
  String get mustChangePasswordNotice =>
      'يُطلب منك تغيير كلمة المرور عند تسجيل الدخول التالي.';

  @override
  String get logoutCurrentDevice => 'تسجيل الخروج من هذا الجهاز';

  @override
  String get logoutAllDevices => 'تسجيل الخروج من كل الأجهزة';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get splashLoading => 'جاري التحميل...';

  @override
  String offlineQueuePending(int count) {
    return '$count طلبات بانتظار المزامنة';
  }

  @override
  String get offlineQueueSyncing => 'جاري مزامنة الطلبات غير المتصلة...';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get emptySampleItems => 'لا توجد عناصر';

  @override
  String itemIdLabel(int id) {
    return 'عنصر #$id';
  }

  @override
  String get studentHomeGuestName => 'الطالب';

  @override
  String studentHomeGreetingMorning(String name) {
    return 'صباح الخير، $name';
  }

  @override
  String studentHomeGreetingAfternoon(String name) {
    return 'مساء الخير، $name';
  }

  @override
  String studentHomeGreetingEvening(String name) {
    return 'مساء الخير، $name';
  }

  @override
  String get studentHomeNextLesson => 'الجلسة القادمة';

  @override
  String get studentHomeConfirmed => 'مؤكدة';

  @override
  String get studentHomeInstructorMale => 'المدرب';

  @override
  String get studentHomeInstructorFemale => 'المدربة';

  @override
  String get studentHomeVehicle => 'المركبة';

  @override
  String get studentHomeAutomatic => 'أوتوماتيك';

  @override
  String get studentHomeManual => 'يدوي';

  @override
  String get studentHomeSchoolVehicle => 'مدرسة';

  @override
  String get studentHomeStudentVehicle => 'طالب';

  @override
  String get studentHomeShowMeetingPoint => 'عرض نقطة اللقاء';

  @override
  String get studentHomePendingPaymentTitle => 'حجز بانتظار الدفع';

  @override
  String studentHomePendingPaymentMessage(String time) {
    return 'لديك $time دقائق لإدخال رقم عملية شام كاش قبل تحرير الموعد.';
  }

  @override
  String get studentHomeQuickActions => 'إجراءات سريعة';

  @override
  String get studentHomeViewAll => 'عرض الكل';

  @override
  String get studentHomeNewBooking => 'حجز جلسة جديدة';

  @override
  String get studentHomeMyBookings => 'حجوزاتي';

  @override
  String get studentHomeCertificateRequest => 'طلب الشهادة';

  @override
  String get studentHomeTheorySimulation => 'محاكاة النظري';

  @override
  String get studentHomeTrainingProgress => 'تقدم التدريب';

  @override
  String studentHomeTrainingProgressDetail(int completed, int total) {
    return 'أكملت $completed من أصل $total ساعة';
  }

  @override
  String get studentHomeTrainingProgressFootnote =>
      'بعد إكمال التدريب ستتابع الإدارة مواعيد الفحص النظري والعملي.';

  @override
  String get studentHomeNavBookings => 'حجوزاتي';

  @override
  String get studentHomeNavCertificate => 'الشهادة';

  @override
  String get studentHomeNavProfile => 'حسابي';

  @override
  String get studentHomeFeatureComingSoon => 'هذه الميزة ستكون متاحة قريباً.';

  @override
  String get studentHomeNoNextLessonTitle => 'لا توجد جلسة مؤكدة بعد';

  @override
  String get studentHomeNoNextLessonBody =>
      'أنشئ حجزاً وأكمل دفع شام كاش لتأكيد الموعد.';

  @override
  String get instructorWelcomeBackEyebrow => 'أهلاً بعودتك';

  @override
  String instructorWelcomeBack(String name) {
    return '$name';
  }

  @override
  String get instructorGuestName => 'المدرب';

  @override
  String get instructorTodaySchedule => 'جدول اليوم';

  @override
  String instructorSessionsCount(int count) {
    return '$count جلسات';
  }

  @override
  String instructorTrainingHoursCount(int hours) {
    return '$hours ساعات تدريب';
  }

  @override
  String instructorTrainingHoursDecimal(double hours) {
    return '$hours ساعات تدريب';
  }

  @override
  String get instructorBookedLabel => 'محجوز';

  @override
  String get instructorDailyTimeline => 'الجدول اليومي';

  @override
  String get instructorViewDay => 'يوم';

  @override
  String get instructorViewWeek => 'أسبوع';

  @override
  String get instructorWeeklyBookings => 'الحجوزات الأسبوعية';

  @override
  String get instructorNoSessionsThisWeek => 'لا توجد حصص هذا الأسبوع';

  @override
  String get instructorLiveSchedule => 'جدول مباشر';

  @override
  String get instructorNoSessionsToday => 'لا توجد جلسات في هذا اليوم.';

  @override
  String get instructorBookingConfirmed => 'مؤكد';

  @override
  String get instructorBookingCompleted => 'مكتمل';

  @override
  String get instructorBookingNoShow => 'غياب';

  @override
  String get instructorBookingCancelled => 'ملغى';

  @override
  String get instructorBookingExpired => 'منتهي';

  @override
  String get instructorBookingPendingPayment => 'بانتظار الدفع';

  @override
  String get instructorMinuteUnit => 'دقيقة';

  @override
  String instructorDurationHoursMinutes(int hours, int minutes) {
    return '$hours ساعات و $minutes دقيقة';
  }

  @override
  String instructorDurationHours(int hours) {
    return '$hours ساعات';
  }

  @override
  String instructorDurationMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String instructorCurrencyAmount(int amount) {
    return '$amount ل.س';
  }

  @override
  String get instructorNavSchedule => 'الجدول';

  @override
  String get instructorNavProfile => 'الملف الشخصي';

  @override
  String get instructorFeatureComingSoon => 'هذه الميزة ستكون متاحة قريباً.';

  @override
  String get instructorProfileTitle => 'الملف الشخصي';

  @override
  String get instructorRoleLabel => 'مدرب قيادة';

  @override
  String get instructorProfileBio =>
      'أساعد الطلاب على بناء الثقة واكتساب عادات قيادة آمنة، جلسة بعد جلسة.';

  @override
  String get instructorMetricMonthSessions => 'حصص الشهر';

  @override
  String get instructorMetricMonthEarnings => 'أرباح الشهر';

  @override
  String get instructorMetricVehicle => 'المركبة';

  @override
  String get instructorAccountPreferences => 'الحساب والتفضيلات';

  @override
  String get instructorProfileData => 'بيانات الملف الشخصي';

  @override
  String get instructorProfileGender => 'الجنس';

  @override
  String get instructorProfileGenderMale => 'ذكر';

  @override
  String get instructorProfileGenderFemale => 'أنثى';

  @override
  String get instructorProfileTrainingType => 'نوع التدريب';

  @override
  String get instructorProfileAccountStatus => 'حالة الحساب';

  @override
  String get instructorProfileStatusActive => 'نشط';

  @override
  String get instructorProfileSessionWage => 'أجرة الجلسة';

  @override
  String get instructorProfileTodayLessons => 'جلسات اليوم';

  @override
  String get instructorProfileLeaveStatus => 'حالة الإجازة';

  @override
  String get instructorProfileNoLeave => 'لا توجد إجازة حالياً';

  @override
  String get instructorProfileFullDayLeave => 'إجازة ليوم كامل';

  @override
  String get instructorProfilePartialLeave => 'إجازة جزئية';

  @override
  String get instructorProfileSettings => 'إعدادات المدرب';

  @override
  String get instructorSchedulePreferences => 'تفضيلات الجدول';

  @override
  String get instructorLanguage => 'اللغة';

  @override
  String get instructorNotifications => 'الإشعارات';

  @override
  String get instructorAppVersion => 'قيادة للتدريب · الإصدار 2.4.0';

  @override
  String get instructorLeaveTitle => 'قائمة الإجازات';

  @override
  String get instructorLeaveIntroTitle => 'إجازاتك المسجلة';

  @override
  String get instructorLeaveIntroBody =>
      'راجع فترات الإجازة المسجّلة في جدولك.';

  @override
  String get instructorLeaveAdminNoticeTitle => 'تقديم الإجازة عبر الإدارة';

  @override
  String get instructorLeaveAdminNoticeBody =>
      'يمكنك مراجعة إجازاتك هنا. لطلب إجازة جديدة تواصل مع الإدارة.';

  @override
  String get instructorLeaveEmpty => 'لا توجد إجازات مسجّلة.';

  @override
  String instructorLeaveFullDay(String date) {
    return 'يوم كامل · $date';
  }

  @override
  String instructorLeaveHourly(String date, String start, String end) {
    return '$date · من $start إلى $end';
  }

  @override
  String get instructorAvailableSlot => 'موعد متاح';

  @override
  String get instructorLeaveReasonLabel => 'السبب';

  @override
  String get instructorWeeklyScheduleTitle => 'جدول الدوام الأسبوعي';

  @override
  String get instructorWeeklyScheduleSubtitle =>
      'ساعات الدوام المسجلة لكل يوم.';

  @override
  String get instructorDaySaturday => 'السبت';

  @override
  String get instructorDaySunday => 'الأحد';

  @override
  String get instructorDayMonday => 'الاثنين';

  @override
  String get instructorDayTuesday => 'الثلاثاء';

  @override
  String get instructorDayWednesday => 'الأربعاء';

  @override
  String get instructorDayThursday => 'الخميس';

  @override
  String get instructorDayFriday => 'الجمعة';

  @override
  String get instructorDayOff => 'يوم عطلة';

  @override
  String get instructorDuesTitle => 'المستحقات غير المدفوعة';

  @override
  String get instructorDuesGrandTotal => 'إجمالي المستحقات';

  @override
  String get instructorDuesDailyDetails => 'تفاصيل الأيام';

  @override
  String get instructorDuesEmpty => 'لا توجد مستحقات غير مدفوعة.';

  @override
  String instructorDuesLessonCount(int count) {
    return '$count جلسات';
  }

  @override
  String get instructorEarningsTitle => 'الأرباح المقبوضة';

  @override
  String get instructorEarningsDay => 'يوم';

  @override
  String get instructorEarningsMonth => 'شهر';

  @override
  String get instructorEarningsDayTotal => 'إجمالي اليوم';

  @override
  String get instructorEarningsMonthTotal => 'إجمالي الشهر';

  @override
  String get instructorEarningsSessions => 'الجلسات';

  @override
  String get instructorEarningsEmpty => 'لا توجد أرباح مسجلة لهذه الفترة.';

  @override
  String get instructorEarningsPickDay => 'اختر اليوم';

  @override
  String get instructorEarningsPickMonth => 'اختر شهراً';

  @override
  String instructorEarningsPaidAt(String date) {
    return 'تم الدفع: $date';
  }
}
