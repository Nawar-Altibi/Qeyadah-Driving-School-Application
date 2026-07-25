import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/widgets/instructor_load_more_button.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';

class InstructorNotificationsBody extends StatelessWidget {
  const InstructorNotificationsBody({
    super.key,
    required this.state,
    required this.page,
    this.interactive = true,
  });

  final NotificationsInboxState state;
  final AppNotificationsPageEntity page;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unreadCount = page.notifications.where((n) => !n.isRead).length;

    return RefreshIndicator(
      onRefresh: interactive
          ? () => context.read<NotificationsInboxCubit>().load()
          : () async {},
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
        children: [
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.brandMintSoft,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  PhosphorIconsBold.bell,
                  color: AppColors.brandPrimary,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingSm),
              Text(
                l10n.instructorNotificationsIntroTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.instructorNotificationsIntroBody,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          Row(
            children: [
              Expanded(
                child: AppSectionHeading(
                  title: l10n.instructorNotificationsListTitle,
                  subtitle: unreadCount > 0
                      ? l10n.instructorNotificationsUnreadCount(unreadCount)
                      : null,
                ),
              ),
              if (interactive && unreadCount > 0)
                TextButton(
                  onPressed: state.isMarkingAll
                      ? null
                      : () => context
                            .read<NotificationsInboxCubit>()
                            .markAllRead(),
                  child: Text(l10n.notificationsMarkAllRead),
                ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacing),
          if (page.notifications.isEmpty)
            AppCard(child: Text(l10n.instructorNotificationsEmpty))
          else ...[
            for (final notification in page.notifications) ...[
              _NotificationCard(
                notification: notification,
                interactive: interactive,
              ),
              const SizedBox(height: AppDesignTokens.spacingSm),
            ],
            if (page.hasMorePages)
              InstructorLoadMoreButton(
                isLoading: state.isLoadingMore,
                onPressed: interactive
                    ? () => context.read<NotificationsInboxCubit>().loadMore()
                    : null,
              ),
          ],
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.interactive,
  });

  final AppNotificationEntity notification;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final tone = InstructorFormatters.notificationTone(
      notification.notificationType,
    );
    final colors = _colorsForTone(tone);
    final icon = InstructorFormatters.notificationIcon(
      notification.notificationType,
    );
    final isCalendarIcon =
        notification.notificationType == AppNotificationType.bookingConfirmed ||
        notification.notificationType == AppNotificationType.bookingCancelled ||
        notification.notificationType == AppNotificationType.instructorSchedule;

    return AppCard(
      backgroundColor: notification.isRead
          ? null
          : AppColors.brandMintSoft.withValues(alpha: 0.55),
      borderColor: notification.isRead ? null : AppColors.brandMint,
      onTap: interactive
          ? () => context.read<NotificationsInboxCubit>().openNotification(
              notification,
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.background,
              shape: BoxShape.circle,
            ),
            child: isCalendarIcon
                ? AppNonMirroredIcon(icon, size: 20, color: colors.foreground)
                : Icon(icon, size: 20, color: colors.foreground),
          ),
          const SizedBox(width: AppDesignTokens.spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: notification.isRead
                              ? FontWeight.w600
                              : FontWeight.w800,
                        ),
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.brandPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(
                  InstructorFormatters.notificationTimestampLabel(
                    notification.createdAt,
                    localeName,
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ({Color foreground, Color background}) _colorsForTone(AppBadgeTone tone) {
    return switch (tone) {
      AppBadgeTone.success => (
        foreground: AppColors.success,
        background: AppColors.successBg,
      ),
      AppBadgeTone.warning => (
        foreground: AppColors.warning,
        background: AppColors.warningBg,
      ),
      AppBadgeTone.danger => (
        foreground: AppColors.danger,
        background: AppColors.dangerBg,
      ),
      AppBadgeTone.info => (
        foreground: AppColors.info,
        background: AppColors.infoBg,
      ),
      AppBadgeTone.neutral => (
        foreground: AppColors.muted,
        background: AppColors.neutralBg,
      ),
    };
  }
}
