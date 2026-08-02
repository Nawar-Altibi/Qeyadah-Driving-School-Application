import 'dart:io';

import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

class MockApiHandler extends Mock implements ApiHandlerInterface {}

void main() {
  late MockApiHandler apiHandler;
  late StudentCertificatesRemoteDataSourceImpl dataSource;
  late Directory tempDirectory;

  setUp(() async {
    apiHandler = MockApiHandler();
    dataSource = StudentCertificatesRemoteDataSourceImpl(apiHandler);
    tempDirectory = await Directory.systemTemp.createTemp('certificate-write');
  });

  tearDown(() => tempDirectory.delete(recursive: true));

  test('maps new request to the exact multipart contract', () async {
    final photo = await File(
      '${tempDirectory.path}/photo.jpg',
    ).writeAsBytes([1]);
    final front = await File(
      '${tempDirectory.path}/front.png',
    ).writeAsBytes([2]);
    final back = await File(
      '${tempDirectory.path}/back.webp',
    ).writeAsBytes([3]);
    when(
      () => apiHandler.post(
        any(),
        formData: any(named: 'formData'),
        isAuthorized: any(named: 'isAuthorized'),
      ),
    ).thenAnswer((_) async => right({'statusCode': 201}));

    await dataSource.submitCertificate(
      SubmitStudentCertificateParams(
        transmissionType: TrainingType.manual,
        transportRequested: false,
        transactionId: '012345678',
        personalPhoto: photo,
        idFront: front,
        idBack: back,
      ),
    );

    final captured =
        verify(
              () => apiHandler.post(
                Endpoints.studentCertificates,
                formData: captureAny(named: 'formData'),
                isAuthorized: true,
              ),
            ).captured.single
            as MultipartFormDataAdapter;
    final formData = captured.create();
    expect(Map.fromEntries(formData.fields), {
      'transmissionType': 'MANUAL',
      'transportRequested': 'false',
      'transactionId': '012345678',
    });
    expect(formData.files.map((entry) => entry.key).toSet(), {
      'personalPhoto',
      'idFront',
      'idBack',
    });
    expect(formData.fields.any((entry) => entry.key == 'category'), isFalse);
  });

  test('reexam body contains transactionId only and never examType', () async {
    when(
      () => apiHandler.post(
        any(),
        body: any(named: 'body'),
        isAuthorized: any(named: 'isAuthorized'),
      ),
    ).thenAnswer((_) async => right({'statusCode': 201}));

    await dataSource.submitReexam(
      const SubmitStudentCertificateReexamParams(
        certificateId: '42',
        transactionId: '012345678',
      ),
    );

    final body =
        verify(
              () => apiHandler.post(
                Endpoints.studentCertificateReexam('42'),
                body: captureAny(named: 'body'),
                isAuthorized: true,
              ),
            ).captured.single
            as Map<String, dynamic>;
    expect(body, {'transactionId': '012345678'});
    expect(body.containsKey('examType'), isFalse);
  });
}
