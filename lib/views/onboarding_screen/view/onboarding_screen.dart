import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/onboarding_cubit/onboarding_cubit.dart';
import '../../../consts/app_text_styles/onboarding_text_style.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../widgets/introduction_svg_widget.dart';

class OnboardingScreen extends StatefulWidget {
  final bool? isFirstTime;

  const OnboardingScreen({
    Key? key,
    this.isFirstTime,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController _carouselController = CarouselController();

  void _onActionButtonTap() {
    context.read<OnboardingCubit>().setFirstTime();
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: const [
                  IntroductionPNGWidget(
                    imagePath: 'assets/images/onboarding1.png',
                  ),
                ],
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: size.height * 0.6,
                  autoPlay: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  },
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  // color: AppColors.blackColor,
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              width: double.infinity,
              height: size.height * 0.38,
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Manage your finances easily and conveniently',
                            style: OnboardingTextStyle.introduction,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Flexible(
                        child: Text(
                          'A mobile app for planning and tracking your expenses.',
                          style: OnboardingTextStyle.description,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    const Spacer(),
                    ChosenActionButton(
                      onTap: _onActionButtonTap,
                      text: 'Get started',
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Terms of use',
                              style: OnboardingTextStyle.description,
                            )),
                        Text(
                          '/',
                          style: OnboardingTextStyle.description,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Privacy Policy',
                              style: OnboardingTextStyle.description,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
