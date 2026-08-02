import 'dart:async';
import 'dart:io';

import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/failures/student_certificate_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/services/student_certificate_write_validation_rules.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/use_cases/student_certificates_use_cases.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

sealed class StudentCertificateWriteEffect {
  const StudentCertificateWriteEffect();
}

final class StudentCertificateWriteSucceeded
    extends StudentCertificateWriteEffect {
  const StudentCertificateWriteSucceeded();
}

final class StudentCertificateWriteConflict
    extends StudentCertificateWriteEffect {
  const StudentCertificateWriteConflict();
}

final class StudentCertificateWriteFailed
    extends StudentCertificateWriteEffect {
  const StudentCertificateWriteFailed(this.failure);
  final Failure failure;
}

final class StudentCertificateReexamNoLongerEligible
    extends StudentCertificateWriteEffect {
  const StudentCertificateReexamNoLongerEligible(this.message);
  final String message;
}

class StudentCertificateWriteState {
  const StudentCertificateWriteState({
    this.eligibilityState =
        const ApiState<CertificateEligibilityEntity>.initial(),
    this.isSubmitting = false,
    this.restoredTransactionId,
    this.reexamRemaining = Duration.zero,
    this.effect,
  });

  final ApiState<CertificateEligibilityEntity> eligibilityState;
  final bool isSubmitting;
  final String? restoredTransactionId;
  final Duration reexamRemaining;
  final StudentCertificateWriteEffect? effect;

  StudentCertificateWriteState copyWith({
    ApiState<CertificateEligibilityEntity>? eligibilityState,
    bool? isSubmitting,
    String? restoredTransactionId,
    bool clearRestoredTransactionId = false,
    Duration? reexamRemaining,
    StudentCertificateWriteEffect? effect,
    bool clearEffect = false,
  }) {
    return StudentCertificateWriteState(
      eligibilityState: eligibilityState ?? this.eligibilityState,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      restoredTransactionId: clearRestoredTransactionId
          ? null
          : restoredTransactionId ?? this.restoredTransactionId,
      reexamRemaining: reexamRemaining ?? this.reexamRemaining,
      effect: clearEffect ? null : effect ?? this.effect,
    );
  }
}

@injectable
class StudentCertificateWriteCubit
    extends AppCoreCubit<StudentCertificateWriteState> {
  StudentCertificateWriteCubit(
    this._loadEligibility,
    this._submitCertificate,
    this._submitReexam,
    this._localDataSource,
  ) : super(const StudentCertificateWriteState());

  final LoadCertificateEligibilityUseCase _loadEligibility;
  final SubmitStudentCertificateUseCase _submitCertificate;
  final SubmitStudentCertificateReexamUseCase _submitReexam;
  final StudentCertificatesLocalDataSource _localDataSource;
  Timer? _countdownTimer;
  String? _reexamCertificateId;

  Future<void> initializeNewRequest() async {
    final stored = await _localDataSource.readNewTransactionId();
    stored.fold((_) {}, (value) {
      if (value != null) {
        emit(state.copyWith(restoredTransactionId: value));
      }
    });
    await _refreshEligibility();
  }

  Future<void> initializeReexam(String certificateId) async {
    _reexamCertificateId = certificateId;
    final stored = await _localDataSource.readReexamTransactionId(
      certificateId,
    );
    stored.fold((_) {}, (value) {
      if (value != null) {
        emit(state.copyWith(restoredTransactionId: value));
      }
    });
    final eligibility = await _refreshEligibility();
    if (eligibility == null) return;
    if (!eligibility.reexam.isRegistrationOpen) {
      emit(
        state.copyWith(
          effect: StudentCertificateReexamNoLongerEligible(
            eligibility.reexam.message ?? '',
          ),
        ),
      );
      return;
    }
    _startCountdown(eligibility.reexam);
  }

  Future<CertificateEligibilityEntity?> _refreshEligibility() async {
    emit(state.copyWith(eligibilityState: const ApiState.loading()));
    final result = await _loadEligibility();
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            eligibilityState: ApiState.failed(
              failure,
              retryFunction: _refreshEligibility,
            ),
          ),
        );
        return null;
      },
      (eligibility) {
        emit(state.copyWith(eligibilityState: ApiState.succeeded(eligibility)));
        return eligibility;
      },
    );
  }

  Future<void> persistNewTransactionId(String value) async {
    if (value.isEmpty) {
      await _localDataSource.clearNewTransactionId();
      return;
    }
    await _localDataSource.saveNewTransactionId(value);
  }

  Future<void> persistReexamTransactionId(String value) async {
    final certificateId = _reexamCertificateId;
    if (certificateId == null) return;
    if (value.isEmpty) {
      await _localDataSource.clearReexamTransactionId();
      return;
    }
    await _localDataSource.saveReexamTransactionId(certificateId, value);
  }

  Future<void> submitNewRequest({
    required TrainingType transmissionType,
    required bool transportRequested,
    required String rawTransactionId,
    required File personalPhoto,
    required File idFront,
    required File idBack,
  }) async {
    if (state.isSubmitting) return;
    final eligibility = state.eligibilityState.data.toNullable();
    if (eligibility == null ||
        !eligibility.newRequest.allowed ||
        !eligibility.newRequest.availableTransmissionTypes.contains(
          transmissionType,
        )) {
      return;
    }
    final transactionId = _validatedTransactionId(rawTransactionId);
    if (transactionId == null ||
        !_validateImages([personalPhoto, idFront, idBack])) {
      return;
    }
    emit(state.copyWith(isSubmitting: true, clearEffect: true));
    await _localDataSource.saveNewTransactionId(transactionId);
    final result = await _submitCertificate(
      SubmitStudentCertificateParams(
        transmissionType: transmissionType,
        transportRequested: transportRequested,
        transactionId: transactionId,
        personalPhoto: personalPhoto,
        idFront: idFront,
        idBack: idBack,
      ),
    );
    await result.fold(
      (failure) async => emit(
        state.copyWith(
          isSubmitting: false,
          effect: failure is ActiveCertificateConflictFailure
              ? const StudentCertificateWriteConflict()
              : StudentCertificateWriteFailed(failure),
        ),
      ),
      (_) async {
        await _localDataSource.clearNewTransactionId();
        emit(
          state.copyWith(
            isSubmitting: false,
            clearRestoredTransactionId: true,
            effect: const StudentCertificateWriteSucceeded(),
          ),
        );
      },
    );
  }

  Future<void> submitReexamRequest(String rawTransactionId) async {
    if (state.isSubmitting || state.reexamRemaining <= Duration.zero) return;
    final certificateId = _reexamCertificateId;
    final eligibility = state.eligibilityState.data.toNullable();
    if (certificateId == null ||
        eligibility == null ||
        !eligibility.reexam.isRegistrationOpen) {
      return;
    }
    final transactionId = _validatedTransactionId(rawTransactionId);
    if (transactionId == null) return;
    emit(state.copyWith(isSubmitting: true, clearEffect: true));
    await _localDataSource.saveReexamTransactionId(
      certificateId,
      transactionId,
    );
    final result = await _submitReexam(
      SubmitStudentCertificateReexamParams(
        certificateId: certificateId,
        transactionId: transactionId,
      ),
    );
    await result.fold(
      (failure) async => emit(
        state.copyWith(
          isSubmitting: false,
          effect: StudentCertificateWriteFailed(failure),
        ),
      ),
      (_) async {
        await _localDataSource.clearReexamTransactionId();
        await _refreshEligibility();
        emit(
          state.copyWith(
            isSubmitting: false,
            clearRestoredTransactionId: true,
            effect: const StudentCertificateWriteSucceeded(),
          ),
        );
      },
    );
  }

  String? _validatedTransactionId(String raw) {
    return ShamCashValidationRules.validateTransactionId(raw).fold((failure) {
      emit(state.copyWith(effect: StudentCertificateWriteFailed(failure)));
      return null;
    }, (value) => value);
  }

  bool _validateImages(List<File> files) {
    for (final file in files) {
      final failure = StudentCertificateWriteValidationRules.validateImage(
        file,
      ).fold<Failure?>((value) => value, (_) => null);
      if (failure != null) {
        emit(state.copyWith(effect: StudentCertificateWriteFailed(failure)));
        return false;
      }
    }
    return true;
  }

  void _startCountdown(CertificateReexamEligibility reexam) {
    _countdownTimer?.cancel();
    void tick() {
      final remaining = reexam.remainingUntilRegistrationCloses();
      emit(state.copyWith(reexamRemaining: remaining));
      if (remaining <= Duration.zero) _countdownTimer?.cancel();
    }

    tick();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => tick());
  }

  void clearEffect() => emit(state.copyWith(clearEffect: true));

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
