part of 'app_bloc.dart';

abstract class AppState {
  List<ErrorProductItem> listItem;
  int skip;
  bool hasMore;
  AppState({required this.listItem,required this.skip,required this.hasMore});
}

class AppInitial extends AppState {
  AppInitial({required super.listItem, required super.skip, required super.hasMore});
}

class AppLoadingState extends AppState {
  AppLoadingState({required super.listItem, required super.skip, required super.hasMore});
}

class AppLoadingMoreState extends AppState {
  AppLoadingMoreState({required super.listItem, required super.skip, required super.hasMore});
}

class AppError extends AppState {
  final String? message;

  AppError(this.message, {required super.listItem, required super.skip, required super.hasMore});

}

class AppSuccess extends AppState {
  final String? message;

  AppSuccess(this.message, {required super.listItem, required super.skip, required super.hasMore});

}