import 'package:flutter/material.dart';

import 'package:flutter_grocery/core/core.dart';
import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/features/product_detail/product_detail.dart';
import 'package:flutter_grocery/theme/theme.dart';
import 'package:flutter_grocery/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ProductDetailPage.route(endpoint: product.detailEndpoint!),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 3),
              color: Colors.black12,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(product.imageUrl),
                  ),
                ),
                const SizedBox(height: 8.5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        (product.hasDiscount
                                ? product.discountPrice
                                : product.price)
                            .toIDR(),
                        style: AppTextStyles.subtitle3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (product.hasDiscount)
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                product.price.toIDR(),
                                style: AppTextStyles.body3.copyWith(
                                  color: AppColors.darkGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            ProductDiscountTag(
                              discountPercentage: product.discountPercentage,
                            )
                          ],
                        ),
                      Text(
                        product.name,
                        style: AppTextStyles.caption3,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.unit,
                        style: AppTextStyles.caption4.copyWith(
                          color: AppColors.darkGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Button height
                      const SizedBox(height: 44),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Add To Cart',
                        style: AppTextStyles.body3.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
