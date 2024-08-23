import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:error_products/Home/Model/ErrorProductItem.dart';

import '../../Repository/Repository.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Repository repository;

  AppBloc(this.repository) : super(AppInitial(listItem: [], skip: 0,hasMore: true)) {
    on<AppStartedEvent>(_onStarted);
    on<UpdateItem>(_onUpdate);
    on<LoadMore>(_onLoadMore);
  }

  Future<void> _onStarted(AppStartedEvent event, Emitter<AppState> emit) async {
    emit(AppLoadingState(listItem: [], skip: 0, hasMore: true));
    final list = await repository.fetchData(0);

    final hasMore = list.length == 10;

    state.listItem = list;
    emit(AppSuccess('', listItem: state.listItem, skip: state.skip, hasMore: hasMore));
  }

  Future<void> _onLoadMore(LoadMore event, Emitter<AppState> emit) async {
    if (!state.hasMore || state is AppLoadingMoreState) return;

    emit(AppLoadingMoreState(listItem: state.listItem, skip: state.skip, hasMore: state.hasMore));

    final skip = state.skip + 10;
    final moreList = await repository.fetchData(skip);

    final hasMore = moreList.length == 10;

    state.listItem.addAll(moreList);

    emit(AppSuccess('', listItem: state.listItem, skip: skip, hasMore: hasMore));
  }

  void _onUpdate(UpdateItem event, Emitter<AppState> emit) {
    emit(AppLoadingState(listItem: state.listItem, skip: state.skip, hasMore: state.hasMore));
    try {
      final existingProductIndex = state.listItem.indexWhere((product) => product.id == event.item.id);

      List<ErrorProductItem> updatedList;

      updatedList = List.from(state.listItem);

      final updatedProduct = updatedList[existingProductIndex].copyWith(
          name: event.item.name, colorName: event.item.colorName, color: event.item.color, sku: event.item.sku);

      updatedList[existingProductIndex] = updatedProduct;

      state.listItem = updatedList;
      emit(AppSuccess('Success', listItem: updatedList, skip: state.skip, hasMore: state.hasMore));
    } catch (e) {
      emit(AppError('There\'s an error', listItem: state.listItem, skip: state.skip, hasMore: state.hasMore));
    }
  }
}
