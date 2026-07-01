import 'package:coore/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppCoreCubit<S> extends Cubit<S> {
  AppCoreCubit(super.initialState);

  @override
  void emit(S state) {
    if (isClosed) return;
    super.emit(state);
  }
}

abstract class AppCoreCoreCubit<S, T> extends CoreCubit<S, T> {
  AppCoreCoreCubit(super.initialState);

  @override
  void emit(S state) {
    if (isClosed) return;
    super.emit(state);
  }
}

abstract class AppCorePaginationCubit<
  T extends Identifiable,
  M extends MetaModel
>
    extends CorePaginationCubit<T, M> {
  AppCorePaginationCubit({
    required super.paginationFunction,
    required super.paginationStrategy,
    super.reverse,
  });

  @override
  void emit(CorePaginationState<T, M> state) {
    if (isClosed) return;
    super.emit(state);
  }
}

extension AppCoreCubitGenerationGuard on Cubit<dynamic> {
  bool isActiveGeneration({
    required int capturedGeneration,
    required int currentGeneration,
  }) => !isClosed && capturedGeneration == currentGeneration;
}
