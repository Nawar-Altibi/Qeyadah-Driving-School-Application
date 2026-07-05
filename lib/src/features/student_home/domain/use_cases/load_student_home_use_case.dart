import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart';

@lazySingleton
class LoadStudentHomeUseCase extends FutureEitherUseCase<
    StudentHomeDashboardEntity,
    LoadStudentHomeParams> {
  LoadStudentHomeUseCase(this._repository);

  final StudentHomeRepository _repository;

  @override
  FutureEither<StudentHomeDashboardEntity> call(
    LoadStudentHomeParams params,
  ) {
    return _repository.loadDashboard(params);
  }
}
