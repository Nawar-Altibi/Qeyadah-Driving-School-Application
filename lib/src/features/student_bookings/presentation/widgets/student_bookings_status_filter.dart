import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/formatters/student_bookings_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';

/// Horizontally scrollable "All" + per-status filter chips.
/// A `null` value represents "All statuses".
class StudentBookingsStatusFilter extends StatelessWidget {
  const StudentBookingsStatusFilter({
    super.key,
    required this.selected,
    required this.onChanged,
    this.interactive = true,
  });

  final StudentBookingStatus? selected;
  final ValueChanged<StudentBookingStatus?> onChanged;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: StudentBookingStatus.values.length + 1,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppDesignTokens.spacingSm),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _FilterChip(
              label: l10n.studentBookingsFilterAll,
              isSelected: selected == null,
              onTap: interactive ? () => onChanged(null) : null,
            );
          }
          final status = StudentBookingStatus.values[index - 1];
          return _FilterChip(
            label: StudentBookingsFormatters.bookingStatusLabel(l10n, status),
            isSelected: selected == status,
            onTap: interactive ? () => onChanged(status) : null,
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();
    return Material(
      color: isSelected ? AppColors.brandPrimary : AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacingMd,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? AppColors.brandPrimary : AppColors.line,
            ),
          ),
          child: Text(
            label,
            style: (textTheme?.medium12 ?? const TextStyle(fontSize: 12))
                .copyWith(
                  color: isSelected ? AppColors.white : AppColors.ink,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
