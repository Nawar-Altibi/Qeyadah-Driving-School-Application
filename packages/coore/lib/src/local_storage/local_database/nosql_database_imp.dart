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

  bool _tryAdoptOpenBox() {
    if (!Hive.isBoxOpen(_boxName)) return false;
    _box = Hive.box(_boxName);
    _isInitialized = true;
    _boxOpeningFutures.remove(_boxName);
    _initialization = null;
    return true;
  }

  void _clearInFlight(CacheResponse<Unit> expected) {
    if (identical(_initialization, expected)) {
      _initialization = null;
    }
  }

  @override
  CacheResponse<Unit> initialize() async {
    if (_tryAdoptOpenBox()) {
      return right(unit);
    }

    // Discard zombie in-flight initialize Futures whose shared openBox map
    // entry is already gone. Joining those forever caused saveSession to hit
    // outer timeouts and surface a fake login/register "request timed out".
    final inFlight = _initialization;
    if (inFlight != null) {
      final mapHasKey = _boxOpeningFutures.containsKey(_boxName);
      if (!mapHasKey) {
        _clearInFlight(inFlight);
      } else {
        try {
          final joined = await inFlight.timeout(
            _openBoxTimeout + const Duration(seconds: 1),
          );
          if (_tryAdoptOpenBox()) {
            return right(unit);
          }
          return joined;
        } on TimeoutException {
          _clearInFlight(inFlight);
          _boxOpeningFutures.remove(_boxName);
          if (_tryAdoptOpenBox()) {
            return right(unit);
          }
          // Fall through to a fresh open attempt.
        }
      }
    }

    if (_initialization != null) {
      // Another caller won the race after we discarded; join them.
      return _initialization!;
    }

    final opening = _initializeBox();
    _initialization = opening;
    final result = await opening;
    // Do not permanently cache a Left — timed-out opens must be retryable.
    if (result.isLeft()) {
      _clearInFlight(opening);
      if (_tryAdoptOpenBox()) {
        return right(unit);
      }
    }
    return result;
  }

  CacheResponse<Unit> _initializeBox() async {
    try {
      if (_tryAdoptOpenBox()) {
        return right(unit);
      }

      // Store the raw open future (no .timeout on the map entry). Timed-out
      // waiters must not remove a still-running openBox; next initialize can adopt.
      final rawOpen = _boxOpeningFutures[_boxName] ??= Hive.openBox<dynamic>(
        _boxName,
      );

      final Box box;
      try {
        box = await rawOpen.timeout(_openBoxTimeout);
      } on TimeoutException {
        if (Hive.isBoxOpen(_boxName)) {
          _box = Hive.box(_boxName);
          _isInitialized = true;
          _boxOpeningFutures.remove(_boxName);
          return right(unit);
        }
        // Keep rawOpen in the map so a later caller can await/adopt it.
        return left(
          CacheInitializationFailure(
            TimeoutException('Hive.openBox timed out for $_boxName'),
            stackTrace: StackTrace.current,
          ),
        );
      }

      _box = box;
      _isInitialized = true;
      _boxOpeningFutures.remove(_boxName);
      return right(unit);
    } catch (e, stackTrace) {
      _boxOpeningFutures.remove(_boxName);
      _isInitialized = false;
      if (_tryAdoptOpenBox()) {
        return right(unit);
      }
      return left(CacheInitializationFailure(e, stackTrace: stackTrace));
    }
  }

  CacheResponse<Unit> _ensureInitialized() async {
    if (_isInitialized && Hive.isBoxOpen(_boxName)) {
      return right(unit);
    }
    _isInitialized = false;
    final result = await initialize();
    if (result.isLeft()) return result;
    return right(unit);
  }

  @override
  CacheResponse<Unit> close() async {
    try {
      await _box.close();
      _isInitialized = false;
      _initialization = null;
      _boxOpeningFutures.remove(_boxName);
      return right(unit);
    } catch (e, stackTrace) {
      return left(CacheCorruptedFailure(e, stackTrace: stackTrace));
    }
  }

  static const _flushTimeout = Duration(seconds: 2);

  @override
  CacheResponse<Unit> save<T>(String key, T value) async {
    try {
      final initResult = await _ensureInitialized();
      return initResult.fold((l) => left(l), (r) async {
        await _box.put(key, value);
        // Best-effort durability. A hard-awaited flush hangs on some Samsung
        // OEMs and surfaces as a fake login "request timed out" after HTTP 200.
        unawaited(_bestEffortFlush());
        return right(unit);
      });
    } catch (e, stackTrace) {
      return left(CacheWriteFailure(e, stackTrace: stackTrace));
    }
  }

  Future<void> _bestEffortFlush() async {
    try {
      await _box.flush().timeout(_flushTimeout);
    } on Object {
      // put already updated the in-memory box; Hive will eventually persist.
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
        unawaited(_bestEffortFlush());
        return right(unit);
      });
    } catch (e, stackTrace) {
      return left(CacheDeleteFailure(e, stackTrace: stackTrace));
    }
  }
}
