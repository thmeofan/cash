import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';

import '../../../util/shared_pref_service.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  String selectedShop = '';
  int selectedDuration = 0;
  List<Map<String, dynamic>> operations = [];
  SharedPreferencesService sharedPrefs = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _loadOperations();
  }

  void _loadOperations() async {
    operations = await SharedPreferencesService.loadOperations();
    setState(() {});
  }

  List<List<double>> _createBarChartData() {
    List<List<double>> data = List.generate(7, (index) => List.filled(3, 0.0));
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 3; j++) {
        data[i][j] = Random().nextDouble() * 1000;
      }
    }

    return data;
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
    List<List<double>> barChartData = _createBarChartData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [
            Text(
              'Statistics',
              style: SettingsTextStyle.title,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Not enough info to show accurate info',
                    style: HomeScreenTextStyle.emptyTitle,
                  ),
                  Text(
                    'Put more info to get precise data',
                    style: HomeScreenTextStyle.emptySubtitle,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: barChartData.expand((list) => list).reduce(
                                  (value, element) =>
                                      value > element ? value : element) *
                              1.5,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                              // bottomTitles: SideTitles(
                              //   showTitles: true,
                              //   margin: 16,
                              //   getTitles: (double value) {
                              //     if (selectedDuration == 1) {
                              //       return 'Today';
                              //     } else if (selectedDuration == 2) {
                              //       int monthValue = value.toInt() + 1;
                              //       if (monthValue <= 4) {
                              //         return 'W$monthValue';
                              //       } else {
                              //         return '';
                              //       }
                              //     } else {
                              //       return [
                              //         'Mon',
                              //         'Tue',
                              //         'Wed',
                              //         'Thu',
                              //         'Fri',
                              //         'Sat',
                              //         'Sun'
                              //       ][value.toInt()];
                              //     }
                              //   },
                              // ),
                              // leftTitles: SideTitles(
                              //   showTitles: false,
                              // ),
                              ),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(
                            selectedDuration == 1
                                ? 1
                                : selectedDuration == 2
                                    ? 4
                                    : 7,
                            (index) => BarChartGroupData(
                              barsSpace: 1,
                              x: index,
                              barRods: [
                                // BarChartRodData(
                                //   y: barChartData[index].reduce(
                                //       (value, element) =>
                                //           value > element ? value : element),
                                //   colors: [AppColors.blueColor],
                                //   width: 10,
                                // ),
                                // BarChartRodData(
                                //   y: barChartData[index].reduce(
                                //       (value, element) =>
                                //           value > element ? value : element),
                                //   colors: [AppColors.purpleColor],
                                //   width: 10,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: (int newIndex) {
                        setState(() {
                          selectedDuration = newIndex;
                        });
                      },
                      isSelected: List.generate(
                          3, (index) => index == selectedDuration),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Text(
                            'Week',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Text(
                            'Today',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: Text(
                            'Month',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(5.0),
                    border:
                        Border(bottom: BorderSide(color: AppColors.blackColor)),
                    color: AppColors.lightGreyColor.withOpacity(0.4),
                  ),
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Your balance',
                                      style: HomeScreenTextStyle.bannerTitle,
                                      textAlign: TextAlign.center,
                                    ),
                                    Spacer(),
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
                      ),
                      Container(
                        width: size.width * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Incomes',
                                    style: HomeScreenTextStyle.bannerTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '\$$_totalIncome ',
                                style: HomeScreenTextStyle.bannerIncome,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: size.width * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Spendings',
                                    style: HomeScreenTextStyle.bannerTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '\$$_totalSpendings ',
                                style: HomeScreenTextStyle.bannerSpendings,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
