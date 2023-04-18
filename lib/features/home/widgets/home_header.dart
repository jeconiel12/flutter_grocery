import 'package:flutter/material.dart';

import 'package:flutter_grocery/features/home/home.dart';
import 'package:flutter_grocery/theme/theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Good Morning, Mate',
            style: AppTextStyles.body3.copyWith(color: AppColors.white),
          ),
          Text(
            "Let's order fresh items for you",
            style: AppTextStyles.title2.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 16),
          const SearchButton(),
        ],
      ),
    );
  }
}
