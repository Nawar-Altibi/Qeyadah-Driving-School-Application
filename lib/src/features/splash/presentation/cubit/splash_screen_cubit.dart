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
    // Bootstrap already spent time on the branded green splash; finish
    // immediately so navigation can leave as soon as auth restore completes.
    emit(state.copyWith(animationFinished: true));
  }
}
