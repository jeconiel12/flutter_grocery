import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_grocery/theme/theme.dart';

abstract class AppTextStyles {
  static final _baseStyle = GoogleFonts.montserrat().copyWith(
    color: AppColors.black,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static final title1 = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static final title2 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.6,
  );

  static final subtitle1 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final subtitle2 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final subtitle3 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.6,
  );

  static final body1 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static final body2 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );

  static final body3 = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.7,
  );

  static final caption1 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static final caption2 = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final caption3 = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );

  static final caption4 = _baseStyle.copyWith(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );
}
