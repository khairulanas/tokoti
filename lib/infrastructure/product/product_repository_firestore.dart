import 'package:tokoti/domain/product/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:tokoti/domain/product/product_repository.dart';
import 'package:tokoti/infrastructure/core/firestore_helper.dart';
import 'package:tokoti/utils/failure.dart';

class ProductRepositoryFirestore implements ProductRepository {
  final _firestore = Firestore();

  @override
  Future<Either<Failure, Product>> create(Product product) async {
    try {
      final productDoc = await _firestore.producCol.add(product.toMap());
      return right(product.copyWith(id: productDoc.id));
    } catch (e) {
      return left(Failure(message: 'ProductRepositoryError: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAll() async {
    try {
      final res = await _firestore.producCol.get();
      final lisproduct =
          res.docs.map((doc) => Product.fromFirestore(doc)).toList();
      return right(lisproduct);
    } catch (e) {
      return left(Failure(message: 'ProductRepositoryError: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String productId) async {
    try {
      await _firestore.producCol.doc(productId).delete();
      return right(unit);
    } catch (e) {
      return left(Failure(message: 'ProductRepositoryError: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Product>> getById(String productId) async {
    try {
      final doc = await _firestore.producCol.doc(productId).get();
      return right(Product.fromFirestore(doc));
    } catch (e) {
      return left(Failure(message: 'ProductRepositoryError: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Product>> update(Product editProduct) async {
    try {
      await _firestore.producCol
          .doc(editProduct.id)
          .update(editProduct.toMap());
      return right(editProduct);
    } catch (e) {
      return left(Failure(message: 'ProductRepositoryError: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Failure, List<Product>>> watchAll() async* {
    try {
      yield* _firestore.producCol
          .orderBy('updatedAt', descending: true)
          .snapshots()
          .map(
            (snap) => right(
              snap.docs.map((doc) => Product.fromFirestore(doc)).toList(),
            ),
          );
    } catch (e) {
      yield left(Failure(message: 'ProductRepositoryError: ${e.toString()}'));
    }
  }
}
