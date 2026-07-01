import 'dart:async';

import 'package:flutter/foundation.dart';

class DebouncedChangeNotifier extends ChangeNotifier {
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 50);

  @override
  void notifyListeners() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, super.notifyListeners);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
