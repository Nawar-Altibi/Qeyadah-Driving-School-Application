import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/data/mappers/sample_item_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/data/models/sample_item_model.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/repositories/sample_items_repository.dart';

abstract interface class SampleItemsRemoteDataSource {
  RemoteResponse<List<SampleItemModel>> fetchItems(
    LoadSampleItemsParams params,
  );

  RemoteResponse<SampleItemModel> fetchItem(GetSampleItemParams params);
}

@LazySingleton(as: SampleItemsRemoteDataSource)
class SampleItemsRemoteDataSourceImpl implements SampleItemsRemoteDataSource {
  SampleItemsRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<List<SampleItemModel>> fetchItems(
    LoadSampleItemsParams params,
  ) async {
    // JSONPlaceholder returns a top-level JSON array; Coore ApiHandler expects a Map.
    // Template demo uses embedded data — replace with your API `{ "data": [...] }` envelope.
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return right(_demoItems);
  }

  static const List<SampleItemModel> _demoItems = [
    SampleItemModel(
      id: '1',
      title: 'Architecture overview',
      body: 'Clean architecture with Coore.',
      userId: 1,
    ),
    SampleItemModel(
      id: '2',
      title: 'Feature-first modules',
      body: 'Each feature owns data/domain/presentation.',
      userId: 1,
    ),
    SampleItemModel(
      id: '3',
      title: 'Checkout-style flows',
      body: 'Coordinators, effects, and navigation facades.',
      userId: 2,
    ),
  ];

  @override
  RemoteResponse<SampleItemModel> fetchItem(GetSampleItemParams params) async {
    final response = await _apiHandler.get(
      Endpoints.sampleItemById(params.id),
      cancelRequestAdapter: params.cancelRequestAdapter,
    );

    return response.fold(left, (data) {
      try {
        final map = Map<String, dynamic>.from(
          (data['data'] as Map<dynamic, dynamic>?) ?? data,
        );
        return right(SampleItemModel.fromJson(map));
      } on Exception {
        return left(
          const InternalServerErrorFailure('Failed to parse item response'),
        );
      }
    });
  }
}

@LazySingleton(as: SampleItemsRepository)
class SampleItemsRepositoryImpl implements SampleItemsRepository {
  SampleItemsRepositoryImpl(this._remoteDataSource);

  final SampleItemsRemoteDataSource _remoteDataSource;

  @override
  FutureEither<List<SampleItemEntity>> loadItems(
    LoadSampleItemsParams params,
  ) async {
    final response = await _remoteDataSource.fetchItems(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (models) => right(models.map(sampleItemModelToEntity).toList()),
    );
  }

  @override
  FutureEither<SampleItemEntity> getItem(GetSampleItemParams params) async {
    final response = await _remoteDataSource.fetchItem(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (model) => right(sampleItemModelToEntity(model)),
    );
  }
}
