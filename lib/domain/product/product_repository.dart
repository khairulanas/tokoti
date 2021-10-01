import 'package:dartz/dartz.dart';
import 'package:tokoti/domain/product/entities/product.dart';
import 'package:tokoti/utils/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> create(Product newProduct);
  Future<String?> update(Product newProduct) async {}
  Future<String?> delete(Product newProduct) async {}
  Future<Product?> getById(String id) async {}
  Future<Either<Failure, List<Product>>> getAll();
  Future<List<Product>?> searchByname() async {}
}
