import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  static const String routePath = '/student/home';
  static const String routeName = 'student-home';

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
              name.isEmpty ? 'Welcome back' : 'Welcome back, $name',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              'Book lessons, track payments, and follow your certificate progress.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: AppDesignTokens.spacingLg),
            const AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeKicker(
                    icon: Icons.calendar_month_rounded,
                    label: 'Next lesson',
                  ),
                  SizedBox(height: AppDesignTokens.spacingMd),
                  Text('No confirmed lesson yet'),
                  SizedBox(height: AppDesignTokens.spacingSm),
                  Text(
                    'Create a booking and complete ShamCash payment to confirm it.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingMd),
            const Row(
              children: [
                Expanded(
                  child: AppMetricTile(
                    label: 'Training',
                    value: '0/20',
                    icon: Icons.school_rounded,
                  ),
                ),
                SizedBox(width: AppDesignTokens.spacing),
                Expanded(
                  child: AppMetricTile(
                    label: 'Payments',
                    value: 'Ready',
                    icon: Icons.wallet_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignTokens.spacingLg),
            AppButton.primary(
              label: 'Book a lesson',
              icon: Icons.add_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeKicker extends StatelessWidget {
  const _HomeKicker({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.brandPrimary),
        const SizedBox(width: AppDesignTokens.spacingSm),
        Text(label, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
