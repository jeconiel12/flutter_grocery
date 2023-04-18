import 'package:flutter/material.dart';

import 'package:flutter_grocery/theme/theme.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Go to Search Page
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.white,
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColors.baseGrey,
          ),
          const SizedBox(width: 8),
          Text(
            'Search Product',
            style: AppTextStyles.body3.copyWith(
              color: AppColors.baseGrey,
            ),
          ),
        ],
      ),
    );
  }
}
