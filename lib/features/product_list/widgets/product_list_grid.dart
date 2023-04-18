import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter_grocery/features/product_list/product_list.dart';
import 'package:flutter_grocery/theme/theme.dart';
import 'package:flutter_grocery/widgets/widgets.dart';

class ProductListGrid extends StatefulWidget {
  const ProductListGrid({
    super.key,
    required this.state,
  });

  final ProductListLoaded state;

  @override
  State<ProductListGrid> createState() => _ProductListGridState();
}

class _ProductListGridState extends State<ProductListGrid> {
  late ScrollController _scrollController;

  void _loadMoreProducts() {
    /// Start loading next page when midway current page
    final scrollOffset = _scrollController.offset;
    final nextPageLoadOffset = _scrollController.position.maxScrollExtent / 2;

    if (scrollOffset >= nextPageLoadOffset) {
      final productListCubit = context.read<ProductListCubit>();
      final currentState = productListCubit.state as ProductListLoaded;

      if (!currentState.isEnd && !currentState.isLoading) {
        productListCubit.loadMore();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMoreProducts);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            AlignedGridView.custom(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: widget.state.products.length,
              itemBuilder: (_, index) {
                final product = widget.state.products[index];
                return ProductCard(product: product);
              },
            ),
            if (widget.state.isLoading) ...[
              const SizedBox(height: 16),
              const CircularProgressIndicator()
            ],
            if (widget.state.failure != null) ...[
              const SizedBox(height: 16),
              Text(
                widget.state.failure!.message,
                style: AppTextStyles.subtitle3,
              )
            ],
          ],
        ),
      ),
    );
  }
}
