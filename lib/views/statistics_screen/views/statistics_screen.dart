import 'dart:math';
import 'package:cash/views/statistics_screen/widgets/operations_by_category_list_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';

import '../../../util/shared_pref_service.dart';
import '../widgets/period_data.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<Map<String, dynamic>> operations = [];
  String selectedPeriod = 'today'; // Default to 'today'
  List<String> _getLabels() {
    if (selectedPeriod == 'today') {
      return ['Total Amount'];
    } else if (selectedPeriod == 'week') {
      return ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
    } else if (selectedPeriod == 'month') {
      return ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    _loadOperations();
  }

  void _loadOperations() async {
    operations = await SharedPreferencesService.loadOperations();
    setState(() {});
  }

  List<double> _getValues() {
    List<double> amounts = [];

    if (selectedPeriod == 'today') {
      amounts.add(_totalAmount);
    } else if (selectedPeriod == 'week') {
      for (int i = 1; i <= 7; i++) {
        amounts.add(i == 1 ? _totalAmount : 250);
      }
    } else if (selectedPeriod == 'month') {
      for (int i = 1; i <= 4; i++) {
        amounts.add(i == 1 ? _totalAmount : 250);
      }
    }
    return amounts;
  }

  List<BarChartGroupData> _getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    List<double> values = _getValues();

    for (int i = 0; i < values.length; i++) {
      barGroups.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
          color: AppColors.yellowColor,
          width: 20,
          borderRadius: BorderRadius.circular(5),
          toY: values[i],
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.yellowColor.withOpacity(0.4),
                AppColors.yellowColor.withOpacity(0.4),
              ],
            ),
          ),
        )
      ]));
    }
    return barGroups;
  }

  List<BarChartGroupData> barData = [];
  double get _totalAmount {
    double totalIncome = _totalIncome;
    double totalSpendings = _totalSpendings;

    return totalIncome - totalSpendings;
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Statistics'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              'assets/icons/leading.svg',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ToggleButtons(
                isSelected: [
                  selectedPeriod == 'today',
                  selectedPeriod == 'week',
                  selectedPeriod == 'month'
                ],
                onPressed: (int index) {
                  setState(() {
                    selectedPeriod = index == 0
                        ? 'today'
                        : index == 1
                            ? 'week'
                            : 'month';
                  });
                },
                children: const [
                  Text('Today'),
                  Text('Week'),
                  Text('Month'),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    maxY: _totalAmount * 1.5,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(show: false),
                    barGroups: _getBarGroups(),
                  ),
                ),
              ),
              Padding(
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
              const Divider(
                indent: 6,
                endIndent: 8,
                height: 1.0,
                thickness: 0.2,
                color: Colors.grey,
              ),
              Padding(
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
              const Divider(
                indent: 6,
                endIndent: 8,
                height: 1.0,
                thickness: 0.2,
                color: Colors.grey,
              ),
              SizedBox(
                  height: size.height * 0.4,
                  child: OperationsByCategoryListView(
                    operations: operations,
                  )),
            ],
          ),
        ));
  }
}
