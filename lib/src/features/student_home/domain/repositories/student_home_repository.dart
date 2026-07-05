import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';

class LoadStudentHomeParams extends Equatable implements Cancelable {
  const LoadStudentHomeParams({this.cancelRequestAdapter});

  @override
  final CancelRequestAdapter? cancelRequestAdapter;

  @override
  List<Object?> get props => [cancelRequestAdapter];

  @override
  LoadStudentHomeParams copyWithCancelRequest(CancelRequestAdapter adapter) {
    return LoadStudentHomeParams(cancelRequestAdapter: adapter);
  }
}

abstract interface class StudentHomeRepository {
  FutureEither<StudentHomeDashboardEntity> loadDashboard(
    LoadStudentHomeParams params,
  );
}
