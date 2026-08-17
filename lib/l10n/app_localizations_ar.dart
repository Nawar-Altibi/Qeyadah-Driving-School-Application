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
  String get appearanceTitle => 'المظهر';

  @override
  String get appearanceSubtitle =>
      'اختر الفاتح أو الداكن أو اتبع إعداد الجهاز.';

  @override
  String get appearanceSystem => 'تلقائي';

  @override
  String get appearanceLight => 'فاتح';

  @override
  String get appearanceDark => 'داكن';

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
  String get appBrandTagline => 'مدرسة تعليم القيادة';

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
  String get refreshProfile => 'تحديث الملف';

  @override
  String get mustChangePasswordNotice =>
      'يُطلب منك تغيير كلمة المرور عند تسجيل الدخول التالي.';

  @override
  String get logoutCurrentDevice => 'تسجيل الخروج من هذا الجهاز';

  @override
  String get logoutAllDevices => 'تسجيل الخروج من كل الأجهزة';

  @override
  String get logoutConfirmTitle => 'تأكيد تسجيل الخروج';

  @override
  String get logoutConfirmMessage => 'هل تريد تسجيل الخروج من هذا الجهاز؟';

  @override
  String get logoutAllConfirmMessage => 'هل تريد تسجيل الخروج من كل الأجهزة؟';

  @override
  String get logoutConfirmAction => 'تسجيل الخروج';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get splashLoading => 'جاري التحميل...';

  @override
  String offlineQueuePending(int count) {
    return '$count طلبات بانتظار المزامنة';
  }

  @override
  String get offlineQueueSyncing => 'جاري مزامنة الطلبات غير المتصلة...';

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
  String get studentHomeSchoolVehicle => 'مركبة المدرسة';

  @override
  String get studentHomeStudentVehicle => 'مركبة الطالب';

  @override
  String get studentHomeShowMeetingPoint => 'عرض نقطة اللقاء';

  @override
  String get studentHomePendingPaymentTitle => 'حجز بانتظار الدفع';

  @override
  String studentHomePendingPaymentMessage(String time) {
    return 'لديك $time دقائق لإدخال رقم عملية شام كاش قبل تحرير الموعد.';
  }

  @override
  String get studentHomeBlockedTitle => 'الحساب مقيد';

  @override
  String get studentHomeBlockedMessage =>
      'يمكنك عرض حجوزاتك وشهاداتك الحالية، لكن لا يمكنك طلب خدمات جديدة حتى ترفع الإدارة الحظر. يرجى التواصل مع المدرسة.';

  @override
  String get studentHomeQuickActions => 'إجراءات سريعة';

  @override
  String get studentHomeNewBooking => 'حجز جلسة جديدة';

  @override
  String get studentHomeMyBookings => 'حجوزاتي';

  @override
  String get studentHomeCertificateRequest => 'طلب الشهادة';

  @override
  String get studentHomeTheorySimulation => 'محاكاة الفحص النظري';

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
  String get studentHomePendingPaymentOpenBookings =>
      'لديك حجز بانتظار الدفع. افتح حجوزاتي للمتابعة.';

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
  String get durationDaysUnit => 'يوم';

  @override
  String get durationHoursUnit => 'س';

  @override
  String get durationMinutesUnit => 'د';

  @override
  String get durationSecondsUnit => 'ث';

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
  String get instructorTrainingTypeBoth => 'يدوي وأوتوماتيك';

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
  String get instructorNotifications => 'الإشعارات';

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
  String get instructorEarningsDayTotal => 'إجمالي اليوم';

  @override
  String get instructorEarningsMonthTotal => 'إجمالي الشهر';

  @override
  String get instructorEarningsSessions => 'الجلسات';

  @override
  String get instructorEarningsEmpty => 'لا توجد أرباح مسجلة لهذه الفترة.';

  @override
  String get instructorEarningsPaidAt => 'تم الدفع';

  @override
  String get instructorPeriodDay => 'يوم';

  @override
  String get instructorPeriodMonth => 'شهر';

  @override
  String get instructorPeriodPickDay => 'اختر اليوم';

  @override
  String get instructorPeriodPickMonth => 'اختر شهراً';

  @override
  String get instructorPeriodToday => 'اليوم';

  @override
  String get instructorPeriodThisMonth => 'هذا الشهر';

  @override
  String get instructorPeriodHintDay =>
      'تصفّح يوماً بيوم أو اضغط على التاريخ للاختيار.';

  @override
  String get instructorPeriodHintMonth =>
      'تصفّح شهراً بشهر أو اضغط على الشهر للاختيار.';

  @override
  String get instructorPeriodPrevious => 'الفترة السابقة';

  @override
  String get instructorPeriodNext => 'الفترة التالية';

  @override
  String get instructorLoadMore => 'تحميل المزيد';

  @override
  String get instructorInvoicesTitle => 'الفواتير';

  @override
  String get instructorInvoicesTotalReceived => 'إجمالي المقبوض';

  @override
  String get instructorInvoicesCount => 'الفواتير';

  @override
  String get instructorInvoicesSessions => 'الجلسات';

  @override
  String get instructorInvoicesListTitle => 'فواتير الصرف';

  @override
  String get instructorInvoicesEmpty => 'لا توجد فواتير مسجّلة لهذه الفترة.';

  @override
  String instructorInvoicesEntryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count بند',
      many: '$count بنداً',
      few: '$count بنود',
      two: 'بندين',
      one: 'بند واحد',
      zero: 'لا بنود',
    );
    return '$_temp0';
  }

  @override
  String get instructorInvoicesPaidAt => 'تم الدفع';

  @override
  String get instructorInvoiceTypeLessons => 'دروس';

  @override
  String get instructorInvoiceTypeBonus => 'مكافأة';

  @override
  String get instructorPaymentMethodCash => 'نقداً';

  @override
  String get instructorPaymentMethodShamCash => 'شام كاش';

  @override
  String get notificationsMarkAllRead => 'قراءة الكل';

  @override
  String get notificationsInboxTitle => 'الإشعارات';

  @override
  String get notificationsInboxIntroTitle => 'إشعاراتك';

  @override
  String get notificationsInboxIntroBody =>
      'تابع مستجدات الحجوزات والمدفوعات والشهادات وتحديثات الجدول.';

  @override
  String get notificationsInboxListTitle => 'الأحدث';

  @override
  String get notificationsInboxEmpty => 'لا توجد إشعارات بعد.';

  @override
  String get notificationsInboxLoadMore => 'تحميل المزيد';

  @override
  String notificationsInboxUnreadCount(int count) {
    return '$count غير مقروءة';
  }

  @override
  String get studentHomePendingPaymentCta => 'اضغط لإكمال الدفع';

  @override
  String get studentBookingPreferencesTitle => 'حجز جديد';

  @override
  String get studentBookingPreferencesIntroTitle => 'اختر تفضيلاتك';

  @override
  String get studentBookingPreferencesIntroBody =>
      'اختر نوع التدريب والمركبة وجنس المدرب لعرض المواعيد المتاحة.';

  @override
  String get studentBookingTrainingTypeLabel => 'نوع التدريب';

  @override
  String get studentBookingTrainingTypeManual => 'عادي';

  @override
  String get studentBookingTrainingTypeAutomatic => 'أوتوماتيكي';

  @override
  String get studentBookingVehicleSourceLabel => 'المركبة';

  @override
  String get studentBookingVehicleSourceSchool => 'سيارة المدرسة';

  @override
  String get studentBookingVehicleSourceStudent => 'سيارتي الخاصة';

  @override
  String get studentBookingInstructorGenderLabel => 'جنس المدرب';

  @override
  String get studentBookingInstructorGenderMale => 'ذكر';

  @override
  String get studentBookingInstructorGenderFemale => 'أنثى';

  @override
  String get studentBookingContinueButton => 'متابعة';

  @override
  String get studentBookingSlotsTitle => 'المواعيد المتاحة';

  @override
  String get studentBookingSlotsEmptyTitle => 'لا توجد مواعيد متاحة';

  @override
  String get studentBookingSlotsEmptyMessage =>
      'جرّب تفضيلات مختلفة أو حاول لاحقاً.';

  @override
  String get studentBookingSlotsSelectedHeading => 'الموعد المحدد';

  @override
  String get studentBookingSlotsContinueButton => 'متابعة إلى المراجعة';

  @override
  String get studentBookingSlotsPricingTitle => 'تسعير الدرس';

  @override
  String studentBookingSlotsLessonPrice(String amount) {
    return 'سعر الدرس: $amount';
  }

  @override
  String studentBookingSlotsDepositAmount(String amount) {
    return 'العربون المطلوب: $amount';
  }

  @override
  String studentBookingSlotsDepositPercentage(int percent) {
    return '($percent% من السعر)';
  }

  @override
  String studentBookingSlotsLessonDuration(int minutes) {
    return 'مدة الدرس: $minutes دقيقة';
  }

  @override
  String get studentBookingSlotsMorning => 'صباحاً';

  @override
  String get studentBookingSlotsAfternoon => 'بعد الظهر';

  @override
  String get studentBookingSlotsEvening => 'مساءً';

  @override
  String studentBookingSlotsCount(int count) {
    return '$count مواعيد';
  }

  @override
  String get studentBookingReviewTitle => 'مراجعة الحجز';

  @override
  String get studentBookingReviewSummaryTitle => 'ملخص الحجز';

  @override
  String get studentBookingReviewInstructorLabel => 'المدرب';

  @override
  String get studentBookingReviewDateLabel => 'التاريخ';

  @override
  String get studentBookingReviewTimeLabel => 'الوقت';

  @override
  String get studentBookingReviewTrainingTypeLabel => 'نوع التدريب';

  @override
  String get studentBookingReviewVehicleSourceLabel => 'المركبة';

  @override
  String get studentBookingReviewCreateButton => 'تأكيد الحجز';

  @override
  String get studentBookingCreditSuccessTitle => 'تم تأكيد حجزك';

  @override
  String get studentBookingCreditSuccessMessage =>
      'تم تأكيد حجزك بنجاح. يمكنك مراجعة التفاصيل في أي وقت.';

  @override
  String get studentBookingCreditSuccessViewDetails => 'عرض تفاصيل الحجز';

  @override
  String get studentBookingCreditSuccessBackHome => 'العودة إلى الرئيسية';

  @override
  String get studentBookingErrorSlotConflict =>
      'تم حجز هذا الموعد للتو من قبل شخص آخر. الرجاء اختيار موعد آخر.';

  @override
  String get studentBookingErrorPendingPaymentExists =>
      'لديك بالفعل حجز بانتظار الدفع.';

  @override
  String get studentBookingErrorStudentTimeConflict =>
      'لديك حجز آخر في هذا الوقت. الرجاء اختيار موعد مختلف.';

  @override
  String get studentBookingErrorGenericConflict =>
      'تعذر تأكيد الحجز بسبب تعارض. الرجاء اختيار موعد آخر.';

  @override
  String get studentBookingErrorPaymentHoldIncomplete =>
      'تم إنشاء الحجز لكن تفاصيل الدفع غير مكتملة. الرجاء التواصل مع الدعم.';

  @override
  String get studentBookingsTitle => 'حجوزاتي';

  @override
  String get studentBookingsFilterAll => 'الكل';

  @override
  String get studentBookingsSearchHint => 'ابحث باسم المدرب';

  @override
  String studentBookingsInstructorName(String name) {
    return 'المدرب: $name';
  }

  @override
  String get studentBookingsSortNewestFirst => 'الأحدث أولاً';

  @override
  String get studentBookingsSortOldestFirst => 'الأقدم أولاً';

  @override
  String get studentBookingsEmptyTitle => 'لا توجد حجوزات بعد';

  @override
  String get studentBookingsEmptyMessage =>
      'ستظهر حجوزاتك هنا بعد حجز حصة تدريبية.';

  @override
  String studentBookingsRemainingAtSchool(String amount) {
    return 'المتبقي $amount في المدرسة';
  }

  @override
  String studentBookingsCurrencyAmount(String amount) {
    return '$amount ل.س';
  }

  @override
  String get studentBookingsStatusPendingPayment => 'بانتظار الدفع';

  @override
  String get studentBookingsStatusBooked => 'محجوز';

  @override
  String get studentBookingsStatusCompleted => 'مكتمل';

  @override
  String get studentBookingsStatusCancelled => 'ملغى';

  @override
  String get studentBookingsStatusExpired => 'منتهي';

  @override
  String get studentBookingsStatusNoShow => 'لم يحضر';

  @override
  String get studentBookingsPaymentPendingDeposit => 'بانتظار العربون';

  @override
  String get studentBookingsPaymentDepositPaid => 'تم دفع العربون';

  @override
  String get studentBookingsPaymentFullyPaid => 'مدفوع بالكامل';

  @override
  String get studentBookingsPaymentDepositNonRefundable =>
      'العربون غير قابل للاسترداد';

  @override
  String get studentBookingsPaymentDepositAvailableForRebooking =>
      'العربون متاح لإعادة الحجز';

  @override
  String get studentBookingsPaymentDepositUsedInRebooking =>
      'تم استخدام العربون في حجز جديد';

  @override
  String get studentBookingsChargeUnpaid => 'غير مدفوع';

  @override
  String get studentBookingsChargePartiallyPaid => 'مدفوع جزئيًا';

  @override
  String get studentBookingsChargePaid => 'مدفوع';

  @override
  String get studentBookingsChargeCancelled => 'ملغى';

  @override
  String get studentBookingDetailTitle => 'تفاصيل الحجز';

  @override
  String get studentBookingDetailCompletePayment => 'إتمام الدفع';

  @override
  String get studentBookingDetailInstructorTitle => 'المدرب';

  @override
  String get studentBookingDetailVehicleTitle => 'المركبة';

  @override
  String get studentBookingDetailOwnVehicleNote =>
      'أنت تستخدم سيارتك الخاصة لهذه الحصة.';

  @override
  String get studentBookingDetailChargesTitle => 'الرسوم';

  @override
  String get studentBookingDetailChargesEmpty =>
      'لا توجد رسوم مسجلة لهذا الحجز بعد.';

  @override
  String studentBookingDetailChargeAmountDue(String amount) {
    return 'المبلغ المستحق: $amount';
  }

  @override
  String studentBookingDetailRemainingCallout(
    String paid,
    String total,
    String remaining,
  ) {
    return 'تم دفع $paid من أصل $total — المتبقي $remaining في المدرسة';
  }

  @override
  String get studentBookingDetailCancelButton => 'إلغاء الحجز';

  @override
  String get studentBookingDetailDepositRebookTitle =>
      'العربون متاح لإعادة الحجز';

  @override
  String get studentBookingDetailDepositRebookMessage =>
      'يتم الاحتفاظ بعربونك ويمكن استخدامه لحجز جديد.';

  @override
  String get studentBookingDetailDepositRebookCta => 'احجز مجددًا';

  @override
  String get studentBookingDetailDepositLostTitle =>
      'العربون غير قابل للاسترداد';

  @override
  String get studentBookingDetailDepositLostMessage =>
      'لم يتم استرداد عربون هذا الحجز وفقًا لسياسة الإلغاء.';

  @override
  String get studentBookingDetailPendingPaymentNoHoldMessage =>
      'هذا الحجز بانتظار الدفع، ولكن تعذر العثور على جلسة الدفع. الرجاء التواصل مع الدعم.';

  @override
  String get studentBookingDetailHoldExpiredMessage =>
      'انتهت مهلة الدفع لهذا الحجز.';

  @override
  String get studentBookingDetailHoldExpiredCta => 'حجز جديد';

  @override
  String get studentBookingDetailCancelSuccessMessage => 'تم إلغاء حجزك.';

  @override
  String get studentBookingDetailCancelSheetTitle => 'هل تريد إلغاء هذا الحجز؟';

  @override
  String get studentBookingDetailCancelSheetMessage =>
      'الرجاء إخبارنا بسبب الإلغاء، فذلك يساعدنا على التحسين.';

  @override
  String get studentBookingDetailCancelReasonLabel => 'سبب الإلغاء';

  @override
  String get studentBookingDetailCancelReasonHint => 'مثال: تعارض في الموعد';

  @override
  String get studentBookingDetailCancelReasonRequired =>
      'الرجاء إدخال سبب الإلغاء.';

  @override
  String get studentBookingDetailCancelReasonTooLong =>
      'يجب ألا يتجاوز سبب الإلغاء 255 حرفًا.';

  @override
  String get studentBookingDetailCancelSheetKeep => 'الاحتفاظ بالحجز';

  @override
  String get studentBookingDetailCancelSheetConfirm => 'إلغاء الحجز';

  @override
  String get studentPaymentTitle => 'دفع شام كاش';

  @override
  String get studentPaymentShamCashTitle => 'أكمل تحويل شام كاش';

  @override
  String get studentPaymentDepositAmount => 'مبلغ العربون';

  @override
  String get studentPaymentReceiverName => 'اسم المستلم';

  @override
  String get studentPaymentExactAmountWarningTitle =>
      'أرسل مبلغ العربون بالضبط';

  @override
  String studentPaymentExactAmountWarningMessage(String amount) {
    return 'أرسل بالضبط $amount. لا أكثر ولا أقل. في حال لم تحضر الدرس، يُحرق العربون كاملاً ولا يُسترد. أي مبلغ زائد يُحرق أيضاً مع العربون.';
  }

  @override
  String get studentPaymentCountdownTitle => 'الوقت المتبقي';

  @override
  String studentPaymentCountdownMessage(String time) {
    return 'أكّد خلال $time وإلا سيتم تحرير الموعد.';
  }

  @override
  String get studentPaymentExpiredTitle => 'انتهت مهلة الحجز';

  @override
  String get studentPaymentExpiredMessage =>
      'انتهت صلاحية هذا الحجز. الرجاء بدء حجز جديد.';

  @override
  String get studentPaymentTransactionIdLabel => 'رقم عملية شام كاش';

  @override
  String get studentPaymentTransactionIdHint =>
      'أدخل رقم العملية المكوّن من 9 أرقام من تحويل شام كاش.';

  @override
  String get studentPaymentConfirmButton => 'تأكيد الدفع';

  @override
  String get studentPaymentBackToHomeButton => 'العودة إلى الرئيسية';

  @override
  String get studentPaymentSuccessMessage => 'تم تأكيد الدفع! تم إتمام حجزك.';

  @override
  String get studentPaymentInvalidTransactionId =>
      'يجب أن يتكون رقم العملية من 9 أرقام بالضبط.';

  @override
  String get studentCertificatesTitle => 'الشهادات';

  @override
  String get studentCertificatesActiveRequestTitle => 'الطلب الحالي';

  @override
  String studentCertificatesCourseNumber(int courseNumber) {
    return 'رقم الدورة $courseNumber';
  }

  @override
  String studentCertificatesRequestId(String id) {
    return 'طلب رقم $id';
  }

  @override
  String get studentCertificatesNewRequestFirst => 'طلب شهادة لأول مرة';

  @override
  String get studentCertificatesNewRequestExtra => 'طلب شهادة إضافية';

  @override
  String studentCertificatesAvailableTypes(String types) {
    return 'الأنواع المتاحة: $types';
  }

  @override
  String get studentCertificatesBlockedWriteHint =>
      'لا يمكن تقديم طلب شهادة جديد بينما حسابك مقيّد.';

  @override
  String get studentCertificatesReexamTitle => 'طلب إعادة فحص';

  @override
  String studentCertificatesReexamTitleTyped(String examType) {
    return 'طلب إعادة الفحص $examType';
  }

  @override
  String studentCertificatesReexamFee(String amount) {
    return 'الرسم: $amount ل.س';
  }

  @override
  String studentCertificatesExamScheduled(String label) {
    return 'الموعد: $label';
  }

  @override
  String studentCertificatesRegistrationCloses(String label) {
    return 'آخر موعد للتسجيل: $label';
  }

  @override
  String get studentCertificatesRegistrationCountdownLabel =>
      'الوقت المتبقي للتسجيل';

  @override
  String studentCertificatesRegistrationCountdown(String time) {
    return 'الوقت المتبقي للتسجيل: $time';
  }

  @override
  String get studentCertificatesReexamCta => 'طلب إعادة';

  @override
  String get studentCertificatesStatusTitle => 'حالة الشهادة';

  @override
  String get studentCertificatesStatusFallback =>
      'لا تتوفر إجراءات شهادة حالياً.';

  @override
  String get studentCertificatesExamTypeTheory => 'النظري';

  @override
  String get studentCertificatesExamTypePractical => 'العملي';

  @override
  String get studentCertificatesTransmissionManual => 'عادي';

  @override
  String get studentCertificatesTransmissionAutomatic => 'أوتوماتيك';

  @override
  String get studentCertificatesStatusWaitingForTrainingSchedule =>
      'بانتظار تحديد جدول التدريب';

  @override
  String get studentCertificatesStatusInGovernmentTraining =>
      'في التدريب الحكومي';

  @override
  String get studentCertificatesStatusWaitingForTheoreticalExam =>
      'بانتظار الفحص النظري';

  @override
  String get studentCertificatesStatusWaitingForPracticalExam =>
      'بانتظار الفحص العملي';

  @override
  String get studentCertificatesStatusCompleted => 'مكتملة';

  @override
  String get studentCertificatesStatusFailed => 'راسبة';

  @override
  String get studentCertificatesStatusCancelled => 'ملغاة';

  @override
  String get studentCertificatesTimelineSubmitted => 'قُدّم الطلب';

  @override
  String get studentCertificatesTimelineGovTraining => 'التدريب الحكومي';

  @override
  String get studentCertificatesTimelineTheoryExam => 'الامتحان النظري';

  @override
  String get studentCertificatesTimelinePracticalExam => 'الامتحان العملي';

  @override
  String get studentCertificatesTimelineLicense => 'الحصول على الرخصة';

  @override
  String get studentCertificatesCompletedCategoriesTitle => 'رخصك الحاصلة';

  @override
  String get studentCertificatesHistoryTitle => 'سجل الشهادات';

  @override
  String get studentCertificatesHistoryCta => 'عرض سجل الشهادات';

  @override
  String get studentCertificatesViewDetailsCta => 'عرض التفاصيل';

  @override
  String get studentCertificatesDetailTitle => 'تفاصيل الشهادة';

  @override
  String get studentCertificatesFilterStatus => 'الحالة';

  @override
  String get studentCertificatesFilterAll => 'كل الحالات';

  @override
  String get studentCertificatesHistoryEmpty => 'لا توجد طلبات شهادات.';

  @override
  String get studentCertificatesLoadMore => 'تحميل المزيد';

  @override
  String studentCertificatesCategory(String category) {
    return 'الفئة: $category';
  }

  @override
  String studentCertificatesRequestedAt(String date) {
    return 'تاريخ الطلب: $date';
  }

  @override
  String studentCertificatesTransmission(String type) {
    return 'ناقل الحركة: $type';
  }

  @override
  String get studentCertificatesDocumentsTitle => 'المستندات';

  @override
  String get studentCertificatesPersonalPhoto => 'الصورة الشخصية';

  @override
  String get studentCertificatesIdFront => 'الهوية - الوجه الأمامي';

  @override
  String get studentCertificatesIdBack => 'الهوية - الوجه الخلفي';

  @override
  String get studentCertificatesSessionsTitle => 'جلسات التدريب';

  @override
  String studentCertificatesSessionNumber(int number) {
    return 'الجلسة $number';
  }

  @override
  String get studentCertificatesExamsTitle => 'الفحوصات';

  @override
  String get studentCertificatesNotScheduled => 'لم يحدد الموعد';

  @override
  String get studentCertificatesExamResultPass => 'ناجح';

  @override
  String get studentCertificatesExamResultFail => 'راسب';

  @override
  String get studentCertificatesExamResultAbsent => 'غائب';

  @override
  String get studentCertificatesChargesTitle => 'الرسوم';

  @override
  String studentCertificatesAmountDue(String amount) {
    return 'المبلغ المستحق: $amount ل.س';
  }

  @override
  String get studentCertificatesChargeReasonCertificateFee => 'رسوم الشهادة';

  @override
  String get studentCertificatesChargeReasonReexamTheory =>
      'رسوم إعادة الفحص النظري';

  @override
  String get studentCertificatesChargeReasonReexamPractical =>
      'رسوم إعادة الفحص العملي';

  @override
  String get studentCertificatesStudentLabel => 'الطالب';

  @override
  String get studentCertificatesCategoryLabel => 'الفئة';

  @override
  String get studentCertificatesTransmissionLabel => 'ناقل الحركة';

  @override
  String get studentCertificatesCourseLabel => 'رقم الدورة';

  @override
  String get studentCertificatesSectionEmpty => 'لا توجد عناصر.';

  @override
  String get studentCertificatesSectionEmptyHint =>
      'ستظهر التفاصيل هنا عند توفرها.';

  @override
  String get studentCertificatesDocumentUnavailable => 'غير متاحة للعرض';

  @override
  String get studentCertificatesNewTitle => 'طلب شهادة جديد';

  @override
  String get studentCertificatesTransmissionChoice => 'نوع ناقل الحركة';

  @override
  String get studentCertificatesTransportRequested =>
      'أحتاج إلى النقل من المدرسة';

  @override
  String get studentCertificatesImagesTitle => 'الصور المطلوبة';

  @override
  String get studentCertificatesImagesHint =>
      'JPEG أو PNG أو WebP، وبحد أقصى 5 ميغابايت لكل صورة.';

  @override
  String get studentCertificatesFeeGuidance =>
      'حوّل نحو 600,000 ل.س عبر شام كاش، ثم أدخل رقم العملية.';

  @override
  String get studentCertificatesSubmitNew => 'إرسال طلب الشهادة';

  @override
  String get studentCertificatesNewSuccess => 'تم تقديم طلب الشهادة بنجاح.';

  @override
  String get studentCertificatesInvalidImage =>
      'اختر صورة بصيغة JPEG أو PNG أو WebP.';

  @override
  String get studentCertificatesImageTooLarge =>
      'يجب ألا يتجاوز حجم كل صورة 5 ميغابايت.';

  @override
  String get studentCertificatesReexamPayCta => 'الدفع والتسجيل للإعادة';

  @override
  String get studentCertificatesReexamSuccess =>
      'تم تسجيل طلب إعادة الفحص بنجاح.';

  @override
  String get studentCertificatesRegistrationExpired =>
      'انتهت مهلة التسجيل لإعادة الفحص.';

  @override
  String get studentTheoryTitle => 'محاكاة الفحص النظري';

  @override
  String get studentTheoryBeforeYouStartTitle => 'قبل أن تبدأ';

  @override
  String get studentTheoryIntroBody =>
      'راجع أسئلة السلامة والميكانيك بنفس أسلوب الفحص النظري. أجب عن كل سؤال، ثم اطّلع على الشرح قبل الانتقال للسؤال التالي.';

  @override
  String studentTheoryQuestionCount(int count) {
    return '$count سؤال في هذه الجولة';
  }

  @override
  String get studentTheoryStartButton => 'بدء الفحص الآن';

  @override
  String studentTheoryProgress(int current, int total) {
    return 'السؤال $current من $total';
  }

  @override
  String get studentTheoryNextButton => 'التالي';

  @override
  String get studentTheoryFinishButton => 'إنهاء';

  @override
  String get studentTheoryExplanationTitle => 'الشرح';

  @override
  String get studentTheoryResultsTitle => 'نتيجة الفحص';

  @override
  String get studentTheoryFinalScoreTitle => 'التقييم النهائي';

  @override
  String studentTheoryScoreSummary(int score, int total) {
    return '$score / $total';
  }

  @override
  String get studentTheoryResultsBody =>
      'يمكنك التدرّب مجدداً بمجموعة أسئلة جديدة في أي وقت.';

  @override
  String get studentTheoryPracticeAgainButton => 'أسئلة جديدة';

  @override
  String get studentTheoryBackToHomeButton => 'العودة إلى الرئيسية';

  @override
  String get studentTheoryCategorySigns => 'إشارات المرور';

  @override
  String get studentTheoryCategorySafety => 'السلامة';

  @override
  String get studentTheoryCategoryMechanics => 'الميكانيك';

  @override
  String get studentTheoryCategoryUnknown => 'عام';
}
