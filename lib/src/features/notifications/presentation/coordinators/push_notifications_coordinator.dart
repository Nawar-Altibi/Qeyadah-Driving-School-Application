import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/notifications/push_messaging_service.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/use_cases/notifications_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_unread_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notification_deep_link_router.dart';

/// Wires FCM token lifecycle + push open handlers to domain use cases.
@lazySingleton
class PushNotificationsCoordinator {
  PushNotificationsCoordinator(
    this._pushMessaging,
    this._registerDeviceToken,
    this._unregisterDeviceToken,
    this._unreadCubit,
    this._deepLinkRouter,
    this._invalidateWeeklyScheduleCache,
  );

  final PushMessagingService _pushMessaging;
  final RegisterDeviceTokenUseCase _registerDeviceToken;
  final UnregisterDeviceTokenUseCase _unregisterDeviceToken;
  final NotificationsUnreadCubit _unreadCubit;
  final NotificationDeepLinkRouter _deepLinkRouter;
  final InvalidateInstructorWeeklyScheduleCacheUseCase
  _invalidateWeeklyScheduleCache;

  final StreamController<void> _certificateStatusChangedController =
      StreamController<void>.broadcast();

  /// Emits when a `CERTIFICATE_STATUS_CHANGED` push arrives in the foreground
  /// or when the user opens the app from such a notification.
  Stream<void> get certificateStatusChanged =>
      _certificateStatusChangedController.stream;

  bool _started = false;

  Future<void> startForAuthenticatedSession() async {
    await _pushMessaging.requestPermission();
    final ready = await _pushMessaging.ensureReady();
    if (!ready) return;

    _pushMessaging.onOpened = (data) {
      _handleOpened(data);
    };
    _pushMessaging.onForegroundMessage = _handleForegroundMessage;

    await _pushMessaging.startListeners();
    _pushMessaging.listenTokenRefresh(_registerCurrentToken);
    await _registerCurrentToken();
    await _unreadCubit.refresh();
    _started = true;
  }

  Future<void> stopAndUnregister() async {
    try {
      if (_started) {
        final token = await _pushMessaging.getToken();
        if (token != null && token.isNotEmpty) {
          await _unregisterDeviceToken(
            token,
          ).timeout(const Duration(seconds: 4));
        }
      }
    } on Object {
      // Unregister is best-effort during logout; never block session clear.
    } finally {
      await _pushMessaging.stop();
      _unreadCubit.reset();
      _started = false;
    }
  }

  Future<void> _registerCurrentToken([String? refreshed]) async {
    final token = refreshed ?? await _pushMessaging.getToken();
    if (token == null || token.isEmpty) return;
    await _registerDeviceToken(
      token: token,
      platform: _pushMessaging.platformLabel(),
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _unreadCubit.refresh();
    final type = AppNotificationType.fromApi(
      message.data['type']?.toString() ??
          message.data['notificationType']?.toString(),
    );
    if (type == AppNotificationType.certificateStatusChanged) {
      _certificateStatusChangedController.add(null);
    }
  }

  Future<void> _handleOpened(Map<String, dynamic> data) async {
    final type = AppNotificationType.fromApi(
      data['type']?.toString() ?? data['notificationType']?.toString(),
    );
    if (type == AppNotificationType.instructorSchedule) {
      await _invalidateWeeklyScheduleCache();
    }
    if (type == AppNotificationType.certificateStatusChanged) {
      // Hub (and other listeners) must refetch /eligibility after deep-link
      // navigation, not only when the push arrives in the foreground.
      _certificateStatusChangedController.add(null);
    }
    _deepLinkRouter.openFromPushData(data);
    await _unreadCubit.refresh();
  }
}
