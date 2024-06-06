import 'package:flutter/material.dart';
import '../app_colors.dart';

class HomeScreenTextStyle {
  static const TextStyle bannerIncome = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static const TextStyle bannerSpendings = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static const TextStyle bannerTitle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static TextStyle incomeBannerTitle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static TextStyle bannerText = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static const TextStyle titleName = TextStyle(
      fontFamily: 'SF Pro Text',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor);
  static TextStyle titleDate = TextStyle(
      fontFamily: 'SF Pro Text',
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: AppColors.blackColor.withOpacity(0.4));
  static const TextStyle spending = TextStyle(
      fontFamily: 'SF Pro Text',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteColor);
}
