import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';

part 'home_products_state.dart';

@injectable
class HomeProductsCubit extends Cubit<HomeProductsState> {
  HomeProductsCubit({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(const HomeProductsLoading());

  final ProductRepository _productRepository;

  Future<void> getProducts() async {
    emit(const HomeProductsLoading());

    final result = await _productRepository.getProducts();
    result.fold(
      (failure) => emit(HomeProductsFailed(failure)),
      (products) => emit(HomeProductsLoaded(products)),
    );
  }
}
