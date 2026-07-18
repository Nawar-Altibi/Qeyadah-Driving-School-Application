import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';

@module
abstract class LocalDatabaseModule {
  @Named(RawValues.authNamedInstance)
  LocalDatabaseInterface get authDatabase =>
      getIt.get<LocalDatabaseInterface>(param1: RawValues.authNamedInstance);

  @Named(RawValues.offlineQueueBox)
  LocalDatabaseInterface get offlineQueueDatabase =>
      getIt.get<LocalDatabaseInterface>(param1: RawValues.offlineQueueBox);
}
