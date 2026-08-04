import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/cache/app_ttl_cache.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._remoteDataSource);

  final NotificationsRemoteDataSource _remoteDataSource;

  static const _unreadKey = 'unread_count';
  final _unreadCache = AppTtlCache<int>(ttl: const Duration(seconds: 45));

  @override
  FutureEither<AppNotificationsPageEntity> getNotifications({
    int page = 1,
    int limit = 20,
  }) {
    return _remoteDataSource.fetchNotifications(page: page, limit: limit);
  }

  @override
  FutureEither<int> getUnreadCount({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = _unreadCache.getFresh(_unreadKey);
      if (cached != null) return right(cached);
    }

    final result = await _remoteDataSource.fetchUnreadCount();
    return result.fold(left, (count) {
      _unreadCache.set(_unreadKey, count);
      return right(count);
    });
  }

  @override
  FutureEither<void> markRead(int id) async {
    final result = await _remoteDataSource.markRead(id);
    return result.fold(left, (value) {
      _unreadCache.invalidate(_unreadKey);
      return right(value);
    });
  }

  @override
  FutureEither<void> markAllRead() async {
    final result = await _remoteDataSource.markAllRead();
    return result.fold(left, (value) {
      _unreadCache.invalidate(_unreadKey);
      return right(value);
    });
  }

  @override
  FutureEither<void> registerDeviceToken({
    required String token,
    required String platform,
  }) {
    return _remoteDataSource.registerDeviceToken(
      token: token,
      platform: platform,
    );
  }

  @override
  FutureEither<void> unregisterDeviceToken(String token) {
    return _remoteDataSource.unregisterDeviceToken(token);
  }
}
