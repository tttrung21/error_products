part of 'app_bloc.dart';

sealed class AppEvent {}

class AppStartedEvent extends AppEvent {}

class UpdateItem extends AppEvent{
  ErrorProductItem item;
  UpdateItem({required this.item});
}

class LoadMore extends AppEvent{}