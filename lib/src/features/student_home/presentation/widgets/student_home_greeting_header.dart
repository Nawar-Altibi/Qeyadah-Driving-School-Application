import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';

class StudentHomeGreetingHeader extends StatelessWidget {
  const StudentHomeGreetingHeader({
    super.key,
    required this.dateLabel,
    required this.greeting,
    required this.hasUnreadNotifications,
    this.onNotificationsTap,
  });

  final String dateLabel;
  final String greeting;
  final bool hasUnreadNotifications;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateLabel,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: colors.muted),
              ),
              const SizedBox(height: 3),
              Text(
                greeting,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        _NotificationBellButton(
          hasUnread: hasUnreadNotifications,
          onTap: onNotificationsTap,
        ),
      ],
    );
  }
}

class _NotificationBellButton extends StatelessWidget {
  const _NotificationBellButton({required this.hasUnread, this.onTap});

  final bool hasUnread;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);

    return Material(
      color: colors.card.withValues(alpha: 0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(color: colors.line),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(PhosphorIconsBold.bell, size: 21, color: colors.ink),
              if (hasUnread)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC4313C),
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.card, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
