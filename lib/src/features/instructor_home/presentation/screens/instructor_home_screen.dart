import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';

class InstructorHomeScreen extends StatelessWidget {
  const InstructorHomeScreen({super.key});

  static const String routePath = '/instructor/home';
  static const String routeName = 'instructor-home';

  @override
  Widget build(BuildContext context) {
    final session = context.read<AuthSessionCubit>().currentSession;
    final name = session?.user.displayName ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qeyadah'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => context.read<AuthSessionCubit>().logout(),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ResponsiveShell(
        child: ListView(
          padding: PaddingManager.paddingAll16,
          children: [
            Text(
              name.isEmpty ? 'Instructor schedule' : 'Hello, $name',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              'Review today\'s lessons, cancellations, and upcoming schedule updates.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: AppDesignTokens.spacingLg),
            const Row(
              children: [
                Expanded(
                  child: AppMetricTile(
                    label: 'Today',
                    value: '0',
                    icon: Icons.event_available_rounded,
                  ),
                ),
                SizedBox(width: AppDesignTokens.spacing),
                Expanded(
                  child: AppMetricTile(
                    label: 'Pending',
                    value: '0',
                    icon: Icons.notifications_active_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignTokens.spacingMd),
            const AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InstructorKicker(),
                  SizedBox(height: AppDesignTokens.spacingMd),
                  Text('No lessons scheduled for today'),
                  SizedBox(height: AppDesignTokens.spacingSm),
                  Text('Confirmed lessons will appear here after scheduling.'),
                ],
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingLg),
            AppButton.secondary(
              label: 'Open schedule',
              icon: Icons.calendar_month_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _InstructorKicker extends StatelessWidget {
  const _InstructorKicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.route_rounded, color: AppColors.brandPrimary),
        const SizedBox(width: AppDesignTokens.spacingSm),
        Text('Today timeline', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
