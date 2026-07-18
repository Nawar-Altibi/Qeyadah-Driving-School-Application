import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/config/bot_toast_config.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';

part 'splash_screen_cubit.freezed.dart';
part 'splash_screen_state.dart';

@lazySingleton
class SplashScreenCubit extends AppCoreCubit<SplashScreenState> {
  SplashScreenCubit() : super(const SplashScreenState()) {
    initialize();
  }

  Future<void> initialize() async {
    configureBotToast();
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(animationFinished: true));
  }
}
