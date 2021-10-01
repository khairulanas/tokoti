part of 'product_form_bloc.dart';

@freezed
abstract class ProductFormEvent with _$ProductFormEvent {
  const factory ProductFormEvent.initialized(
      Option<Product> initProductOption) = _Initialized;
  const factory ProductFormEvent.nameChanged(String value) = _NameChanged;
  const factory ProductFormEvent.priceChanged(String value) = _PriceChanged;
  const factory ProductFormEvent.unitTypeChanged(String value) =
      _UnitTypeChanged;
  const factory ProductFormEvent.saved() = _Saved;
}





// @immutable
// abstract class ProductFormEvent {}

// class ProductFormEventSave extends ProductFormEvent {
//   final NewProduct newProduct;
//   ProductFormEventSave(this.newProduct);
// }
