import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_grocery/di/injection/injection.dart';
import 'package:flutter_grocery/features/product_detail/product_detail.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    required this.endpoint,
    super.key,
  });

  final String endpoint;

  static Route<void> route({required String endpoint}) {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailPage(endpoint: endpoint),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ProductDetailCubit>(param1: endpoint)..getProductDetail(),
      child: const ProductDetailView(),
    );
  }
}
