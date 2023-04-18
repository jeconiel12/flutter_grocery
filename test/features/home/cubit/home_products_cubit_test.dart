import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';
import 'package:flutter_grocery/features/home/home.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('HomeProductsCubit', () {
    late HomeProductsCubit homeCubit;
    late ProductRepository productRepository;

    setUp(() {
      productRepository = MockProductRepository();
      homeCubit = HomeProductsCubit(productRepository: productRepository);
    });

    group('getProducts', () {
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

      blocTest<HomeProductsCubit, HomeProductsState>(
        'calls [ProductRepository.getProducts] once',
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        build: () => homeCubit,
        act: (cubit) => cubit.getProducts(),
        verify: (_) {
          verify(() => productRepository.getProducts()).called(1);
        },
      );

      blocTest<HomeProductsCubit, HomeProductsState>(
        'emits [HomeProductsLoading] and [HomeProductsLoaded] '
        'when [getProducts] succeeds',
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(right(products))),
        build: () => homeCubit,
        act: (cubit) => cubit.getProducts(),
        expect: () => [
          const HomeProductsLoading(),
          const HomeProductsLoaded(products),
        ],
      );

      blocTest<HomeProductsCubit, HomeProductsState>(
        'emits [HomeProductsLoading] and [HomeProductsFailure] '
        'when [getProducts] fails',
        setUp: () => when(productRepository.getProducts)
            .thenAnswer((_) => Future.value(left(failure))),
        build: () => homeCubit,
        act: (cubit) => cubit.getProducts(),
        expect: () => [
          const HomeProductsLoading(),
          const HomeProductsFailed(failure),
        ],
      );
    });
  });
}
