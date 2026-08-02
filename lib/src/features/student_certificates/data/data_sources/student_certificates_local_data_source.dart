import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';

abstract interface class StudentCertificatesLocalDataSource {
  FutureEither<void> saveNewTransactionId(String transactionId);
  FutureEither<String?> readNewTransactionId();
  FutureEither<void> clearNewTransactionId();
  FutureEither<void> saveReexamTransactionId(
    String certificateId,
    String transactionId,
  );
  FutureEither<String?> readReexamTransactionId(String certificateId);
  FutureEither<void> clearReexamTransactionId();
}

@LazySingleton(as: StudentCertificatesLocalDataSource)
class StudentCertificatesLocalDataSourceImpl
    implements StudentCertificatesLocalDataSource {
  StudentCertificatesLocalDataSourceImpl(
    @Named(RawValues.authNamedInstance) this._database,
  );

  final LocalDatabaseInterface _database;

  @override
  FutureEither<void> saveNewTransactionId(String transactionId) =>
      _save(StorageKeys.studentCertificateNewTransactionId, transactionId);

  @override
  FutureEither<String?> readNewTransactionId() =>
      _readString(StorageKeys.studentCertificateNewTransactionId);

  @override
  FutureEither<void> clearNewTransactionId() =>
      _delete(StorageKeys.studentCertificateNewTransactionId);

  @override
  FutureEither<void> saveReexamTransactionId(
    String certificateId,
    String transactionId,
  ) => _save(StorageKeys.studentCertificateReexamTransaction, {
    'certificateId': certificateId,
    'transactionId': transactionId,
  });

  @override
  FutureEither<String?> readReexamTransactionId(String certificateId) async {
    final result = await _database.get<Map<dynamic, dynamic>>(
      StorageKeys.studentCertificateReexamTransaction,
    );
    return result.fold(left, (value) {
      if (value == null) return right(null);
      final data = Map<String, dynamic>.from(value);
      return right(
        data['certificateId']?.toString() == certificateId
            ? data['transactionId']?.toString()
            : null,
      );
    });
  }

  @override
  FutureEither<void> clearReexamTransactionId() =>
      _delete(StorageKeys.studentCertificateReexamTransaction);

  FutureEither<void> _save(String key, Object value) async {
    final result = await _database.save(key, value);
    return result.fold(left, (_) => right(null));
  }

  FutureEither<String?> _readString(String key) async {
    final result = await _database.get<Object>(key);
    return result.fold(left, (value) => right(value?.toString()));
  }

  FutureEither<void> _delete(String key) async {
    final result = await _database.delete(key);
    return result.fold(left, (_) => right(null));
  }
}
