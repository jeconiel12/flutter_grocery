import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_grocery/features/product_list/product_list.dart';
import 'package:flutter_grocery/theme/theme.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: AppTextStyles.subtitle2,
        ),
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoaded) {
            return ProductListGrid(state: state);
          }

          if (state is ProductListFailed) {
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
