import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';
import 'package:flutter_grocery/features/product_list/cubit/product_list_cubit.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductListCubit', () {
    late ProductListCubit productListCubit;
    late ProductListCubit productListCubitLimited;
    late ProductRepository productRepository;

    const failure = Failure('An error occurred. Please try again later.');
    const products = [
      ProductModel(
        id: 1,
        name: 'Product Name',
        imageUrl: 'image/url',
        price: '20000',
        discountPrice: '0',
        unit: '100 ML',
      ),
      ProductModel(
        id: 2,
        name: 'Product Name 2',
        imageUrl: 'image/url2',
        price: '30000',
        discountPrice: '0',
        unit: '100 ML',
      )
    ];

    setUp(() {
      productRepository = MockProductRepository();
      productListCubit = ProductListCubit(productRepository: productRepository);
      productListCubitLimited = ProductListCubit(
        lastPage: 1,
        productRepository: productRepository,
      );
    });

    group('getProducts', () {
      blocTest<ProductListCubit, ProductListState>(
        'calls [ProductRepository.getProducts] once',
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        build: () => productListCubit,
        act: (cubit) => cubit.getProducts(),
        verify: (_) {
          verify(() => productRepository.getProducts()).called(1);
        },
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits [ProductListLoading] and [ProductListLoaded] '
        'when [getProducts] succeeds',
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        build: () => productListCubit,
        act: (cubit) => cubit.getProducts(),
        expect: () => [
          const ProductListLoading(),
          const ProductListLoaded(products: products),
        ],
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits [ProductListLoading] and [ProductListFailure] '
        'when [getProducts] fails',
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(left(failure))),
        build: () => productListCubit,
        act: (cubit) => cubit.getProducts(),
        expect: () => [
          const ProductListLoading(),
          const ProductListFailed(failure),
        ],
      );
    });

    group('loadMore', () {
      const initialLoadedState = ProductListLoaded(
        products: products,
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits nothing when state is not [ProductListLoaded]',
        build: () => productListCubit,
        act: (cubit) => cubit.loadMore(),
        expect: () => <ProductListState>[],
        verify: (bloc) {
          verifyNever(() => productRepository.getProducts());
        },
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits nothing when [ProductListLoaded.isEnd] is true',
        build: () => productListCubit,
        seed: () => const ProductListLoaded(isEnd: true),
        act: (cubit) => cubit.loadMore(),
        expect: () => <ProductListState>[],
        verify: (bloc) {
          verifyNever(() => productRepository.getProducts());
        },
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits [ProductListLoaded] with loading '
        'and [ProductListLoaded] with new products added '
        'when [getProducts] succeeds',
        build: () => productListCubit,
        seed: () => initialLoadedState,
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        act: (cubit) => cubit.loadMore(),
        expect: () => [
          initialLoadedState.copyWith(isLoading: true),
          initialLoadedState.copyWith(
            products: [...products, ...products],
            isLoading: false,
          ),
        ],
        verify: (bloc) {
          verify(() => productRepository.getProducts()).called(1);
        },
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits [ProductListLoaded] with loading '
        'and [ProductListLoaded] with new products added '
        'and [ProductListCubit.page] value is increased by 1 '
        'when [getProducts] succeeds',
        build: () => productListCubit,
        seed: () {
          expect(productListCubit.page, 0);
          return initialLoadedState;
        },
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        act: (cubit) => cubit.loadMore(),
        expect: () {
          expect(productListCubit.page, 1);
          return [
            initialLoadedState.copyWith(isLoading: true),
            initialLoadedState.copyWith(
              products: [...products, ...products],
              isLoading: false,
            ),
          ];
        },
        verify: (bloc) {
          verify(() => productRepository.getProducts()).called(1);
        },
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits [ProductListLoaded] with loading '
        'and [ProductListLoaded] with new products added '
        'and isEnd true '
        'when [getProducts] succeeds '
        'and [ProductListCubit.page] hit the limit',
        build: () => productListCubitLimited,
        seed: () {
          expect(productListCubitLimited.page, 0);
          return initialLoadedState;
        },
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        act: (cubit) => cubit.loadMore(),
        expect: () {
          expect(
            productListCubitLimited.page,
            productListCubitLimited.lastPage,
          );
          return [
            initialLoadedState.copyWith(isLoading: true),
            initialLoadedState.copyWith(
              products: [...products, ...products],
              isEnd: true,
              isLoading: false,
            ),
          ];
        },
        verify: (bloc) {
          verify(() => productRepository.getProducts()).called(1);
        },
      );

      blocTest<ProductListCubit, ProductListState>(
        'emits [ProductListLoaded] with loading '
        'and [ProductListLoaded] failure '
        'when [getProducts] fails',
        build: () => productListCubit,
        seed: () => initialLoadedState,
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(left(failure))),
        act: (cubit) => cubit.loadMore(),
        expect: () => [
          initialLoadedState.copyWith(isLoading: true),
          initialLoadedState.copyWith(
            isLoading: false,
            failure: failure,
          ),
        ],
        verify: (bloc) {
          verify(() => productRepository.getProducts()).called(1);
        },
      );
    });
  });
}
