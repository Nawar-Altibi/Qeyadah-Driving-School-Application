import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';

void main() {
  group('StudentBookingsPageEntity', () {
    test('hasMorePages is true while page is below totalPages', () {
      const page = StudentBookingsPageEntity(
        items: [],
        total: 40,
        page: 1,
        limit: 20,
        totalPages: 2,
      );
      expect(page.hasMorePages, isTrue);
    });

    test('hasMorePages is false on the last page', () {
      const page = StudentBookingsPageEntity(
        items: [],
        total: 40,
        page: 2,
        limit: 20,
        totalPages: 2,
      );
      expect(page.hasMorePages, isFalse);
    });

    test('appendPage concatenates items and adopts the next page metadata', () {
      final first = StudentBookingsPageEntity(
        items: [StudentBookingListItemEntity.placeholder()],
        total: 3,
        page: 1,
        limit: 2,
        totalPages: 2,
      );
      final second = StudentBookingsPageEntity(
        items: [StudentBookingListItemEntity.placeholder(id: '2')],
        total: 3,
        page: 2,
        limit: 2,
        totalPages: 2,
      );

      final merged = first.appendPage(second);

      expect(merged.items.map((item) => item.id), ['1', '2']);
      expect(merged.page, 2);
      expect(merged.hasMorePages, isFalse);
    });
  });
}
