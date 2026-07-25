import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/notifications/firebase_bootstrap.dart';

const String kDefaultAndroidNotificationChannelId = 'default_channel';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseBootstrap.ensureInitialized();
}

@lazySingleton
class LocalNotificationPresenter {
  LocalNotificationPresenter();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  void Function(Map<String, dynamic> data)? onNotificationTap;

  Future<void> initialize() async {
    if (_initialized || kIsWeb) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;
        try {
          final decoded = jsonDecode(payload);
          if (decoded is Map<String, dynamic>) {
            onNotificationTap?.call(decoded);
          } else if (decoded is Map) {
            onNotificationTap?.call(Map<String, dynamic>.from(decoded));
          }
        } on Object {
          // Ignore malformed local payloads.
        }
      },
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        kDefaultAndroidNotificationChannelId,
        'الإشعارات',
        description: 'إشعارات تطبيق قيادة',
        importance: Importance.high,
      ),
    );

    _initialized = true;
  }

  Future<void> showRemoteMessage(RemoteMessage message) async {
    if (!_initialized) await initialize();
    final notification = message.notification;
    if (notification == null) return;

    await _plugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          kDefaultAndroidNotificationChannelId,
          'الإشعارات',
          channelDescription: 'إشعارات تطبيق قيادة',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.data),
    );
  }
}

@lazySingleton
class PushMessagingService {
  PushMessagingService(this._localNotifications);

  final LocalNotificationPresenter _localNotifications;

  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedSub;

  void Function(Map<String, dynamic> data)? onOpened;
  void Function(RemoteMessage message)? onForegroundMessage;

  Future<bool> ensureReady() async {
    if (kIsWeb) return false;
    final ready = await FirebaseBootstrap.ensureInitialized();
    if (!ready) return false;
    await _localNotifications.initialize();
    _localNotifications.onNotificationTap = onOpened;
    return true;
  }

  Future<void> requestPermission() async {
    if (!await ensureReady()) return;
    await FirebaseMessaging.instance.requestPermission();
    if (!kIsWeb && Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  Future<String?> getToken() async {
    if (!await ensureReady()) return null;
    try {
      return await FirebaseMessaging.instance.getToken();
    } on Object {
      return null;
    }
  }

  String platformLabel() {
    if (!kIsWeb && Platform.isIOS) return 'IOS';
    return 'ANDROID';
  }

  Future<void> startListeners() async {
    if (!await ensureReady()) return;

    _foregroundSub ??= FirebaseMessaging.onMessage.listen((message) async {
      onForegroundMessage?.call(message);
      await _localNotifications.showRemoteMessage(message);
    });

    _openedSub ??= FirebaseMessaging.onMessageOpenedApp.listen((message) {
      onOpened?.call(Map<String, dynamic>.from(message.data));
    });

    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      onOpened?.call(Map<String, dynamic>.from(initial.data));
    }
  }

  void listenTokenRefresh(Future<void> Function(String token) onRefresh) {
    _tokenRefreshSub?.cancel();
    if (!FirebaseBootstrap.isReady) return;
    _tokenRefreshSub = FirebaseMessaging.instance.onTokenRefresh.listen(
      onRefresh,
    );
  }

  Future<void> stop() async {
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    await _openedSub?.cancel();
    _tokenRefreshSub = null;
    _foregroundSub = null;
    _openedSub = null;
  }
}
