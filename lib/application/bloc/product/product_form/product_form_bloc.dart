import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tokoti/domain/product/entities/product.dart';
import 'package:tokoti/domain/product/product_repository.dart';
import 'package:tokoti/utils/failure.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

part 'product_form_bloc.freezed.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  final ProductRepository productRepository;
  ProductFormBloc({required this.productRepository})
      : super(ProductFormState.initial()) {
    on<ProductFormEvent>(_onProductFormEvent);
  }

  Future<void> _onProductFormEvent(
      ProductFormEvent event, Emitter<ProductFormState> emit) {
    return event.map(
        initialized: (x) async => emit(x.initProductOption.fold(
            () => state, (a) => state.copyWith(product: a, isEditing: true))),
        nameChanged: (x) async => emit(
            state.copyWith(product: state.product.copyWith(name: x.value))),
        priceChanged: (x) async => emit(state.copyWith(
            product: state.product.copyWith(price: int.parse(x.value)))),
        unitTypeChanged: (x) async => emit(
            state.copyWith(product: state.product.copyWith(unitType: x.value))),
        saved: (_) async {
          emit(state.copyWith(isSaving: true));
          final now = DateTime.now();
          if (state.isEditing) {
            await productRepository
                .update(state.product.copyWith(updatedAt: now))
                .then((failureOrUpdatedProduct) {
              emit(state.copyWith(
                  saveFailureOrSuccessOption:
                      optionOf(failureOrUpdatedProduct)));
            });
          } else {
            await productRepository
                .create(state.product.copyWith(createdAt: now, updatedAt: now))
                .then((failureOrAddedProduct) {
              emit(state.copyWith(
                  saveFailureOrSuccessOption: optionOf(failureOrAddedProduct)));
            });
          }
        });
  }
}
