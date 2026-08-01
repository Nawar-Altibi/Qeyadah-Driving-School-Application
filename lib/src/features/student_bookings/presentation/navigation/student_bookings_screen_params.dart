import 'package:coore/lib.dart';

/// Carries the numeric booking id to the detail route via `extra`, since
/// booking ids from the list are strings but the detail endpoint expects a
/// path number.
class StudentBookingDetailScreenParams extends BaseScreenParams {
  const StudentBookingDetailScreenParams({required this.bookingId});

  final int bookingId;

  static const String bookingIdExtraKey = 'studentBookingDetailId';

  @override
  Map<String, Object> get extra => {bookingIdExtraKey: bookingId};

  @override
  List<Object?> get props => [bookingId];
}

int? studentBookingDetailIdFromExtra(Object? extra) {
  if (extra is! Map) return null;
  final value = extra[StudentBookingDetailScreenParams.bookingIdExtraKey];
  return value is int ? value : null;
}
