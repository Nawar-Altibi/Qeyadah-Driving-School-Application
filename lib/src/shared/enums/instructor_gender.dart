enum InstructorGender {
  male,
  female;

  static InstructorGender? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'MALE' => InstructorGender.male,
      'FEMALE' => InstructorGender.female,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    InstructorGender.male => 'MALE',
    InstructorGender.female => 'FEMALE',
  };
}
