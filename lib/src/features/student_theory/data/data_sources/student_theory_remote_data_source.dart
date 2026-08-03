import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/data/parsers/theory_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';

abstract interface class StudentTheoryRemoteDataSource {
  RemoteResponse<List<TheoryQuestionEntity>> fetchSelfTest();
}

@LazySingleton(as: StudentTheoryRemoteDataSource)
class StudentTheoryRemoteDataSourceImpl
    implements StudentTheoryRemoteDataSource {
  StudentTheoryRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<List<TheoryQuestionEntity>> fetchSelfTest() async {
    final response = await _apiHandler.get(
      Endpoints.theorySelfTest,
      isAuthorized: true,
    );
    return response.fold(
      left,
      (json) => right(TheoryJsonParsers.parseQuestions(json)),
    );
  }
}
