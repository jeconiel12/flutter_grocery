import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_grocery/data/data.dart';

void main() {
  group('ProductExtension', () {
    const product = ProductModel(
      id: 1,
      name: 'Product Name',
      imageUrl: 'image/url',
      price: '20000',
      discountPrice: '0',
      unit: '100 ML',
    );

    const discountedProduct = ProductModel(
      id: 1,
      name: 'Product Name',
      imageUrl: 'image/url',
      price: '20000',
      discountPrice: '10000',
      unit: '100 ML',
    );

    group('discountPercentage', () {
      test('returns correct discount percentage for a discounted product', () {
        expect(discountedProduct.discountPercentage, 50);
      });

      test('returns 0 discount percentage for a non-discounted product', () {
        expect(product.discountPercentage, 0);
      });
    });

    group('hasDiscount', () {
      test('returns true for a discounted product', () {
        expect(discountedProduct.hasDiscount, true);
      });

      test('returns false for a non-discounted product', () {
        expect(product.hasDiscount, false);
      });
    });
  });
}
