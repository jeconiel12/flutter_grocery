import 'package:flutter/material.dart';

import 'package:flutter_grocery/theme/theme.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    required this.title,
    this.onTap,
    super.key,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.subtitle2,
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                'See All',
                style: AppTextStyles.body3,
              ),
            ),
        ],
      ),
    );
  }
}
