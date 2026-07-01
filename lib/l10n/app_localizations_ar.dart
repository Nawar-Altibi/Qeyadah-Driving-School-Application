// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'قيادة موبايل';

  @override
  String get welcome => 'مرحباً';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get email => 'رقم الهاتف';

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
  String get loginSubtitle => 'سجّل الدخول لمتابعة دروس القيادة';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginDemoHint => 'تجريبي: 0999400001 / Test@12345';

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
}
