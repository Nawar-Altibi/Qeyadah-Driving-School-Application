// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Qeyadah Mobile';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Phone number';

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
  String get loginSubtitle => 'Sign in to continue your driving lessons';

  @override
  String get loginButton => 'Sign in';

  @override
  String get loginDemoHint => 'Demo: 0999400001 / Test@12345';

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
}
