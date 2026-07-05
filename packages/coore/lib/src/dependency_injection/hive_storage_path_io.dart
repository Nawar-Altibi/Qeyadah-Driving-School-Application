import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> initializeHiveStorage() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  return directory.path;
}
