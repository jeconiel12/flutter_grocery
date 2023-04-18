import 'package:flutter/material.dart';

import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/widgets/widgets.dart';

class HomeProductList extends StatelessWidget {
  const HomeProductList({
    required this.products,
    super.key,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.35 * (279 / 136.5),
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: ProductCard(product: product),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
      ),
    );
  }
}
