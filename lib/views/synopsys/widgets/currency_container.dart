import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  bool _isSwitched = false;

  void _toggleSwitch() {
    setState(() {
      _isSwitched = !_isSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.95,
      height: size.height * 0.18,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildCurrencySection(!_isSwitched, 'USD', 'Dollar'),
              Spacer(),
              GestureDetector(
                onTap: _toggleSwitch,
                child: SvgPicture.asset('assets/icons/switch.svg'),
              ),
              Spacer(),
              _buildCurrencySection(_isSwitched, 'EUR', 'Euro'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _buildAmountSection(!_isSwitched, '\$1.00', 'USD'),
              Spacer(),
              _buildAmountSection(_isSwitched, '\$0.92', 'EUR'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySection(bool isLeft, String code, String name) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/${code.toLowerCase()}.svg'),
        SizedBox(
          width: 5,
        ),
        Column(
          children: [
            Text(
              code,
              style: HomeScreenTextStyle.titleName,
            ),
            Text(
              name,
              style: HomeScreenTextStyle.titleDate,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildAmountSection(bool isLeft, String amount, String code) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(color: AppColors.whiteColor),
        ),
        Text(
          code,
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
