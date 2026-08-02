import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/use_cases/student_certificates_use_cases.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';

class StudentCertificatesListState extends Equatable {
  const StudentCertificatesListState({
    this.apiState = const ApiState.initial(),
    this.selectedStatus,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  final ApiState<StudentCertificatesPageEntity> apiState;
  final CertificateRequestStatus? selectedStatus;
  final bool isLoadingMore;
  final bool isRefreshing;

  StudentCertificatesListState copyWith({
    ApiState<StudentCertificatesPageEntity>? apiState,
    CertificateRequestStatus? selectedStatus,
    bool clearStatus = false,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return StudentCertificatesListState(
      apiState: apiState ?? this.apiState,
      selectedStatus: clearStatus
          ? null
          : selectedStatus ?? this.selectedStatus,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    apiState,
    selectedStatus,
    isLoadingMore,
    isRefreshing,
  ];
}

@injectable
class StudentCertificatesListCubit
    extends
        AppCoreCoreCubit<
          StudentCertificatesListState,
          StudentCertificatesPageEntity
        > {
  StudentCertificatesListCubit(this._loadCertificates)
    : super(const StudentCertificatesListState());

  final LoadStudentCertificatesUseCase _loadCertificates;
  int _generation = 0;

  @override
  ApiState<StudentCertificatesPageEntity> getApiState(
    StudentCertificatesListState state,
  ) => state.apiState;

  @override
  StudentCertificatesListState setApiState(
    StudentCertificatesListState state,
    ApiState<StudentCertificatesPageEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    final generation = ++_generation;
    emit(
      state.copyWith(
        apiState: const ApiState.loading(),
        isLoadingMore: false,
        isRefreshing: false,
      ),
    );
    final result = await _fetch(1);
    if (generation != _generation || isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(apiState: ApiState.failed(failure, retryFunction: load)),
      ),
      (page) => emit(state.copyWith(apiState: ApiState.succeeded(page))),
    );
  }

  Future<void> refresh() async {
    final generation = ++_generation;
    emit(state.copyWith(isRefreshing: true));
    final result = await _fetch(1);
    if (generation != _generation || isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(isRefreshing: false)),
      (page) => emit(
        state.copyWith(apiState: ApiState.succeeded(page), isRefreshing: false),
      ),
    );
  }

  Future<void> loadMore() async {
    final current = state.apiState.maybeWhen(
      succeeded: (value) => value,
      orElse: () => null,
    );
    if (current == null || !current.hasMorePages || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _fetch(current.page + 1);
    if (isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(isLoadingMore: false)),
      (next) => emit(
        state.copyWith(
          apiState: ApiState.succeeded(current.appendPage(next)),
          isLoadingMore: false,
        ),
      ),
    );
  }

  void setStatus(CertificateRequestStatus? status) {
    if (state.selectedStatus == status) return;
    emit(state.copyWith(selectedStatus: status, clearStatus: status == null));
    load();
  }

  FutureEither<StudentCertificatesPageEntity> _fetch(int page) {
    return _loadCertificates(
      LoadStudentCertificatesParams(status: state.selectedStatus, page: page),
    );
  }

  @override
  Future<void> close() {
    _generation++;
    return super.close();
  }
}
