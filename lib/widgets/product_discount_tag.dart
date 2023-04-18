import 'package:flutter/material.dart';

import 'package:flutter_grocery/theme/theme.dart';

class ProductDiscountTag extends StatelessWidget {
  const ProductDiscountTag({
    required this.discountPercentage,
    this.style,
    super.key,
  });

  final int discountPercentage;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '-$discountPercentage%',
        style: (style ?? AppTextStyles.caption4).copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}
