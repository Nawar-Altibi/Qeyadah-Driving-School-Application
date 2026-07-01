part of 'splash_screen_cubit.dart';

@freezed
abstract class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState({@Default(false) bool animationFinished}) =
      _SplashScreenState;
}
