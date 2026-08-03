import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';

abstract interface class StudentTheoryRepository {
  FutureEither<List<TheoryQuestionEntity>> getSelfTest();
}
