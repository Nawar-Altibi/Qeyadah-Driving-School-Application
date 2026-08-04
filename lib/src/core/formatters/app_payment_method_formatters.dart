import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_payment_method.dart';

abstract final class AppPaymentMethodFormatters {
  static String label(AppLocalizations l10n, InstructorPaymentMethod method) {
    return switch (method) {
      InstructorPaymentMethod.cash => l10n.instructorPaymentMethodCash,
      InstructorPaymentMethod.shamCash => l10n.instructorPaymentMethodShamCash,
    };
  }

  /// Maps a raw API payment-method string; falls back to [raw] if unknown.
  static String labelFromApi(AppLocalizations l10n, String raw) {
    final method = InstructorPaymentMethod.fromApi(raw);
    if (method == null) return raw;
    return label(l10n, method);
  }
}
