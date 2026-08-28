import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/parsers/certificate_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';

class MockApiHandler extends Mock implements ApiHandlerInterface {}

void main() {
  late MockApiHandler apiHandler;
  late StudentCertificatesRemoteDataSourceImpl dataSource;

  setUp(() {
    apiHandler = MockApiHandler();
    dataSource = StudentCertificatesRemoteDataSourceImpl(apiHandler);
  });

  test('parses double-wrapped certificate list and pagination meta', () async {
    when(
      () => apiHandler.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        isAuthorized: any(named: 'isAuthorized'),
      ),
    ).thenAnswer(
      (_) async => right({
        'statusCode': 200,
        'data': {
          'data': [
            {
              'id': 9007199254740991,
              'studentName': 'Nawar',
              'studentPhone': '0999000000',
              'category': 'B',
              'transmissionType': 'MANUAL',
              'requestStatus': 'WAITING_FOR_THEORETICAL_EXAM',
              'transportRequested': true,
              'courseNumber': '18',
              'requestedAt': '2026-08-01T08:00:00.000Z',
            },
          ],
          'meta': {'total': 1, 'page': 1, 'limit': 20, 'totalPages': 1},
        },
      }),
    );

    final result = await dataSource.fetchCertificates(
      LoadStudentCertificatesParams(),
    );
    final page = result.fold((failure) => throw failure, (value) => value);

    expect(page.items.single.id, '9007199254740991');
    expect(page.items.single.courseNumber, 18);
    expect(page.total, 1);
    expect(page.limit, 20);
    verify(
      () => apiHandler.get(
        Endpoints.studentCertificates,
        queryParameters: {'page': 1, 'limit': 20},
        isAuthorized: true,
      ),
    ).called(1);
  });

  test('parses detail ids and monetary values as strings', () async {
    when(
      () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
    ).thenAnswer(
      (_) async => right({
        'data': {
          'certificate': {
            'id': 42,
            'studentName': 'Nawar',
            'studentPhone': '0999000000',
            'category': 'B1',
            'transmissionType': 'AUTOMATIC',
            'requestStatus': 'WAITING_FOR_PRACTICAL_EXAM',
            'transportRequested': false,
            'courseNumber': 7,
          },
          'student': {
            'id': '12',
            'name': 'Nawar',
            'phone': '0999000000',
            'studentStatus': 'ACTIVE',
          },
          'documents': {
            'personalPhotoUrl': 'https://example.com/photo',
            'idFrontUrl': 'https://example.com/front',
            'idBackUrl': 'https://example.com/back',
          },
          'sessions': [
            {
              'id': 3,
              'sessionNumber': 1,
              'scheduledAt': '2026-08-01T08:00:00.000Z',
              'label': 'السبت 11:00',
            },
          ],
          'exams': [
            {
              'id': '8',
              'examType': 'PRACTICAL',
              'attemptNumber': 1,
              'scheduledAt': '2026-08-10T08:00:00.000Z',
              'examResult': null,
            },
            {
              'id': 7,
              'examType': 'THEORY',
              'attemptNumber': 1,
              'scheduledAt': '2026-08-09T08:00:00.000Z',
              'examResult': 'PASS',
            },
          ],
          'charges': [
            {
              'id': 10,
              'chargeReason': 'CERTIFICATE_FEE',
              'amountDue': 300000,
              'chargeStatus': 'PARTIALLY_PAID',
              'payments': [
                {
                  'id': '11',
                  'amountPaid': 100000.50,
                  'paymentMethod': 'SHAM_CASH',
                  'receivedAt': '2026-08-01T08:00:00.000Z',
                },
              ],
            },
          ],
          'actions': {
            'reexam': {'eligible': false, 'reason': 'NOT_ELIGIBLE'},
          },
        },
      }),
    );

    final result = await dataSource.fetchCertificateDetail('42');
    final detail = result.fold((failure) => throw failure, (value) => value);

    expect(detail.certificate.id, '42');
    expect(detail.student.id, '12');
    expect(detail.sessions.single.id, '3');
    expect(detail.exams.map((exam) => exam.examType), [
      ExamType.theory,
      ExamType.practical,
    ]);
    expect(detail.charges.single.id, '10');
    expect(detail.charges.single.amountDue, '300000');
    expect(detail.charges.single.payments.single.id, '11');
    expect(detail.charges.single.payments.single.amountPaid, '100000.5');
  });

  test('resolves signed document URLs without duplicating api path', () {
    const base = 'https://api.example.com/api/v1/';
    expect(
      CertificateJsonParsers.resolveDocumentUrl(
        '/api/v1/storage/objects/file?token=x',
        baseUrl: base,
      ),
      'https://api.example.com/api/v1/storage/objects/file?token=x',
    );
    expect(
      CertificateJsonParsers.resolveDocumentUrl('storage/file', baseUrl: base),
      'https://api.example.com/api/v1/storage/file',
    );
  });
}
