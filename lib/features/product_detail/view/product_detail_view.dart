import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_grocery/features/product_detail/product_detail.dart';
import 'package:flutter_grocery/theme/theme.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            return ProductDetailLoadedView(product: state.product);
          }

          if (state is ProductDetailFailed) {
            return Center(
              child: Text(
                state.failure.message,
                style: AppTextStyles.subtitle2,
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
