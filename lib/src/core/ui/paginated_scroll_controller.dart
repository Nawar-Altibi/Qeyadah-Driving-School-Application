import 'package:flutter/widgets.dart';

/// Calls [onLoadMore] when the attached scroll view nears its end.
///
/// Generic on purpose so any future paginated list in the app can reuse it
/// instead of each feature writing its own ScrollController + threshold math.
class PaginatedScrollController extends ScrollController {
  PaginatedScrollController({
    required this.onLoadMore,
    this.threshold = 240,
  }) {
    addListener(_onScroll);
  }

  final VoidCallback onLoadMore;
  final double threshold;

  void _onScroll() {
    if (!hasClients) return;
    if (position.maxScrollExtent - position.pixels <= threshold) {
      onLoadMore();
    }
  }

  @override
  void dispose() {
    removeListener(_onScroll);
    super.dispose();
  }
}
