import 'dart:async';

import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/use_cases/student_certificates_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_state.dart';

export 'student_certificates_hub_state.dart';

@injectable
class StudentCertificatesHubCubit
    extends
        AppCoreCoreCubit<
          StudentCertificatesHubState,
          CertificateEligibilityEntity
        > {
  StudentCertificatesHubCubit(this._loadEligibilityUseCase)
    : super(const StudentCertificatesHubState());

  final LoadCertificateEligibilityUseCase _loadEligibilityUseCase;

  Timer? _countdownTimer;
  int _loadGeneration = 0;

  @override
  ApiState<CertificateEligibilityEntity> getApiState(
    StudentCertificatesHubState state,
  ) => state.apiState;

  @override
  StudentCertificatesHubState setApiState(
    StudentCertificatesHubState state,
    ApiState<CertificateEligibilityEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    final generation = ++_loadGeneration;
    emit(
      state.copyWith(apiState: const ApiState.loading(), isRefreshing: false),
    );

    final result = await _loadEligibilityUseCase();
    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (Failure failure) {
        _stopCountdown();
        emit(
          state.copyWith(
            apiState: ApiState.failed(failure, retryFunction: load),
            reexamRemaining: Duration.zero,
            reexamRegistrationExpired: false,
          ),
        );
      },
      (CertificateEligibilityEntity eligibility) {
        emit(state.copyWith(apiState: ApiState.succeeded(eligibility)));
        _startCountdown(eligibility);
      },
    );
  }

  Future<void> refresh() async {
    final generation = ++_loadGeneration;
    emit(state.copyWith(isRefreshing: true));

    final result = await _loadEligibilityUseCase();
    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (Failure failure) {
        _stopCountdown();
        emit(
          state.copyWith(
            isRefreshing: false,
            apiState: ApiState.failed(failure, retryFunction: load),
            reexamRemaining: Duration.zero,
            reexamRegistrationExpired: false,
          ),
        );
      },
      (CertificateEligibilityEntity eligibility) {
        emit(
          state.copyWith(
            isRefreshing: false,
            apiState: ApiState.succeeded(eligibility),
          ),
        );
        _startCountdown(eligibility);
      },
    );
  }

  void _startCountdown(CertificateEligibilityEntity eligibility) {
    _stopCountdown();
    final reexam = eligibility.reexam;
    if (!reexam.eligible || reexam.registrationClosesAt == null) {
      emit(
        state.copyWith(
          reexamRemaining: Duration.zero,
          reexamRegistrationExpired: false,
        ),
      );
      return;
    }

    _tick(reexam);
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _tick(reexam),
    );
  }

  void _tick(CertificateReexamEligibility reexam) {
    final remaining = reexam.remainingUntilRegistrationCloses();
    final expired = remaining <= Duration.zero;
    emit(
      state.copyWith(
        reexamRemaining: remaining,
        reexamRegistrationExpired: expired,
      ),
    );
    if (expired) {
      _stopCountdown();
    }
  }

  void _stopCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  @override
  Future<void> close() {
    _stopCountdown();
    return super.close();
  }
}
