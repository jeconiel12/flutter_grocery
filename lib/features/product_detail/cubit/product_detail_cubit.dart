import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';

part 'product_detail_state.dart';

@injectable
class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    @factoryParam required String endpoint,
    required ProductRepository productRepository,
  })  : _endpoint = endpoint,
        _productRepository = productRepository,
        super(const ProductDetailLoading());

  final String _endpoint;
  final ProductRepository _productRepository;

  Future<void> getProductDetail() async {
    emit(const ProductDetailLoading());

    final result = await _productRepository.getProductDetail(_endpoint);
    result.fold(
      (failure) => emit(ProductDetailFailed(failure)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}
