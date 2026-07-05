import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart';

class RegisterOtpScreenParams extends BaseScreenParams {
  const RegisterOtpScreenParams({required this.cubit});

  final RegistrationCubit cubit;

  static const String cubitExtraKey = 'registrationCubit';

  @override
  Map<String, Object> get extra => {cubitExtraKey: cubit};

  @override
  List<Object?> get props => [cubit];
}

class NewPasswordScreenParams extends BaseScreenParams {
  const NewPasswordScreenParams({
    required this.cubit,
    required this.phone,
  });

  final PasswordResetCubit cubit;
  final String phone;

  static const String cubitExtraKey = 'passwordResetCubit';

  @override
  Map<String, String> get queryParams => {'phone': phone};

  @override
  Map<String, Object> get extra => {cubitExtraKey: cubit};

  @override
  List<Object?> get props => [cubit, phone];
}

RegistrationCubit? registrationCubitFromExtra(Object? extra) {
  if (extra is! Map) return null;
  final value = extra[RegisterOtpScreenParams.cubitExtraKey];
  return value is RegistrationCubit ? value : null;
}

PasswordResetCubit? passwordResetCubitFromExtra(Object? extra) {
  if (extra is! Map) return null;
  final value = extra[NewPasswordScreenParams.cubitExtraKey];
  return value is PasswordResetCubit ? value : null;
}
