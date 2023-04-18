import 'package:flutter/material.dart';

import 'package:flutter_grocery/core/core.dart';
import 'package:flutter_grocery/data/data.dart';
import 'package:flutter_grocery/theme/theme.dart';
import 'package:flutter_grocery/widgets/widgets.dart';

class ProductDetailLoadedView extends StatelessWidget {
  const ProductDetailLoadedView({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Image.network(product.imageUrl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProductDetailSubHeader(product: product),
                  const Divider(
                    thickness: 8,
                    height: 8,
                    color: AppColors.lightGrey,
                  ),
                  _ProductDetailDescription(product: product),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  offset: Offset(0, -2),
                  color: Colors.black12,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
              ),
              child: Text(
                'Add To Cart',
                style: AppTextStyles.subtitle3.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductDetailDescription extends StatelessWidget {
  const _ProductDetailDescription({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Description',
            style: AppTextStyles.subtitle3,
          ),
          const SizedBox(height: 8),
          Text(
            product.description!,
            style: AppTextStyles.body3.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailSubHeader extends StatelessWidget {
  const _ProductDetailSubHeader({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, -2),
            color: Colors.black12,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            product.name,
            style: AppTextStyles.body2,
          ),
          Text(
            product.unit,
            style: AppTextStyles.caption3.copyWith(
              color: AppColors.darkGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            (product.hasDiscount ? product.discountPrice : product.price)
                .toIDR(),
            style: AppTextStyles.subtitle2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (product.hasDiscount)
            Row(
              children: [
                Flexible(
                  child: Text(
                    product.price.toIDR(),
                    style: AppTextStyles.body2.copyWith(
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
                  style: AppTextStyles.caption3,
                )
              ],
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
