import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_type.dart';

/// Cached instructor profile snapshot with an absolute expiry timestamp.
class CachedInstructorProfile {
  const CachedInstructorProfile({
    required this.profile,
    required this.cachedAt,
    required this.expiresAt,
  });

  final InstructorProfileEntity profile;
  final DateTime cachedAt;
  final DateTime expiresAt;

  bool get isFresh => DateTime.now().isBefore(expiresAt);
}

abstract interface class InstructorLocalDataSource {
  FutureEither<void> saveProfile(InstructorProfileEntity profile);
  FutureEither<CachedInstructorProfile?> readProfile();
  FutureEither<void> clearProfile();
}

@LazySingleton(as: InstructorLocalDataSource)
class InstructorLocalDataSourceImpl implements InstructorLocalDataSource {
  InstructorLocalDataSourceImpl(
    @Named(RawValues.authNamedInstance) this._database,
  );

  /// Profile fields change rarely; keep a 30-minute fresh window.
  static const Duration cacheTtl = Duration(minutes: 30);

  final LocalDatabaseInterface _database;

  @override
  FutureEither<void> saveProfile(InstructorProfileEntity profile) async {
    try {
      final now = DateTime.now();
      final payload = <String, dynamic>{
        'cachedAt': now.toIso8601String(),
        'expiresAt': now.add(cacheTtl).toIso8601String(),
        'profile': _profileToJson(profile),
      };
      final result = await _database.save(
        StorageKeys.instructorProfileCache,
        payload,
      );
      return result.fold(left, (_) => right(null));
    } on Exception catch (_, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<CachedInstructorProfile?> readProfile() async {
    try {
      final result = await _database.get<Map<dynamic, dynamic>>(
        StorageKeys.instructorProfileCache,
      );
      return result.fold(left, (value) {
        if (value == null) return right(null);
        final map = Map<String, dynamic>.from(value);
        final profileJson = map['profile'];
        if (profileJson is! Map) return right(null);
        final cachedAt = DateTime.tryParse(map['cachedAt']?.toString() ?? '');
        final expiresAt = DateTime.tryParse(map['expiresAt']?.toString() ?? '');
        if (cachedAt == null || expiresAt == null) return right(null);
        return right(
          CachedInstructorProfile(
            profile: _profileFromJson(Map<String, dynamic>.from(profileJson)),
            cachedAt: cachedAt,
            expiresAt: expiresAt,
          ),
        );
      });
    } on Exception catch (_, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<void> clearProfile() async {
    final result = await _database.delete(StorageKeys.instructorProfileCache);
    return result.fold(left, (_) => right(null));
  }

  Map<String, dynamic> _profileToJson(InstructorProfileEntity profile) {
    return {
      'instructorId': profile.instructorId,
      'userId': profile.userId,
      'name': profile.name,
      'gender': profile.gender,
      'instructorType': switch (profile.instructorType) {
        InstructorType.manual => 'MANUAL',
        InstructorType.automatic => 'AUTOMATIC',
      },
      'accountStatus': profile.accountStatus,
      'sessionWage': profile.sessionWage,
      'todayLessonsCount': profile.todayLessonsCount,
      'leaveStatus': profile.leaveStatus,
    };
  }

  InstructorProfileEntity _profileFromJson(Map<String, dynamic> json) {
    final instructorType = InstructorType.fromApi(
      json['instructorType']?.toString(),
    );
    if (instructorType == null) {
      throw const FormatException('Unknown instructor type in cache');
    }
    return InstructorProfileEntity(
      instructorId: (json['instructorId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      instructorType: instructorType,
      accountStatus: json['accountStatus']?.toString() ?? '',
      sessionWage: (json['sessionWage'] as num?)?.toInt() ?? 0,
      todayLessonsCount: (json['todayLessonsCount'] as num?)?.toInt() ?? 0,
      leaveStatus: json['leaveStatus']?.toString(),
    );
  }
}
