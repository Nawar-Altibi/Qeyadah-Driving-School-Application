import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/repositories/student_theory_repository.dart';

@injectable
class LoadTheorySelfTestUseCase {
  const LoadTheorySelfTestUseCase(this._repository);

  final StudentTheoryRepository _repository;

  FutureEither<List<TheoryQuestionEntity>> call() => _repository.getSelfTest();
}
