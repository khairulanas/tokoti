part of 'product_form_bloc.dart';

@freezed
abstract class ProductFormState with _$ProductFormState {
  const factory ProductFormState({
    required Product product,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<Failure, Product>> saveFailureOrSuccessOption,
  }) = _ProductFormState;

  factory ProductFormState.initial() => ProductFormState(
      product: Product.empty(),
      isEditing: false,
      isSaving: false,
      saveFailureOrSuccessOption: none(),
      showErrorMessages: false);
}








// @immutable
// abstract class ProductFormState {}

// class ProductFormInitial extends ProductFormState {
//   final NewProduct newProduct = NewProduct.empty();
// }

// class ProductFormSaving extends ProductFormState {
//   final NewProduct newProduct;
//   ProductFormSaving(this.newProduct);
// }

// class ProductFormSaved extends ProductFormState {
//   final AddedProduct addProduct;
//   ProductFormSaved(this.addProduct);
// }

// class ProductFormError extends ProductFormState {
//   final String message;
//   ProductFormError(this.message);
// }
