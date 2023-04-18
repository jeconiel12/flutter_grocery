import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';

part 'product_list_state.dart';

@injectable
class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit({
    @factoryParam int? lastPage,
    required ProductRepository productRepository,
  })  : _lastPage = lastPage ?? 3,
        _productRepository = productRepository,
        super(const ProductListLoading());

  final ProductRepository _productRepository;

  /// Mock number of page to simulates the pagination.
  final int _lastPage;

  int _page = 0;

  @visibleForTesting
  int get page => _page;

  @visibleForTesting
  int get lastPage => _lastPage;

  Future<void> getProducts() async {
    emit(const ProductListLoading());

    final result = await _productRepository.getProducts();
    result.fold(
      (failure) => emit(ProductListFailed(failure)),
      (products) {
        _page++;
        emit(
          ProductListLoaded(
            products: products,
            isEnd: _page >= _lastPage,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state is! ProductListLoaded || (state as ProductListLoaded).isEnd) {
      return;
    }

    final currentState = state as ProductListLoaded;

    emit(currentState.copyWith(isLoading: true));

    final result = await _productRepository.getProducts();

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          failure: failure,
          isLoading: false,
        ),
      ),
      (products) {
        _page++;
        emit(
          currentState.copyWith(
            products: [...currentState.products, ...products],
            isEnd: _page >= _lastPage,
            isLoading: false,
          ),
        );
      },
    );
  }
}
