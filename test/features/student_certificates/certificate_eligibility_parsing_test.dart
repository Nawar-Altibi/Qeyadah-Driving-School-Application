import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/parsers/certificate_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_category.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

class MockApiHandler extends Mock implements ApiHandlerInterface {}

void main() {
  group('CertificateJsonParsers', () {
    test('parses certificate ids from string or number', () {
      expect(CertificateJsonParsers.parseCertificateId('42'), '42');
      expect(CertificateJsonParsers.parseCertificateId(42), '42');
      expect(CertificateJsonParsers.parseCertificateId(null), isNull);
    });

    test('parses courseNumber and fee flexibly', () {
      expect(CertificateJsonParsers.parseCourseNumber(183), 183);
      expect(CertificateJsonParsers.parseCourseNumber('183'), 183);
      expect(CertificateJsonParsers.parseFee(300000), 300000);
      expect(CertificateJsonParsers.parseFee('300000'), 300000);
    });
  });

  group('StudentCertificatesRemoteDataSourceImpl.fetchEligibility', () {
    late MockApiHandler apiHandler;
    late StudentCertificatesRemoteDataSourceImpl dataSource;

    setUp(() {
      apiHandler = MockApiHandler();
      dataSource = StudentCertificatesRemoteDataSourceImpl(apiHandler);
    });

    test(
      'maps new-request eligibility with numeric activeCertificateId',
      () async {
        when(
          () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
        ).thenAnswer(
          (_) async => right({
            'statusCode': 200,
            'data': {
              'canSubmitNewRequest': true,
              'activeCertificateId': null,
              'newRequest': {
                'allowed': true,
                'availableTransmissionTypes': ['MANUAL', 'AUTOMATIC'],
                'completedCategories': <String>[],
                'reason': null,
                'message': 'يمكنك تقديم طلب شهادة لأول مرة.',
              },
              'reexam': {
                'eligible': false,
                'reason': 'NO_ACTIVE_REQUEST',
                'message': 'يمكنك تقديم طلب شهادة لأول مرة.',
              },
            },
          }),
        );

        final result = await dataSource.fetchEligibility();
        expect(result.isRight(), isTrue);
        final eligibility = result.fold((_) => null, (value) => value)!;
        expect(eligibility.newRequest.allowed, isTrue);
        expect(eligibility.newRequest.isFirstRequest, isTrue);
        expect(eligibility.newRequest.availableTransmissionTypes, [
          TrainingType.manual,
          TrainingType.automatic,
        ]);
        expect(eligibility.reexam.eligible, isFalse);
        expect(eligibility.reexam.reason, 'NO_ACTIVE_REQUEST');
        verify(
          () => apiHandler.get(
            Endpoints.studentCertificatesEligibility,
            isAuthorized: true,
          ),
        ).called(1);
      },
    );

    test('maps eligible reexam payload and treats id as string', () async {
      when(
        () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'canSubmitNewRequest': false,
            'activeCertificateId': 42,
            'requestStatus': 'WAITING_FOR_THEORETICAL_EXAM',
            'courseNumber': 99,
            'newRequest': {
              'allowed': false,
              'availableTransmissionTypes': <String>[],
              'completedCategories': ['B1'],
              'reason': 'ACTIVE_REQUEST_EXISTS',
              'message': null,
            },
            'reexam': {
              'eligible': true,
              'examType': 'THEORY',
              'fee': 300000,
              'examScheduledAt': '2026-08-09T06:00:00.000Z',
              'examScheduledLabel': 'الأحد 2026-08-09 الساعة 09:00',
              'registrationClosesAt': '2099-08-08T06:00:00.000Z',
              'registrationClosesLabel': 'السبت 2026-08-08 الساعة 09:00',
              'courseNumber': 100,
              'reason': null,
              'message': null,
            },
          },
        }),
      );

      final result = await dataSource.fetchEligibility();
      final eligibility = result.fold((_) => null, (value) => value)!;
      expect(eligibility.activeCertificateId, '42');
      expect(
        eligibility.requestStatus,
        CertificateRequestStatus.waitingForTheoreticalExam,
      );
      expect(eligibility.courseNumber, 99);
      expect(eligibility.reexam.eligible, isTrue);
      expect(eligibility.reexam.examType, ExamType.theory);
      expect(eligibility.reexam.fee, 300000);
      expect(eligibility.reexam.courseNumber, 100);
      expect(eligibility.reexam.isRegistrationOpen, isTrue);
      expect(eligibility.newRequest.completedCategories, [
        CertificateCategory.b1,
      ]);
    });

    test('maps ALL_CATEGORIES_COMPLETED status-only case', () async {
      when(
        () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'canSubmitNewRequest': false,
            'activeCertificateId': null,
            'newRequest': {
              'allowed': false,
              'availableTransmissionTypes': <String>[],
              'completedCategories': ['B', 'B1'],
              'reason': 'ALL_CATEGORIES_COMPLETED',
              'message': 'لديك شهادات الفئات B وB1 مكتملة',
            },
            'reexam': {
              'eligible': false,
              'reason': 'NO_ACTIVE_REQUEST',
              'message': 'لا طلب فعّال',
            },
          },
        }),
      );

      final result = await dataSource.fetchEligibility();
      final eligibility = result.fold((_) => null, (value) => value)!;
      expect(eligibility.newRequest.allowed, isFalse);
      expect(eligibility.newRequest.reason, 'ALL_CATEGORIES_COMPLETED');
      expect(eligibility.reexam.eligible, isFalse);
    });

    test('maps ALREADY_REGISTERED as non-eligible reexam', () async {
      when(
        () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'canSubmitNewRequest': false,
            'activeCertificateId': '12',
            'newRequest': {
              'allowed': false,
              'availableTransmissionTypes': <String>[],
              'completedCategories': <String>[],
              'reason': 'ACTIVE_REQUEST_EXISTS',
              'message': null,
            },
            'reexam': {
              'eligible': false,
              'reason': 'ALREADY_REGISTERED',
              'message': 'أنت مسجَّل بالفعل لهذا الامتحان',
            },
          },
        }),
      );

      final result = await dataSource.fetchEligibility();
      final eligibility = result.fold((_) => null, (value) => value)!;
      expect(eligibility.reexam.eligible, isFalse);
      expect(eligibility.reexam.reason, 'ALREADY_REGISTERED');
      expect(eligibility.activeCertificateId, '12');
    });
  });
}
