import 'dart:convert';

import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/entities/user_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/account_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

class _MockLocalDatabase extends Mock implements LocalDatabaseInterface {}

const _session = AuthSessionEntity(
  user: UserEntity(
    id: 'student-1',
    phone: '0999400001',
    displayName: 'Student',
    roles: [UserRole.student],
    permissions: ['bookings.create'],
    mustChangePassword: false,
    accountStatus: AccountStatus.active,
  ),
  accessToken: 'access-token',
  refreshToken: 'refresh-token',
);

void main() {
  late _MockLocalDatabase database;
  late AuthLocalDataSource dataSource;

  setUp(() {
    database = _MockLocalDatabase();
    dataSource = AuthLocalDataSourceImpl(database);
  });

  test('stores the session as JSON for cold-start restoration', () async {
    when(
      () => database.save<String>(StorageKeys.sessionJson, any()),
    ).thenAnswer((_) async => right(unit));

    final result = await dataSource.saveSession(_session);

    expect(result.isRight(), isTrue);
    final stored =
        verify(
              () =>
                  database.save<String>(StorageKeys.sessionJson, captureAny()),
            ).captured.single
            as String;
    final json = jsonDecode(stored) as Map<String, dynamic>;
    expect(json['accessToken'], _session.accessToken);
    expect(json['refreshToken'], _session.refreshToken);
  });

  test('restores both JSON and the legacy Hive map format', () async {
    final encoded = jsonEncode({
      'userId': _session.user.id,
      'phone': _session.user.phone,
      'displayName': _session.user.displayName,
      'roles': ['STUDENT'],
      'permissions': _session.user.permissions,
      'mustChangePassword': false,
      'accountStatus': 'ACTIVE',
      'accessToken': _session.accessToken,
      'refreshToken': _session.refreshToken,
    });
    when(
      () => database.get<Object>(StorageKeys.sessionJson),
    ).thenAnswer((_) async => right(encoded));

    final jsonResult = await dataSource.readSession();
    final jsonSession = jsonResult.getOrElse((_) => null);
    expect(jsonSession, _session);

    when(
      () => database.get<Object>(StorageKeys.sessionJson),
    ).thenAnswer((_) async => right(jsonDecode(encoded)));

    final legacyResult = await dataSource.readSession();
    expect(legacyResult.getOrElse((_) => null), _session);
  });
}
