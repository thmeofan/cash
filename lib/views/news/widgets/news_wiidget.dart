import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../consts/app_text_styles/news_text_style.dart';
import '../../../data/model/news_model.dart';
import '../../../util/app_routes.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.article, arguments: newsModel);
        },
        child: Container(
          height: screenSize.width * 0.3 + 4,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.01),
          decoration: BoxDecoration(
            //  borderRadius: BorderRadius.circular(15.0),
            border: Border(
              bottom: BorderSide(width: 0.2, color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsModel.title,
                          maxLines: 3,
                          style: NewsTextStyle.title,
                        ),
                        Spacer(),
                        Text(
                          newsModel.date,
                          // style: NewsTextStyle.date,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FancyShimmerImage(
                    width: screenSize.width * 0.3,
                    height: screenSize.width * 0.3,
                    boxFit: BoxFit.cover,
                    imageUrl: newsModel.imageUrl,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
