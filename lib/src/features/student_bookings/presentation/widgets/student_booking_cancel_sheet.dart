import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_input_field.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/failures/student_bookings_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_booking_detail_cubit.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

const _reasonFieldName = 'cancellationReason';

/// Opens the "Cancel booking" bottom sheet for [cubit]. The sheet closes
/// itself automatically once the cancellation succeeds; failures are
/// surfaced by the detail screen's coordinator as a toast, keeping the
/// sheet open so the student can retry.
Future<void> showStudentBookingCancelSheet({
  required BuildContext context,
  required StudentBookingDetailCubit cubit,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppSemanticColors.of(context).card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDesignTokens.radiusSheet),
      ),
    ),
    builder: (sheetContext) {
      return BlocProvider.value(
        value: cubit,
        child: const _StudentBookingCancelSheetContent(),
      );
    },
  );
}

class _StudentBookingCancelSheetContent extends StatelessWidget {
  const _StudentBookingCancelSheetContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return BlocListener<StudentBookingDetailCubit, StudentBookingDetailState>(
      listenWhen: (previous, current) =>
          current.effect is StudentBookingDetailEffectCancelSucceeded &&
          previous.effect != current.effect,
      listener: (context, state) => Navigator.of(context).maybePop(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDesignTokens.screenHorizontalPadding,
          AppDesignTokens.spacing,
          AppDesignTokens.screenHorizontalPadding,
          bottomInset + safeBottom + AppDesignTokens.spacing2xl,
        ),
        child: TypedFormProvider(
          fields: [
            FormFieldDefinition<String>(
              name: _reasonFieldName,
              initialValue: '',
              validators: [
                TypedCommonValidators.required<String>(
                  context: context,
                  errorText: l10n.studentBookingDetailCancelReasonRequired,
                ),
                TypedCommonValidators.maxLength(
                  StudentBookingsCancelReasonRules.maxLength,
                  context: context,
                  errorText: l10n.studentBookingDetailCancelReasonTooLong,
                ),
              ],
            ),
          ],
          child: (formContext) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.line,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colors.dangerBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        PhosphorIconsBold.calendarX,
                        color: colors.danger,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppDesignTokens.spacing),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.studentBookingDetailCancelSheetTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              height: 1.3,
                              color: colors.ink,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.studentBookingDetailCancelSheetMessage,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.muted,
                              fontSize: 14,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                AppInputField(
                  name: _reasonFieldName,
                  label: l10n.studentBookingDetailCancelReasonLabel,
                  hintText: l10n.studentBookingDetailCancelReasonHint,
                  maxLines: 4,
                  minLines: 3,
                  maxLength: StudentBookingsCancelReasonRules.maxLength,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                BlocBuilder<
                  StudentBookingDetailCubit,
                  StudentBookingDetailState
                >(
                  buildWhen: (previous, current) =>
                      previous.isCancelling != current.isCancelling,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: AppButton.ghost(
                            label: l10n.studentBookingDetailCancelSheetKeep,
                            onPressed: state.isCancelling
                                ? null
                                : () => Navigator.of(context).maybePop(),
                          ),
                        ),
                        const SizedBox(width: AppDesignTokens.spacingSm),
                        Expanded(
                          child: AppButton.danger(
                            label: l10n.studentBookingDetailCancelSheetConfirm,
                            isLoading: state.isCancelling,
                            onPressed: () => _submit(formContext, context),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _submit(BuildContext formContext, BuildContext context) {
    final form = TypedFormProvider.of(formContext);
    form.validateForm(
      formContext,
      onValidationPass: () {
        final reason = (form.getValue<String>(_reasonFieldName) ?? '').trim();
        context.read<StudentBookingDetailCubit>().cancel(reason);
      },
    );
  }
}
