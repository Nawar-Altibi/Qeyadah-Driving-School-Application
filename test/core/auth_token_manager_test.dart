import 'dart:async';

import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureDatabase extends Mock implements SecureDatabaseInterface {}

void main() {
  group('AuthTokenManager.setTokens', () {
    late _MockSecureDatabase secureDatabase;
    late AuthTokenManager manager;

    setUp(() {
      secureDatabase = _MockSecureDatabase();
      manager = AuthTokenManager(secureDatabase);
    });

    test('does not await a hanging onTokensPersisted hook', () async {
      final hanging = Completer<void>();
      var hookStarted = false;

      manager.onTokensPersisted =
          ({String? accessToken, String? refreshToken}) async {
            hookStarted = true;
            await hanging.future;
          };

      final stopwatch = Stopwatch()..start();
      await manager
          .setTokens(accessToken: 'access', refreshToken: 'refresh')
          .timeout(const Duration(milliseconds: 300));
      stopwatch.stop();

      expect(stopwatch.elapsed, lessThan(const Duration(milliseconds: 300)));
      expect(await manager.accessToken, 'access');
      expect(await manager.refreshToken, 'refresh');

      // Allow the unawaited hook to start before asserting.
      await Future<void>.delayed(Duration.zero);
      expect(hookStarted, isTrue);

      hanging.complete();
    });

    test('memory tokens update even when secure write is skipped', () async {
      when(
        () => secureDatabase.write(any(), any()),
      ).thenAnswer((_) async => right(unit));

      await manager.setTokens(accessToken: 'a', refreshToken: 'r');

      expect(await manager.accessToken, 'a');
      expect(await manager.refreshToken, 'r');
      verifyNever(() => secureDatabase.write(any(), any()));
    });
  });
}
