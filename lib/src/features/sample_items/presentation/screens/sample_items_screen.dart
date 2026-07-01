import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/coordinators/sample_items_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/navigation/sample_items_navigation.dart';

class SampleItemsScreen extends StatelessWidget {
  const SampleItemsScreen({super.key});

  static const String routePath = '/sample-items';
  static const String routeName = 'sample-items';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SampleItemsScreenCoordinator(
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.sampleItemsTitle),
          actions: [
            IconButton(
              onPressed: () => context.read<AuthSessionCubit>().logout(),
              icon: const Icon(Icons.logout),
              tooltip: l10n.logout,
            ),
          ],
        ),
        body: ResponsiveShell(
          child: BlocBuilder<SampleItemsCubit, SampleItemsState>(
            buildWhen: (previous, current) =>
                previous.apiState != current.apiState ||
                previous.isSilentRefresh != current.isSilentRefresh,
            builder: (context, state) {
              return state.apiState.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                succeeded: (List<SampleItemEntity> items) {
                  if (items.isEmpty) {
                    return Center(child: Text(l10n.emptySampleItems));
                  }
                  return ListView.separated(
                    padding: PaddingManager.paddingAll16,
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(
                          item.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => SampleItemsNavigation.openDetails(
                          itemId: item.id,
                          context: context,
                        ),
                      );
                    },
                  );
                },
                failed: (Failure failure, VoidCallback? retry) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          CoreFailureMessageMapper.messageFor(failure, l10n),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        AppButton.primary(label: l10n.retry, onPressed: retry),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
