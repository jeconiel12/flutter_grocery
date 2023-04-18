import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_grocery/di/injection/injection.dart';
import 'package:flutter_grocery/features/product_list/product_list.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ProductListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductListCubit>()..getProducts(),
      child: const ProductListView(),
    );
  }
}
