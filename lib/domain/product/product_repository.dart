import 'package:dartz/dartz.dart';
import 'package:tokoti/domain/product/entities/product.dart';
import 'package:tokoti/utils/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> create(Product newProduct);
  Future<Either<Failure, Product>> update(Product editProduct);
  Future<Either<Failure, Unit>> delete(String productId);
  Future<Either<Failure, Product>> getById(String productId);
  Future<Either<Failure, List<Product>>> getAll();
}
