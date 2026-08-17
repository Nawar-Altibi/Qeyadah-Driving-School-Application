enum InstructorType {
  manual,
  automatic,
  both;

  static InstructorType? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'MANUAL' => InstructorType.manual,
      'AUTOMATIC' => InstructorType.automatic,
      'BOTH' => InstructorType.both,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    InstructorType.manual => 'MANUAL',
    InstructorType.automatic => 'AUTOMATIC',
    InstructorType.both => 'BOTH',
  };
}
