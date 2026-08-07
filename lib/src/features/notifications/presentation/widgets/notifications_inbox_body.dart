import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/formatters/notifications_formatters.dart';

class NotificationsInboxBody extends StatelessWidget {
  const NotificationsInboxBody({
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
    final colors = AppSemanticColors.of(context);
    final notifications = page.notifications;
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return RefreshIndicator(
      onRefresh: interactive
          ? () => context.read<NotificationsInboxCubit>().load()
          : () async {},
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.screenHorizontalPadding,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colors.brandSoft,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          PhosphorIconsBold.bell,
                          color: AppColors.brandPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      Text(
                        l10n.notificationsInboxIntroTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.notificationsInboxIntroBody,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: colors.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  Row(
                    children: [
                      Expanded(
                        child: AppSectionHeading(
                          title: l10n.notificationsInboxListTitle,
                          subtitle: unreadCount > 0
                              ? l10n.notificationsInboxUnreadCount(unreadCount)
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
                  if (notifications.isEmpty)
                    AppCard(child: Text(l10n.notificationsInboxEmpty)),
                ],
              ),
            ),
          ),
          if (notifications.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignTokens.screenHorizontalPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDesignTokens.spacingSm,
                    ),
                    child: _NotificationCard(
                      notification: notification,
                      interactive: interactive,
                    ),
                  );
                }, childCount: notifications.length),
              ),
            ),
          if (notifications.isNotEmpty && page.hasMorePages)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppDesignTokens.screenHorizontalPadding,
                AppDesignTokens.spacingSm,
                AppDesignTokens.screenHorizontalPadding,
                AppDesignTokens.screenBottomPadding +
                    MediaQuery.paddingOf(context).bottom,
              ),
              sliver: SliverToBoxAdapter(
                child: AppButton.secondary(
                  label: l10n.notificationsInboxLoadMore,
                  isLoading: state.isLoadingMore,
                  onPressed: interactive && !state.isLoadingMore
                      ? () => context.read<NotificationsInboxCubit>().loadMore()
                      : null,
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.only(
                bottom:
                    AppDesignTokens.screenBottomPadding +
                    MediaQuery.paddingOf(context).bottom,
              ),
            ),
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
    final semantic = AppSemanticColors.of(context);
    final tone = NotificationsFormatters.notificationTone(
      notification.notificationType,
    );
    final colors = _colorsForTone(semantic, tone);
    final icon = NotificationsFormatters.notificationIcon(
      notification.notificationType,
    );
    final isCalendarIcon = NotificationsFormatters.isCalendarIcon(
      notification.notificationType,
    );

    return AppCard(
      backgroundColor: notification.isRead
          ? null
          : semantic.brandSoft.withValues(alpha: 0.55),
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
                  ).textTheme.bodySmall?.copyWith(color: semantic.muted),
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(
                  NotificationsFormatters.notificationTimestampLabel(
                    notification.createdAt,
                    localeName,
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: semantic.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ({Color foreground, Color background}) _colorsForTone(
    AppSemanticColors colors,
    AppBadgeTone tone,
  ) {
    return switch (tone) {
      AppBadgeTone.success => (
        foreground: colors.success,
        background: colors.successBg,
      ),
      AppBadgeTone.warning => (
        foreground: colors.warning,
        background: colors.warningBg,
      ),
      AppBadgeTone.danger => (
        foreground: colors.danger,
        background: colors.dangerBg,
      ),
      AppBadgeTone.info => (
        foreground: colors.info,
        background: colors.infoBg,
      ),
      AppBadgeTone.neutral => (
        foreground: colors.muted,
        background: colors.neutralBg,
      ),
    };
  }
}
