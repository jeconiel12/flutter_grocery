import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';
import 'package:flutter_grocery/features/product_detail/product_detail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductDetailCubit', () {
    late ProductDetailCubit productDetailCubit;
    late ProductRepository productRepository;

    const endpoint = 'https://run.mocky.io/v3/1';

    setUp(() {
      productRepository = MockProductRepository();
      productDetailCubit = ProductDetailCubit(
        endpoint: endpoint,
        productRepository: productRepository,
      );
    });

    group('getProductDetail', () {
      const failure = Failure('An error occurred. Please try again later.');
      const product = ProductModel(
        id: 1,
        name: 'Product Name',
        imageUrl: 'image/url',
        price: '20000',
        discountPrice: '0',
        unit: '100 ML',
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'calls [ProductRepository.getProductDetail] once',
        setUp: () => when(() => productRepository.getProductDetail(any()))
            .thenAnswer((_) => Future.value(right(product))),
        build: () => productDetailCubit,
        act: (cubit) => cubit.getProductDetail(),
        verify: (_) {
          verify(() => productRepository.getProductDetail(endpoint)).called(1);
        },
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'emits [ProductDetailLoading] and [ProductDetailLoaded] '
        'when [getProductDetail] succeeds',
        setUp: () => when(() => productRepository.getProductDetail(any()))
            .thenAnswer((_) => Future.value(right(product))),
        build: () => productDetailCubit,
        act: (cubit) => cubit.getProductDetail(),
        expect: () => [
          const ProductDetailLoading(),
          const ProductDetailLoaded(product),
        ],
      );

      blocTest<ProductDetailCubit, ProductDetailState>(
        'emits [ProductDetailLoading] and [ProductDetailFailed] '
        'when [getProductDetail] fails',
        setUp: () => when(() => productRepository.getProductDetail(any()))
            .thenAnswer((_) => Future.value(left(failure))),
        build: () => productDetailCubit,
        act: (cubit) => cubit.getProductDetail(),
        expect: () => [
          const ProductDetailLoading(),
          const ProductDetailFailed(failure),
        ],
      );
    });
  });
}
