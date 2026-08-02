import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/mappers/auth_session_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/models/auth_session_model.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/account_status.dart';

void main() {
  group('AccountStatus.fromValue', () {
    test('parses ACTIVE', () {
      expect(AccountStatus.fromValue('ACTIVE'), AccountStatus.active);
    });

    test('parses BLOCKED', () {
      expect(AccountStatus.fromValue('BLOCKED'), AccountStatus.blocked);
    });

    test('parses ARCHIVED', () {
      expect(AccountStatus.fromValue('ARCHIVED'), AccountStatus.archived);
    });

    test('defaults missing or empty values to ACTIVE', () {
      expect(AccountStatus.fromValue(null), AccountStatus.active);
      expect(AccountStatus.fromValue(''), AccountStatus.active);
      expect(AccountStatus.fromValue('   '), AccountStatus.active);
    });

    test('defaults unknown values to ACTIVE', () {
      expect(AccountStatus.fromValue('WEIRD'), AccountStatus.active);
    });
  });

  group('AuthSessionModel accountStatus', () {
    test('reads accountStatus from JSON', () {
      final model = AuthSessionModel.fromJson({
        'userId': '1',
        'phone': '0999400001',
        'displayName': 'Demo',
        'roles': ['STUDENT'],
        'permissions': ['bookings.create'],
        'mustChangePassword': false,
        'accountStatus': 'BLOCKED',
        'accessToken': 'token',
      });

      expect(model.accountStatus, 'BLOCKED');
      expect(
        authSessionModelToEntity(model).user.accountStatus,
        AccountStatus.blocked,
      );
      expect(authSessionModelToEntity(model).user.isBlocked, isTrue);
    });

    test('defaults missing accountStatus to ACTIVE', () {
      final model = AuthSessionModel.fromJson({
        'userId': '1',
        'phone': '0999400001',
        'displayName': 'Demo',
        'roles': ['STUDENT'],
        'permissions': <String>[],
        'mustChangePassword': false,
        'accessToken': 'token',
      });

      expect(model.accountStatus, 'ACTIVE');
      expect(
        authSessionModelToEntity(model).user.accountStatus,
        AccountStatus.active,
      );
      expect(authSessionModelToEntity(model).user.isBlocked, isFalse);
    });

    test('round-trips accountStatus through toJson', () {
      const model = AuthSessionModel(
        userId: '1',
        phone: '0999400001',
        displayName: 'Demo',
        roles: ['STUDENT'],
        permissions: <String>[],
        mustChangePassword: false,
        accessToken: 'token',
        accountStatus: 'BLOCKED',
      );

      final restored = AuthSessionModel.fromJson(model.toJson());
      expect(restored.accountStatus, 'BLOCKED');
    });
  });
}
