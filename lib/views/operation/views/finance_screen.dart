import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';

class HistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> operations;

  HistoryScreen({required this.operations});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, dynamic>> operations;
  List<Map<String, dynamic>> incomeOperations = [];
  List<Map<String, dynamic>> spendingOperations = [];
  bool _isIncomeSelected = true;

  @override
  void initState() {
    super.initState();
    operations = widget.operations;
    _separateOperations();
  }

  void _separateOperations() {
    incomeOperations =
        operations.where((op) => op['type'] == 'Income').toList();
    spendingOperations =
        operations.where((op) => op['type'] == 'Spendings').toList();
  }

  void _toggleOperationType(bool isIncome) {
    setState(() {
      _isIncomeSelected = isIncome;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Map<String, String> categoryIcons = {
      'Salary': 'assets/icons/salary.svg',
      'Dividends': 'assets/icons/dividends.svg',
      'Investment': 'assets/icons/investmentI.svg',
      'Rent': 'assets/icons/rent.svg',
      'Freelance': 'assets/icons/freelance.svg',
      'Business': 'assets/icons/business.svg',
      'Procurement': 'assets/icons/procurement.svg',
      'Food': 'assets/icons/food.svg',
      'Transport': 'assets/icons/transport.svg',
      'Rest': 'assets/icons/rest.svg',
      'Investment': 'assets/icons/investmentE.svg',
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -5,
        title: const Text(
          'Back',
          style: SettingsTextStyle.back,
        ),
        actions: [
          Text(
            'History',
            style: SettingsTextStyle.title,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            'assets/icons/leading.svg',
            width: size.width * 0.06,
            height: size.width * 0.06,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                Center(
                  child: ToggleButtons(
                    isSelected:
                        _isIncomeSelected ? [true, false] : [false, true],
                    onPressed: (index) => _toggleOperationType(index == 0),
                    borderRadius: BorderRadius.circular(5.0),
                    selectedColor: AppColors.lightGreyColor,
                    fillColor: AppColors.lightGreyColor,
                    renderBorder: false,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.13,
                          vertical: size.height * 0.012,
                        ),
                        decoration: BoxDecoration(
                            color: _isIncomeSelected
                                ? AppColors.purpleColor
                                : AppColors.lightGreyColor,
                            borderRadius: _isIncomeSelected
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
                                  )),
                        child: Text(
                          'Income',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _isIncomeSelected
                                ? Colors.white.withOpacity(0.75)
                                : Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.11,
                          vertical: size.height * 0.012,
                        ),
                        decoration: BoxDecoration(
                            color: !_isIncomeSelected
                                ? AppColors.purpleColor
                                : AppColors.lightGreyColor,
                            borderRadius: !_isIncomeSelected
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
                                  )),
                        child: Text(
                          'Spendings',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: !_isIncomeSelected
                                ? Colors.white.withOpacity(0.75)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: (_isIncomeSelected
                            ? incomeOperations
                            : spendingOperations)
                        .isNotEmpty
                    ? ListView.builder(
                        itemCount: _isIncomeSelected
                            ? incomeOperations.length
                            : spendingOperations.length,
                        itemBuilder: (context, index) {
                          final operation = _isIncomeSelected
                              ? incomeOperations[index]
                              : spendingOperations[index];
                          final icon =
                              categoryIcons[operation['description']] ??
                                  'assets/icons/default_icon.svg';

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 0.1,
                                    height: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          icon,
                                          width: size.width * 0.06,
                                          height: size.width * 0.06,
                                          color: AppColors.purpleColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        operation['name'] ?? '',
                                        style: HomeScreenTextStyle.titleDate,
                                      ),
                                      Text(
                                        '\$${operation['amount']}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGreyColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        operation['description'] ?? '',
                                        style: const TextStyle(
                                          color: AppColors.blueColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            SvgPicture.asset(
                              'assets/images/onboarding1.svg',
                              width: size.width * 0.9,
                              height: size.height * 0.3,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              'There\'s no info yet',
                              style: HomeScreenTextStyle.emptyTitle,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              'Add your incomes and expenses',
                              style: HomeScreenTextStyle.emptySubtitle,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
