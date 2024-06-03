import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';

class OptionsWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Function() onTap;
  const OptionsWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.17,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),
            SvgPicture.asset(icon),
            const Spacer(),
            Text(
              title,
              style: HomeScreenTextStyle.titleName,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: HomeScreenTextStyle.titleDate,
            )
          ],
        ),
      ),
    );
  }
}
