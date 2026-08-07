import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// Shows a lightweight month/year grid dialog and returns the selected month
/// as the first day of that month, or `null` if cancelled.
Future<DateTime?> showAppMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String? helpText,
}) {
  final now = DateTime.now();
  final resolvedFirst = firstDate ?? DateTime(2020);
  final resolvedLast = lastDate ?? DateTime(now.year + 1, now.month);
  return showDialog<DateTime>(
    context: context,
    builder: (context) => _AppMonthYearPickerDialog(
      initialDate: DateTime(initialDate.year, initialDate.month),
      firstDate: DateTime(resolvedFirst.year, resolvedFirst.month),
      lastDate: DateTime(resolvedLast.year, resolvedLast.month),
      helpText: helpText,
    ),
  );
}

class _AppMonthYearPickerDialog extends StatefulWidget {
  const _AppMonthYearPickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.helpText,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? helpText;

  @override
  State<_AppMonthYearPickerDialog> createState() =>
      _AppMonthYearPickerDialogState();
}

class _AppMonthYearPickerDialogState extends State<_AppMonthYearPickerDialog> {
  late int _year;
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _year = widget.initialDate.year;
    _selectedMonth = widget.initialDate.month;
    _selectedYear = widget.initialDate.year;
  }

  bool _isMonthEnabled(int month) {
    final candidate = DateTime(_year, month);
    return !candidate.isBefore(widget.firstDate) &&
        !candidate.isAfter(widget.lastDate);
  }

  void _shiftYear(int delta) {
    final next = _year + delta;
    if (next < widget.firstDate.year || next > widget.lastDate.year) return;
    setState(() => _year = next);
  }

  @override
  Widget build(BuildContext context) {
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final monthFormat = DateFormat.MMM(localeName);
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusXl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.helpText != null) ...[
              Text(
                widget.helpText!,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacing),
            ],
            Row(
              children: [
                IconButton(
                  tooltip: MaterialLocalizations.of(
                    context,
                  ).previousMonthTooltip,
                  onPressed: _year <= widget.firstDate.year
                      ? null
                      : () => _shiftYear(-1),
                  icon: Icon(
                    isRtl
                        ? PhosphorIconsBold.caretRight
                        : PhosphorIconsBold.caretLeft,
                  ),
                ),
                Expanded(
                  child: Text(
                    '$_year',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).nextMonthTooltip,
                  onPressed: _year >= widget.lastDate.year
                      ? null
                      : () => _shiftYear(1),
                  icon: Icon(
                    isRtl
                        ? PhosphorIconsBold.caretLeft
                        : PhosphorIconsBold.caretRight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: AppDesignTokens.spacingSm,
              crossAxisSpacing: AppDesignTokens.spacingSm,
              childAspectRatio: 2.1,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var month = 1; month <= 12; month++)
                  _MonthChip(
                    label: monthFormat.format(DateTime(_year, month)),
                    selected: month == _selectedMonth && _year == _selectedYear,
                    enabled: _isMonthEnabled(month),
                    onTap: () {
                      setState(() {
                        _selectedMonth = month;
                        _selectedYear = _year;
                      });
                      Navigator.of(context).pop(DateTime(_year, month));
                    },
                  ),
              ],
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthChip extends StatelessWidget {
  const _MonthChip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final background = !enabled
        ? colors.neutralBg
        : selected
        ? AppColors.brandPrimary
        : colors.brandSoft;
    final foreground = !enabled
        ? colors.muted
        : selected
        ? AppColors.white
        : colors.primary;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
