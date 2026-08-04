import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';

class LoadStudentHomeParams extends Equatable implements Cancelable {
  const LoadStudentHomeParams({
    this.cancelRequestAdapter,
    this.forceRefresh = false,
  });

  @override
  final CancelRequestAdapter? cancelRequestAdapter;

  final bool forceRefresh;

  @override
  List<Object?> get props => [cancelRequestAdapter, forceRefresh];

  @override
  LoadStudentHomeParams copyWithCancelRequest(CancelRequestAdapter adapter) {
    return LoadStudentHomeParams(
      cancelRequestAdapter: adapter,
      forceRefresh: forceRefresh,
    );
  }
}

abstract interface class StudentHomeRepository {
  FutureEither<StudentHomeDashboardEntity> loadDashboard(
    LoadStudentHomeParams params,
  );

  void invalidateCache();
}
