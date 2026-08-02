import 'package:coore/lib.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';

abstract interface class NotificationsRemoteDataSource {
  FutureEither<AppNotificationsPageEntity> fetchNotifications({
    required int page,
    required int limit,
  });

  FutureEither<int> fetchUnreadCount();

  FutureEither<void> markRead(int id);

  FutureEither<void> markAllRead();

  FutureEither<void> registerDeviceToken({
    required String token,
    required String platform,
  });

  FutureEither<void> unregisterDeviceToken(String token);
}

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(
    this._apiHandler,
    this._dio,
    this._exceptionMapper,
  );

  final ApiHandlerInterface _apiHandler;

  /// Shared Dio (auth interceptors already attached). Used only for DELETE with
  /// a JSON body — Coore's [ApiHandlerInterface.delete] does not accept a body.
  final Dio _dio;
  final NetworkExceptionMapper _exceptionMapper;

  @override
  FutureEither<AppNotificationsPageEntity> fetchNotifications({
    required int page,
    required int limit,
  }) async {
    final response = await _apiHandler.get(
      Endpoints.notifications,
      queryParameters: {'page': page, 'limit': limit},
    );
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (json) {
        try {
          return right(_pageFromJson(json, fallbackPage: page, limit: limit));
        } on Exception catch (error, stackTrace) {
          return left(
            FormatFailure(message: error.toString(), stackTrace: stackTrace),
          );
        }
      },
    );
  }

  @override
  FutureEither<int> fetchUnreadCount() async {
    final response = await _apiHandler.get(Endpoints.notificationsUnreadCount);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (json) {
        final data = _unwrapData(json);
        final count = (data['unreadCount'] as num?)?.toInt() ?? 0;
        return right(count);
      },
    );
  }

  @override
  FutureEither<void> markRead(int id) async {
    final response = await _apiHandler.put(Endpoints.notificationRead(id));
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (_) => right(null),
    );
  }

  @override
  FutureEither<void> markAllRead() async {
    final response = await _apiHandler.put(Endpoints.notificationsReadAll);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (_) => right(null),
    );
  }

  @override
  FutureEither<void> registerDeviceToken({
    required String token,
    required String platform,
  }) async {
    final response = await _apiHandler.post(
      Endpoints.devicesToken,
      body: {'token': token, 'platform': platform},
    );
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (_) => right(null),
    );
  }

  @override
  FutureEither<void> unregisterDeviceToken(String token) async {
    // Backend DELETE /devices/token expects `{ "token": "..." }` in the body
    // (RegisterDeviceTokenDto). Coore's delete API has no body arg, so call Dio
    // directly without changing Coore.
    try {
      await _dio.delete<void>(
        Endpoints.devicesToken,
        data: <String, dynamic>{'token': token},
      );
      return right(null);
    } on DioException catch (error, stackTrace) {
      return left(
        NetworkFailureMapper.toDomainFailure(
          _exceptionMapper.mapException(error, stackTrace),
        ),
      );
    } on Object catch (error, stackTrace) {
      return left(
        NetworkFailureMapper.toDomainFailure(
          NoInternetConnectionFailure(
            error.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  AppNotificationsPageEntity _pageFromJson(
    Map<String, dynamic> json, {
    required int fallbackPage,
    required int limit,
  }) {
    final data = _unwrapData(json);
    final itemsJson = data['data'];
    final meta = data['meta'] is Map
        ? Map<String, dynamic>.from(data['meta'] as Map)
        : <String, dynamic>{};
    final items = itemsJson is List
        ? itemsJson
              .whereType<Map>()
              .map((item) => _itemFromJson(Map<String, dynamic>.from(item)))
              .toList()
        : <AppNotificationEntity>[];
    return AppNotificationsPageEntity(
      notifications: items,
      page: (meta['page'] as num?)?.toInt() ?? fallbackPage,
      limit: (meta['limit'] as num?)?.toInt() ?? limit,
      total: (meta['total'] as num?)?.toInt() ?? items.length,
      totalPages: (meta['totalPages'] as num?)?.toInt() ?? 1,
    );
  }

  AppNotificationEntity _itemFromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final data = <String, String>{};
    if (rawData is Map) {
      rawData.forEach((key, value) {
        if (value != null) data['$key'] = '$value';
      });
    }
    final readAtRaw = json['readAt']?.toString();
    final createdAtRaw = json['createdAt']?.toString();
    final isRead =
        json['isRead'] == true || (readAtRaw != null && readAtRaw.isNotEmpty);
    return AppNotificationEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      notificationType: AppNotificationType.fromApi(
        json['notificationType']?.toString(),
      ),
      data: data,
      isRead: isRead,
      readAt: readAtRaw == null || readAtRaw.isEmpty
          ? null
          : DateTime.tryParse(readAtRaw),
      createdAt: DateTime.tryParse(createdAtRaw ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    return json;
  }
}
