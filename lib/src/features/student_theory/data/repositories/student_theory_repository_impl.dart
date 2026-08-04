import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/cache/app_ttl_cache.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/data/data_sources/student_theory_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/repositories/student_theory_repository.dart';

@LazySingleton(as: StudentTheoryRepository)
class StudentTheoryRepositoryImpl implements StudentTheoryRepository {
  StudentTheoryRepositoryImpl(this._remoteDataSource);

  final StudentTheoryRemoteDataSource _remoteDataSource;

  static const _selfTestKey = 'self_test';
  final _selfTestCache = AppTtlCache<List<TheoryQuestionEntity>>(
    ttl: const Duration(minutes: 45),
  );

  @override
  FutureEither<List<TheoryQuestionEntity>> getSelfTest() async {
    final cached = _selfTestCache.getFresh(_selfTestKey);
    if (cached != null) return right(cached);

    final result = await _remoteDataSource.fetchSelfTest();
    return result.fold(left, (questions) {
      _selfTestCache.set(_selfTestKey, questions);
      return right(questions);
    });
  }
}
