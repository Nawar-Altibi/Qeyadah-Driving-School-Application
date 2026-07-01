import 'package:bloc_test/bloc_test.dart';
import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/get_persisted_session_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/repositories/sample_items_repository.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/use_cases/sample_items_use_cases.dart';
import 'package:qeyadah_mobile_app/src/shared/entities/user_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSampleItemsRepository extends Mock implements SampleItemsRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const LoginParams(phone: '0999000000', password: 'x'),
    );
    registerFallbackValue(const LoadSampleItemsParams());
  });

  group('LoginUseCase', () {
    late MockAuthRepository repository;
    late LoginUseCase useCase;

    setUp(() {
      repository = MockAuthRepository();
      useCase = LoginUseCase(repository);
    });

    test('returns session on success', () async {
      const session = AuthSessionEntity(
        user: UserEntity(
          id: '1',
          phone: '0999400001',
          displayName: 'Demo',
          roles: [UserRole.student],
          permissions: ['bookings.create'],
          mustChangePassword: false,
        ),
        accessToken: 'token',
      );

      when(
        () => repository.login(any()),
      ).thenAnswer((_) async => right(session));

      final result = await useCase(
        const LoginParams(phone: '0999400001', password: 'Test@12345'),
      );

      expect(result.isRight(), isTrue);
    });
  });

  group('LoadSampleItemsUseCase', () {
    late MockSampleItemsRepository repository;
    late LoadSampleItemsUseCase useCase;

    setUp(() {
      repository = MockSampleItemsRepository();
      useCase = LoadSampleItemsUseCase(repository);
    });

    test('returns items on success', () async {
      const items = [
        SampleItemEntity(id: '1', title: 'Title', body: 'Body', userId: 1),
      ];

      when(
        () => repository.loadItems(any()),
      ).thenAnswer((_) async => right(items));

      final result = await useCase(const LoadSampleItemsParams());

      expect(result.getOrElse((_) => []), items);
    });
  });

  group('AuthSessionCubit', () {
    blocTest<AuthSessionCubit, AuthSessionState>(
      'login emits succeeded session on success',
      build: () {
        final repository = MockAuthRepository();
        when(() => repository.login(any())).thenAnswer(
          (_) async => right(
            const AuthSessionEntity(
              user: UserEntity(
                id: '1',
                phone: '0999400001',
                displayName: 'Demo',
                roles: [UserRole.student],
                permissions: ['bookings.create'],
                mustChangePassword: false,
              ),
              accessToken: 'token',
            ),
          ),
        );
        when(() => repository.logout()).thenAnswer((_) async => right(null));
        when(
          () => repository.getPersistedSession(),
        ).thenAnswer((_) async => right(null));

        return AuthSessionCubit(
          LoginUseCase(repository),
          LogoutUseCase(repository),
          GetPersistedSessionUseCase(repository),
        );
      },
      act: (cubit) => cubit.login(phone: '0999400001', password: 'Test@12345'),
      expect: () => [
        isA<AuthSessionState>().having((s) => s.isLoggingIn, 'loading', true),
        isA<AuthSessionState>().having(
          (s) => s.apiState.isSuccess,
          'success',
          true,
        ),
      ],
    );
  });
}
