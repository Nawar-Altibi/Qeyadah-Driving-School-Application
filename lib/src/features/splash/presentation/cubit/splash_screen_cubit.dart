import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qeyadah_mobile_app/src/core/config/bot_toast_config.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:injectable/injectable.dart';

part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart';

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
