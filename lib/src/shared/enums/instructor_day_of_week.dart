enum InstructorDayOfWeek {
  sat,
  sun,
  mon,
  tue,
  wed,
  thu,
  fri;

  static InstructorDayOfWeek? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'SAT' => InstructorDayOfWeek.sat,
      'SUN' => InstructorDayOfWeek.sun,
      'MON' => InstructorDayOfWeek.mon,
      'TUE' => InstructorDayOfWeek.tue,
      'WED' => InstructorDayOfWeek.wed,
      'THU' => InstructorDayOfWeek.thu,
      'FRI' => InstructorDayOfWeek.fri,
      _ => null,
    };
  }

  static InstructorDayOfWeek fromDateTime(DateTime date) {
    return switch (date.weekday) {
      DateTime.monday => InstructorDayOfWeek.mon,
      DateTime.tuesday => InstructorDayOfWeek.tue,
      DateTime.wednesday => InstructorDayOfWeek.wed,
      DateTime.thursday => InstructorDayOfWeek.thu,
      DateTime.friday => InstructorDayOfWeek.fri,
      DateTime.saturday => InstructorDayOfWeek.sat,
      _ => InstructorDayOfWeek.sun,
    };
  }

  String get apiValue => switch (this) {
    InstructorDayOfWeek.sat => 'SAT',
    InstructorDayOfWeek.sun => 'SUN',
    InstructorDayOfWeek.mon => 'MON',
    InstructorDayOfWeek.tue => 'TUE',
    InstructorDayOfWeek.wed => 'WED',
    InstructorDayOfWeek.thu => 'THU',
    InstructorDayOfWeek.fri => 'FRI',
  };
}
