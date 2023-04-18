import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';

@lazySingleton
class ProductRepository {
  const ProductRepository({
    required ProductClient productClient,
  }) : _productClient = productClient;

  final ProductClient _productClient;

  RepoResult<List<ProductModel>> getProducts() async {
    try {
      final response = await _productClient.getProducts();
      return right(response.products);
    } on Exception catch (err) {
      return left(err.toFailure);
    }
  }

  RepoResult<ProductModel> getProductDetail(String endpoint) async {
    try {
      final response = await _productClient.getProductDetail(endpoint);
      return right(response.data);
    } on Exception catch (err) {
      return left(err.toFailure);
    }
  }
}
