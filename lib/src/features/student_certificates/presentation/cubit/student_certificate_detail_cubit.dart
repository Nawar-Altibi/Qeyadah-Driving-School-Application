import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/use_cases/student_certificates_use_cases.dart';

class StudentCertificateDetailState extends Equatable {
  const StudentCertificateDetailState({
    this.apiState = const ApiState.initial(),
    this.certificateId,
  });

  final ApiState<StudentCertificateDetailEntity> apiState;
  final String? certificateId;

  StudentCertificateDetailState copyWith({
    ApiState<StudentCertificateDetailEntity>? apiState,
    String? certificateId,
  }) {
    return StudentCertificateDetailState(
      apiState: apiState ?? this.apiState,
      certificateId: certificateId ?? this.certificateId,
    );
  }

  @override
  List<Object?> get props => [apiState, certificateId];
}

@injectable
class StudentCertificateDetailCubit
    extends
        AppCoreCoreCubit<
          StudentCertificateDetailState,
          StudentCertificateDetailEntity
        > {
  StudentCertificateDetailCubit(this._loadDetail)
    : super(const StudentCertificateDetailState());

  final LoadStudentCertificateDetailUseCase _loadDetail;
  int _generation = 0;

  @override
  ApiState<StudentCertificateDetailEntity> getApiState(
    StudentCertificateDetailState state,
  ) => state.apiState;

  @override
  StudentCertificateDetailState setApiState(
    StudentCertificateDetailState state,
    ApiState<StudentCertificateDetailEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load(String id, {bool silent = false}) async {
    final generation = ++_generation;
    emit(
      state.copyWith(
        certificateId: id,
        apiState: silent ? state.apiState : const ApiState.loading(),
      ),
    );
    final result = await _loadDetail(id);
    if (generation != _generation || isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          apiState: ApiState.failed(failure, retryFunction: () => load(id)),
        ),
      ),
      (detail) => emit(state.copyWith(apiState: ApiState.succeeded(detail))),
    );
  }

  Future<void> refresh() async {
    final id = state.certificateId;
    if (id != null) await load(id, silent: true);
  }

  @override
  Future<void> close() {
    _generation++;
    return super.close();
  }
}
