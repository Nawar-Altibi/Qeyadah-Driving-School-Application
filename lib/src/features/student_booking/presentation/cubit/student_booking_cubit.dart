import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/state_management/draft_resettable.dart';
import 'package:qeyadah_mobile_app/src/core/utils/future_either_timeout.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/failures/student_booking_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/use_cases/student_booking_use_cases.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

part 'student_booking_cubit.freezed.dart';
part 'student_booking_state.dart';
part 'student_booking_effect.dart';

@injectable
class StudentBookingCubit
    extends
        AppCoreCoreCubit<StudentBookingState, StudentAvailableSlotsPageEntity>
    with DraftResettable {
  StudentBookingCubit(this._loadSlotsUseCase, this._createBookingUseCase)
    : super(const StudentBookingState());

  final LoadStudentAvailableSlotsUseCase _loadSlotsUseCase;
  final CreateStudentBookingUseCase _createBookingUseCase;

  int _loadGeneration = 0;

  @override
  ApiState<StudentAvailableSlotsPageEntity> getApiState(
    StudentBookingState state,
  ) => state.apiState;

  @override
  StudentBookingState setApiState(
    StudentBookingState state,
    ApiState<StudentAvailableSlotsPageEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  void updateTrainingType(TrainingType value) {
    emit(state.copyWith(filters: state.filters.copyWith(trainingType: value)));
  }

  void updateVehicleSource(VehicleSource value) {
    emit(state.copyWith(filters: state.filters.copyWith(vehicleSource: value)));
  }

  void updateInstructorGender(InstructorGender value) {
    emit(
      state.copyWith(filters: state.filters.copyWith(instructorGender: value)),
    );
  }

  void confirmPreferences() {
    emit(state.copyWith(effect: const StudentBookingEffectNavigateToSlots()));
  }

  Future<void> loadSlots({bool silent = false}) async {
    final generation = ++_loadGeneration;
    emit(
      state.copyWith(
        isSilentRefresh: silent,
        apiState: silent
            ? state.apiState
            : const ApiState<StudentAvailableSlotsPageEntity>.loading(),
      ),
    );

    final result = await _loadSlotsUseCase(
      LoadAvailableSlotsParams(
        trainingType: state.filters.trainingType,
        vehicleSource: state.filters.vehicleSource,
        instructorGender: state.filters.instructorGender,
      ),
    );

    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<StudentAvailableSlotsPageEntity>.failed(
            failure,
            retryFunction: loadSlots,
          ),
        ),
      ),
      (page) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<StudentAvailableSlotsPageEntity>.succeeded(page),
        ),
      ),
    );
  }

  void selectSlot(
    StudentBookingInstructorEntity instructor,
    StudentBookingSlotEntity slot,
  ) {
    emit(
      state.copyWith(
        selection: StudentBookingSelectionEntity(
          instructor: instructor,
          slot: slot,
        ),
      ),
    );
  }

  void confirmSlotSelection() {
    if (state.selection == null) return;
    emit(state.copyWith(effect: const StudentBookingEffectNavigateToReview()));
  }

  Future<void> createBooking() async {
    final selection = state.selection;
    if (selection == null) return;

    emit(state.copyWith(isCreatingBooking: true, effect: null));

    final result = await FutureEitherTimeout.guard(
      _createBookingUseCase(
        CreateStudentBookingParams(
          instructorId: selection.instructor.id,
          date: selection.slot.date,
          time: selection.slot.startTime,
          trainingType: state.filters.trainingType,
          vehicleSource: state.filters.vehicleSource,
        ),
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isCreatingBooking: false,
          effect: _effectForCreateFailure(failure),
        ),
      ),
      (hold) => emit(
        state.copyWith(
          isCreatingBooking: false,
          effect: StudentBookingEffectBookingCreated(hold),
        ),
      ),
    );
  }

  StudentBookingEffect _effectForCreateFailure(Failure failure) {
    if (failure is StudentBookingConflictFailure) {
      return switch (failure.reason) {
        StudentBookingConflictReason.pendingPaymentExists =>
          StudentBookingEffectPendingPaymentConflict(failure),
        StudentBookingConflictReason.slotUnavailable =>
          StudentBookingEffectSlotConflict(failure),
        StudentBookingConflictReason.studentTimeConflict =>
          StudentBookingEffectStudentTimeConflict(failure),
        StudentBookingConflictReason.unspecifiedConflict =>
          StudentBookingEffectBackendConflict(failure),
      };
    }
    return StudentBookingEffectActionFailed(failure);
  }

  void clearEffect() {
    emit(state.copyWith(effect: null));
  }

  void clearSelection() {
    emit(state.copyWith(selection: null));
  }

  @override
  void resetDraft() {
    _loadGeneration++;
    emit(const StudentBookingState());
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
