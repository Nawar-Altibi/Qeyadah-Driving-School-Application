import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_type.dart';

void main() {
  group('InstructorType.fromApi', () {
    test('parses MANUAL, AUTOMATIC, and BOTH', () {
      expect(InstructorType.fromApi('MANUAL'), InstructorType.manual);
      expect(InstructorType.fromApi('automatic'), InstructorType.automatic);
      expect(InstructorType.fromApi('BOTH'), InstructorType.both);
    });

    test('returns null for unknown values', () {
      expect(InstructorType.fromApi(null), isNull);
      expect(InstructorType.fromApi('UNKNOWN'), isNull);
    });
  });
}
