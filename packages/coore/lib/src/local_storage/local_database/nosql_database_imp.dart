// hive_local_database.dart
import 'dart:async';

import 'package:coore/src/error_handling/failures/cache_failure.dart';
import 'package:coore/src/local_storage/local_database/local_database_interface.dart';
import 'package:coore/src/typedefs/core_typedefs.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_ce/hive.dart';

class HiveLocalDatabase implements LocalDatabaseInterface {
  HiveLocalDatabase(this._boxName);

  static final Map<String, Future<Box>> _boxOpeningFutures = {};

  static void resetOpeningFutures() {
    _boxOpeningFutures.clear();
  }

  static const _openBoxTimeout = Duration(seconds: 10);

  final String _boxName;

  late Box _box;
  bool _isInitialized = false;
  CacheResponse<Unit>? _initialization;

  @override
  CacheResponse<Unit> initialize() async {
    if (_initialization != null) return _initialization!;
    _initialization = _initializeBox();
    return _initialization!;
  }

  CacheResponse<Unit> _initializeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        _box = Hive.box(_boxName);
        _isInitialized = true;
        _boxOpeningFutures.remove(_boxName);
        return right(unit);
      }

      final openingFuture = _boxOpeningFutures[_boxName] ??= Hive.openBox<dynamic>(
        _boxName,
      )
          .timeout(_openBoxTimeout)
          .whenComplete(() => _boxOpeningFutures.remove(_boxName));
      _box = await openingFuture;
      _isInitialized = true;
      return right(unit);
    } catch (e, stackTrace) {
      _boxOpeningFutures.remove(_boxName);
      return left(CacheInitializationFailure(e, stackTrace: stackTrace));
    }
  }

  CacheResponse<Unit> _ensureInitialized() async {
    if (!_isInitialized) {
      final result = await initialize();
      if (result.isLeft()) return result;
    }
    return right(unit);
  }

  @override
  CacheResponse<Unit> close() async {
    try {
      await _box.close();
      return right(unit);
    } catch (e, stackTrace) {
      return left(CacheCorruptedFailure(e, stackTrace: stackTrace));
    }
  }

  @override
  CacheResponse<Unit> save<T>(String key, T value) async {
    try {
      final initResult = await _ensureInitialized();
      return initResult.fold((l) => left(l), (r) async {
        await _box.put(key, value);
        return right(unit);
      });
    } catch (e, stackTrace) {
      return left(CacheWriteFailure(e, stackTrace: stackTrace));
    }
  }

  @override
  CacheResponse<T?> get<T>(String key) async {
    try {
      final initResult = await _ensureInitialized();
      return initResult.fold((l) => left(l), (r) => right(_box.get(key) as T?));
    } catch (e, stackTrace) {
      return left(CacheReadFailure(e, stackTrace: stackTrace));
    }
  }

  @override
  CacheResponse<Unit> delete(String key) async {
    try {
      final initResult = await _ensureInitialized();
      return initResult.fold((l) => left(l), (r) async {
        await _box.delete(key);
        return right(unit);
      });
    } catch (e, stackTrace) {
      return left(CacheDeleteFailure(e, stackTrace: stackTrace));
    }
  }
}
