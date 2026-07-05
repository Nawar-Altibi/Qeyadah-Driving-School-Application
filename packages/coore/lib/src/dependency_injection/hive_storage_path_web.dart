import 'package:hive_ce_flutter/hive_flutter.dart';

bool _hiveInitialized = false;

Future<String?> initializeHiveStorage() async {
  if (!_hiveInitialized) {
    await Hive.initFlutter();
    _hiveInitialized = true;
  }
  return null;
}
