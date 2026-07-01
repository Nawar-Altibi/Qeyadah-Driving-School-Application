import 'dart:async';

import 'package:qeyadah_mobile_app/src/core/config/app_navigation/debounced_change_notifier.dart';

class StreamToListenable extends DebouncedChangeNotifier {
  StreamToListenable(List<Stream<dynamic>> streams) {
    subscriptions = streams
        .map(
          (stream) => stream.listen((_) {
            notifyListeners();
          }),
        )
        .toList();
  }

  late final List<StreamSubscription<dynamic>> subscriptions;

  @override
  void dispose() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
