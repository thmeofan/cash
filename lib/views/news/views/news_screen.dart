import 'package:cash/consts/app_text_styles/settings_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/model/news_model.dart';
import '../widgets/news_wiidget.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.newsModel});

  final List<NewsModel> newsModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              'assets/icons/leading.svg',
            ),
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'News',
            style: SettingsTextStyle.title,
          ),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: newsModel.length,
              itemBuilder: (BuildContext context, int index) {
                return NewsWidget(newsModel: newsModel[index]);
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
        ]));
  }
}
