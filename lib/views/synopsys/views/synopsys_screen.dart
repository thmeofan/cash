import 'package:cash/views/settings/views/settings_screen.dart';
import 'package:cash/views/synopsys/widgets/options_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/news_model.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../news/views/news_screen.dart';
import '../../operation/views/constructor_screen.dart';
import '../../operation/views/finance_screen.dart';
import '../../statistics_screen/views/statistics_screen.dart';

class SynopsysScreen extends StatefulWidget {
  @override
  _SynopsysScreenState createState() => _SynopsysScreenState();
}

class _SynopsysScreenState extends State<SynopsysScreen> {
  List<Map<String, dynamic>> operations = [];

  @override
  void initState() {
    super.initState();
    _loadOperations();
  }

  void _loadOperations() async {
    operations = await SharedPreferencesService.loadOperations();
    setState(() {});
  }

  void _addOperation(Map<String, dynamic> operation) async {
    setState(() {
      operations.add(operation);
    });
    await SharedPreferencesService.saveOperations(operations);
  }

  double get _totalIncome {
    return operations
        .where((op) => op['type'] == 'Income')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double get _totalSpendings {
    return operations
        .where((op) => op['type'] == 'Spendings')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double _totalAmount() {
    double totalIncome = _totalIncome;
    double totalSpendings = _totalSpendings;

    return totalIncome - totalSpendings;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: SvgPicture.asset('assets/icons/settings.svg')),
          // TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => HistoryScreen(
          //                   operations: operations,
          //                 )),
          //       );
          //     },
          //     child: Text('History'))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Balance',
                                  style: HomeScreenTextStyle.incomeBannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '\$${_totalAmount().toString()}',
                            style: HomeScreenTextStyle.bannerIncome,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //  width: size.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Income',
                                  style: HomeScreenTextStyle.incomeBannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Text(
                                  '\$$_totalIncome ',
                                  style: HomeScreenTextStyle.bannerIncome,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 6,
                      endIndent: 8,
                      height: 1.0,
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    Container(
                      //   width: size.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Expense',
                                  style: HomeScreenTextStyle.incomeBannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Text(
                                  '\$$_totalSpendings ',
                                  style: HomeScreenTextStyle.bannerSpendings,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 6,
                      endIndent: 8,
                      height: 1.0,
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    ChosenActionButton(
                      text: 'Refill balance',
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConstructorScreen()),
                        );
                        if (result != null) {
                          _addOperation(result);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionsWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsScreen(
                                  newsModel: news,
                                )),
                      );
                    },
                    icon: 'assets/icons/news.svg',
                    title: 'News',
                    subtitle: '6 news'),
                SizedBox(width: 10),
                OptionsWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StatisticScreen()),
                      );
                    },
                    icon: 'assets/icons/statistics.svg',
                    title: 'Statistics',
                    subtitle: 'Statistics of your current income and expense.'),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
