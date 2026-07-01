import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart';

class SampleItemDetailsScreen extends StatefulWidget {
  const SampleItemDetailsScreen({super.key, required this.itemId});

  final String itemId;

  static const String routePathSegment = ':itemId';
  static const String routeName = 'sample-item-details';

  static String routePathFor(String itemId) => '/sample-items/$itemId';

  @override
  State<SampleItemDetailsScreen> createState() =>
      _SampleItemDetailsScreenState();
}

class _SampleItemDetailsScreenState extends State<SampleItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return RouteResumedRefresh(
      onInitialLoad: () =>
          context.read<SampleItemDetailsCubit>().load(widget.itemId),
      onResumed: () =>
          context.read<SampleItemDetailsCubit>().load(widget.itemId),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.sampleItemDetails)),
        body: ResponsiveShell(
          child: BlocBuilder<SampleItemDetailsCubit, SampleItemDetailsState>(
            builder: (context, state) {
              return state.apiState.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                succeeded: (SampleItemEntity item) {
                  return Padding(
                    padding: PaddingManager.paddingAll24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.itemIdLabel(int.tryParse(item.id) ?? 0),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Text(item.body),
                      ],
                    ),
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
