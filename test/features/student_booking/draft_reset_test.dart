import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/use_cases/student_booking_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/use_cases/student_certificates_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_write_cubit.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

class MockStudentBookingRepository extends Mock
    implements StudentBookingRepository {}

class MockLocalDataSource extends Mock
    implements StudentCertificatesLocalDataSource {}

class MockLoadEligibility extends Mock
    implements LoadCertificateEligibilityUseCase {}

class MockSubmitCertificate extends Mock
    implements SubmitStudentCertificateUseCase {}

class MockSubmitReexam extends Mock
    implements SubmitStudentCertificateReexamUseCase {}

void main() {
  group('StudentBookingCubit.resetDraft', () {
    late StudentBookingCubit cubit;

    setUp(() {
      final repository = MockStudentBookingRepository();
      cubit = StudentBookingCubit(
        LoadStudentAvailableSlotsUseCase(repository),
        CreateStudentBookingUseCase(repository),
      );
    });

    tearDown(() => cubit.close());

    blocTest<StudentBookingCubit, StudentBookingState>(
      'resets filters and selection to construction defaults',
      build: () => cubit,
      act: (c) {
        c.updateTrainingType(TrainingType.automatic);
        c.updateInstructorGender(InstructorGender.female);
        c.resetDraft();
      },
      verify: (c) {
        expect(c.state.filters.trainingType, TrainingType.manual);
        expect(c.state.filters.instructorGender, InstructorGender.male);
        expect(c.state.selection, isNull);
        expect(c.state.apiState.isInitial, isTrue);
      },
    );
  });

  group('StudentCertificateWriteCubit.resetDraft', () {
    late MockLocalDataSource local;
    late StudentCertificateWriteCubit cubit;

    setUp(() {
      local = MockLocalDataSource();
      when(
        () => local.clearNewTransactionId(),
      ).thenAnswer((_) async => right(null));
      when(
        () => local.clearReexamTransactionId(),
      ).thenAnswer((_) async => right(null));
      cubit = StudentCertificateWriteCubit(
        MockLoadEligibility(),
        MockSubmitCertificate(),
        MockSubmitReexam(),
        local,
      );
    });

    tearDown(() => cubit.close());

    test(
      'clears persisted transaction ids and restores initial state',
      () async {
        cubit.emit(cubit.state.copyWith(restoredTransactionId: '123456789'));
        cubit.resetDraft();
        await Future<void>.delayed(Duration.zero);

        expect(cubit.state.restoredTransactionId, isNull);
        expect(cubit.state.isSubmitting, isFalse);
        verify(() => local.clearNewTransactionId()).called(1);
        verify(() => local.clearReexamTransactionId()).called(1);
      },
    );
  });
}
