enum TrainingType {
  manual,
  automatic;

  static TrainingType? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'MANUAL' => TrainingType.manual,
      'AUTOMATIC' => TrainingType.automatic,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    TrainingType.manual => 'MANUAL',
    TrainingType.automatic => 'AUTOMATIC',
  };
}
