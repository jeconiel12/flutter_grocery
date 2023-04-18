import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_grocery/di/di.dart';
import 'package:flutter_grocery/features/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeProductsCubit>()..getProducts(),
      child: const HomeView(),
    );
  }
}
