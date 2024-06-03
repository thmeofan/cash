import 'package:cash/views/statistics_screen/widgets/operations_by_category_list_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../util/shared_pref_service.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<Map<String, dynamic>> operations = [];
  String selectedPeriod = 'today';
  List<String> _getLabels() {
    if (selectedPeriod == 'today') {
      return ['today'];
    } else if (selectedPeriod == 'week') {
      return ['mon', 'tue', 'wed', 'thr', 'fr', 'sat', 'sun'];
    } else if (selectedPeriod == 'month') {
      return ['W1', 'W 2', 'W3', 'W4'];
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
        amounts.add(i == 1 ? _totalAmount : 50);
      }
    } else if (selectedPeriod == 'month') {
      for (int i = 1; i <= 4; i++) {
        amounts.add(i == 1 ? _totalAmount : 50);
      }
    }
    return amounts;
  }

  List<Widget> _getBarLabels() {
    List<Widget> labels = [];
    List<String> labelTexts = _getLabels();

    for (int i = 0; i < labelTexts.length; i++) {
      labels.add(
        Text(
          labelTexts[i],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return labels;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
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
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '\$${_totalAmount.toString()}',
                            style: HomeScreenTextStyle.bannerSpendings,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: size.height * 0.045,
                      width: size.width * 0.6,
                      child: Center(
                        child: ToggleButtons(
                          renderBorder: false,
                          fillColor: Colors.transparent,
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: size.width * 0.18,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  color: selectedPeriod == 'today'
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: selectedPeriod == 'today'
                                      ? const BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        )
                                      : const BorderRadius.only(
                                          topRight: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                  boxShadow: [
                                    selectedPeriod == 'today'
                                        ? BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          )
                                        : const BoxShadow(
                                            color: Colors.transparent),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: size.width * 0.18,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  color: selectedPeriod == 'week'
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: selectedPeriod == 'week'
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(0.0),
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                  boxShadow: [
                                    selectedPeriod == 'week'
                                        ? BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          )
                                        : const BoxShadow(
                                            color: Colors.transparent),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Week',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: size.width * 0.18,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  color: selectedPeriod == 'month'
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: selectedPeriod == 'month'
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(0.0),
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                  boxShadow: [
                                    selectedPeriod == 'month'
                                        ? BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          )
                                        : const BoxShadow(
                                            color: Colors.transparent),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Month',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 190,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: _totalAmount * 1.5,
                        gridData: const FlGridData(
                            drawHorizontalLine: true, drawVerticalLine: false),
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        barGroups: _getBarGroups(),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  spacing: 20.0,
                  runSpacing: 10.0,
                  children: _getBarLabels(),
                ),
                const SizedBox(
                  height: 5,
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
                          const Spacer(),
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
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: size.height * 0.37,
                    child: OperationsByCategoryListView(
                      operations: operations,
                    )),
              ],
            ),
          ),
        ));
  }
}
