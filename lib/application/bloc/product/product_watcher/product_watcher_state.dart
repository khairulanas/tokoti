part of 'product_watcher_bloc.dart';

@freezed
abstract class ProductWatcherState with _$ProductWatcherState {
  const factory ProductWatcherState.initial() = Initial;
  const factory ProductWatcherState.loadInProgress() = DataTransferInProgress;
  const factory ProductWatcherState.loadSuccess(List<Product> notes) =
      LoadSuccess;
  const factory ProductWatcherState.loadFailure(Failure failure) = LoadFailure;
}
