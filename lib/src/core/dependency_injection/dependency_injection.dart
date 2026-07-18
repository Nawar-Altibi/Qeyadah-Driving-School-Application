import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/dependency_injection/dependency_injection.config.dart';

@InjectableInit()
Future<void> setupProjectDependencies() async {
  getIt.init();
}
