import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tokoti/domain/product/entities/product.dart';
import 'package:tokoti/domain/product/product_repository.dart';
import 'package:tokoti/utils/failure.dart';

part 'product_watcher_event.dart';
part 'product_watcher_state.dart';

part 'product_watcher_bloc.freezed.dart';

class ProductWatcherBloc
    extends Bloc<ProductWatcherEvent, ProductWatcherState> {
  final ProductRepository _productRepository;

  ProductWatcherBloc(this._productRepository)
      : super(const ProductWatcherState.initial()) {
    on<ProductWatcherEvent>(_onEvent);
  }

  Future<void> _onEvent(
      ProductWatcherEvent event, Emitter<ProductWatcherState> emit) {
    return event.map(
      watchAllStarted: (_) async {
        emit(const ProductWatcherState.loadInProgress());
        emit.onEach<Either<Failure, List<Product>>>(
          _productRepository.watchAll(),
          onData: (failureOrProducts) =>
              add(ProductWatcherEvent.productRecieved(failureOrProducts)),
        );
      },
      productRecieved: (x) async {
        x.failureOrProducts.fold(
          (l) => emit(ProductWatcherState.loadFailure(l)),
          (r) => emit(ProductWatcherState.loadSuccess(r)),
        );
      },
    );
  }
}
