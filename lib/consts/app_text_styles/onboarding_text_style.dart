import 'package:flutter/material.dart';

class OnboardingTextStyle {
  static const TextStyle introduction = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 30.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static TextStyle description = TextStyle(
      fontFamily: 'SF Pro Text',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.black.withOpacity(0.4));

  static const TextStyle button = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 17.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
