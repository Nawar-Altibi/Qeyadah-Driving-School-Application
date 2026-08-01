enum VehicleSource {
  schoolCar,
  studentCar;

  static VehicleSource? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'SCHOOL_CAR' => VehicleSource.schoolCar,
      'STUDENT_CAR' => VehicleSource.studentCar,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    VehicleSource.schoolCar => 'SCHOOL_CAR',
    VehicleSource.studentCar => 'STUDENT_CAR',
  };
}
