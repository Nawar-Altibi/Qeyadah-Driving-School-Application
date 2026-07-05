enum InstructorType {
  manual,
  automatic;

  static InstructorType? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'MANUAL' => InstructorType.manual,
      'AUTOMATIC' => InstructorType.automatic,
      _ => null,
    };
  }
}
