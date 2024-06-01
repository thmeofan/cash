import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPNGWidget extends StatelessWidget {
  final String imagePath;

  const IntroductionPNGWidget({
    key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.4,
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ));
  }
}
