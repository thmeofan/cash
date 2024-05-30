import 'package:cash/consts/app_text_styles/settings_text_style.dart';
import 'package:flutter/material.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/onboarding_text_style.dart';

import '../../../data/model/news_model.dart';
import '../widgets/news_wiidget.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.newsModel});

  final List<NewsModel> newsModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Hockey news',
            style: SettingsTextStyle.title,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: AppColors.blackColor),
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: newsModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsWidget(newsModel: newsModel[index]);
                },
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
          ]),
        ));
  }
}
