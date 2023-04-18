import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:flutter_grocery/data/data.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Product Client', () {
    late http.Client client;
    late ProductClient productClient;

    setUp(() {
      client = MockHttpClient();
      productClient = ProductClient(client: client);
    });

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    group('getProducts', () {
      final uri = Uri.parse('${ProductClient.baseUrl}/products');

      const expectedResponse = GetProductsResponse(products: []);

      setUp(() {
        when(() => client.get(any())).thenAnswer(
          (_) => Future.value(
            http.Response(
              jsonEncode(expectedResponse),
              HttpStatus.ok,
            ),
          ),
        );
      });

      test('calls [http.get] method once', () {
        productClient.getProducts();

        verify(() => client.get(uri)).called(1);
      });

      test('returns [GetProductsResponse] when response succeeds', () {
        final response = productClient.getProducts();

        expect(response, completion(equals(expectedResponse)));
      });

      test('throws an [Exception] when response fails', () {
        when(() => client.get(any())).thenAnswer(
          (_) => Future.value(
            http.Response(
              jsonEncode(expectedResponse),
              HttpStatus.badRequest,
            ),
          ),
        );

        final response = productClient.getProducts();
        expect(response, throwsA(isA<Exception>()));
      });
    });

    group('getProductDetail', () {
      const endpoint = 'https://run.mocky.io/v3/1';
      final uri = Uri.parse(endpoint);

      const expectedResponse = GetProductDetailResponse(
        data: ProductModel(
          id: 1,
          name: 'Product Name',
          imageUrl: 'image/url',
          price: '20000',
          discountPrice: '0',
          unit: '100 ML',
        ),
      );

      setUp(() {
        when(() => client.get(any())).thenAnswer(
          (_) => Future.value(
            http.Response(
              jsonEncode(expectedResponse),
              HttpStatus.ok,
            ),
          ),
        );
      });

      test('calls [http.get] method once', () {
        productClient.getProductDetail(endpoint);

        verify(() => client.get(uri)).called(1);
      });

      test('returns [GetProductDetailResponse] when response succeeds', () {
        final response = productClient.getProductDetail(endpoint);

        expect(response, completion(equals(expectedResponse)));
      });

      test('throws an [Exception] when response fails', () {
        when(() => client.get(any())).thenAnswer(
          (_) => Future.value(
            http.Response(
              jsonEncode(expectedResponse),
              HttpStatus.badRequest,
            ),
          ),
        );

        final response = productClient.getProductDetail(endpoint);

        expect(response, throwsA(isA<Exception>()));
      });
    });
  });
}
