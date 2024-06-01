import 'package:flutter/material.dart';

import '../app_colors.dart';

class NewsTextStyle {
  static const TextStyle title = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
  static TextStyle preview = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 18 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor.withOpacity(0.5),
  );
  static const TextStyle business = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 18 / 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle date = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14.0,
    height: 18 / 12,
    fontWeight: FontWeight.w300,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static const TextStyle articleTitle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 24.0,
    height: 20 / 18,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
  static const TextStyle articleText = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 16.0,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  );
}
