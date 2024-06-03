import 'package:flutter/material.dart';
import '../app_colors.dart';

class HomeScreenTextStyle {
  static const TextStyle bannerIncome = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static const TextStyle bannerSpendings = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static const TextStyle bannerTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static TextStyle incomeBannerTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static TextStyle bannerText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static const TextStyle name = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Colors.white);
  static const TextStyle titleName = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor);
  static TextStyle titleDate = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: AppColors.blackColor.withOpacity(0.4));
  static const TextStyle typeBad = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: AppColors.redColor);
  static const TextStyle income = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: AppColors.greenColor);
  static const TextStyle spending = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteColor);
  static TextStyle emptyTitle = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: AppColors.purpleColor,
  );
  static TextStyle emptySubtitle = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w200,
    color: Colors.grey,
  );
}
