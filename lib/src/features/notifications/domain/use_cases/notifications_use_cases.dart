import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/repositories/notifications_repository.dart';

@injectable
class LoadNotificationsUseCase {
  const LoadNotificationsUseCase(this._repository);

  final NotificationsRepository _repository;

  FutureEither<AppNotificationsPageEntity> call({
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getNotifications(page: page, limit: limit);
  }
}

@injectable
class LoadUnreadNotificationsCountUseCase {
  const LoadUnreadNotificationsCountUseCase(this._repository);

  final NotificationsRepository _repository;

  FutureEither<int> call() => _repository.getUnreadCount();
}

@injectable
class MarkNotificationReadUseCase {
  const MarkNotificationReadUseCase(this._repository);

  final NotificationsRepository _repository;

  FutureEither<void> call(int id) => _repository.markRead(id);
}

@injectable
class MarkAllNotificationsReadUseCase {
  const MarkAllNotificationsReadUseCase(this._repository);

  final NotificationsRepository _repository;

  FutureEither<void> call() => _repository.markAllRead();
}

@injectable
class RegisterDeviceTokenUseCase {
  const RegisterDeviceTokenUseCase(this._repository);

  final NotificationsRepository _repository;

  FutureEither<void> call({required String token, required String platform}) {
    return _repository.registerDeviceToken(token: token, platform: platform);
  }
}

@injectable
class UnregisterDeviceTokenUseCase {
  const UnregisterDeviceTokenUseCase(this._repository);

  final NotificationsRepository _repository;

  FutureEither<void> call(String token) {
    return _repository.unregisterDeviceToken(token);
  }
}
