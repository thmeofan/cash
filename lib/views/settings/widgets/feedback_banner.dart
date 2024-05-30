import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';

class FeedbackBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Give us 5 stars',
                    style: HomeScreenTextStyle.bannerTitle,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Your feedback helps \nus improve',
                    style: HomeScreenTextStyle.bannerText,
                    maxLines: 4,
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/images/feedback.svg',
                fit: BoxFit.cover,
                width: 130,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
