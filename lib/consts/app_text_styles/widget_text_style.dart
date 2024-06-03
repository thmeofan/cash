import 'package:flutter/material.dart';
import '../app_colors.dart';

class WidgetTextStyle {
  static const TextStyle title = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle cost = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.w200,
    color: AppColors.blackColor.withOpacity(0.4),
  );

  static TextStyle subtitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static const TextStyle appBar = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.greenColor);

  static const TextStyle lable = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
