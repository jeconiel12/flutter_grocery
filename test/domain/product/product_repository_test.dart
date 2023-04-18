import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/domain/domain.dart';

class MockProductClient extends Mock implements ProductClient {}

void main() {
  group('Product Repository', () {
    late ProductRepository productRepository;
    late ProductClient productClient;

    setUp(() {
      productClient = MockProductClient();
      productRepository = ProductRepository(productClient: productClient);
    });

    group('getProducts', () {
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

      const expectedResponse = GetProductsResponse(products: products);

      setUp(() {
        when(productClient.getProducts)
            .thenAnswer((_) => Future.value(expectedResponse));
      });

      test('calls [ProductClient.getProducts] once', () {
        productRepository.getProducts();

        verify(() => productClient.getProducts()).called(1);
      });

      test(
          'returns list of [ProductModel] when [getProducts] '
          'returns [GetProductsResponse]', () {
        final response = productRepository.getProducts();

        expect(
          response,
          completion(equals(right<Failure, List<ProductModel>>(products))),
        );
      });

      test(
          'returns [Failure] when [getProducts] '
          'throws an [Exception]', () {
        final exception = Exception('Unknown error');

        when(productClient.getProducts).thenThrow(exception);

        final response = productRepository.getProducts();

        expect(
          response,
          completion(
            equals(left<Failure, List<ProductModel>>(exception.toFailure)),
          ),
        );
      });
    });

    group('getProductDetail', () {
      const endpoint = 'https://run.mocky.io/v3/1';
      const product = ProductModel(
        id: 1,
        name: 'Product Name',
        imageUrl: 'image/url',
        price: '20000',
        discountPrice: '0',
        unit: '100 ML',
      );

      const expectedResponse = GetProductDetailResponse(data: product);

      setUp(() {
        when(() => productClient.getProductDetail(any())).thenAnswer(
          (_) => Future.value(expectedResponse),
        );
      });

      test('calls [ProductClient.getProductDetail] once', () {
        productRepository.getProductDetail(endpoint);

        verify(() => productClient.getProductDetail(endpoint)).called(1);
      });

      test(
          'returns [ProductModel] when [getProductDetail] '
          'returns [GetProductsResponse]', () {
        final response = productRepository.getProductDetail(endpoint);

        expect(
          response,
          completion(equals(right<Failure, ProductModel>(product))),
        );
      });

      test(
          'returns [Failure] when [getProductDetail] '
          'throws an [Exception]', () {
        final exception = Exception('Unknown error');

        when(() => productClient.getProductDetail(any())).thenThrow(exception);

        final response = productRepository.getProductDetail(endpoint);

        expect(
          response,
          completion(
            equals(left<Failure, ProductModel>(exception.toFailure)),
          ),
        );
      });
    });
  });
}
