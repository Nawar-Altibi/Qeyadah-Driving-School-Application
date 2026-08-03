import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/data/data_sources/student_theory_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/repositories/student_theory_repository.dart';

@LazySingleton(as: StudentTheoryRepository)
class StudentTheoryRepositoryImpl implements StudentTheoryRepository {
  StudentTheoryRepositoryImpl(this._remoteDataSource);

  final StudentTheoryRemoteDataSource _remoteDataSource;

  @override
  FutureEither<List<TheoryQuestionEntity>> getSelfTest() {
    return _remoteDataSource.fetchSelfTest();
  }
}
