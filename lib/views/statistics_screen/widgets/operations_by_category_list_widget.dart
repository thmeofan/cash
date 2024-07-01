import 'package:cash/consts/app_text_styles/widget_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../synopsys/widgets/category_icon.dart';

class OperationsByCategoryListView extends StatefulWidget {
  final List<Map<String, dynamic>> operations;

  const OperationsByCategoryListView({Key? key, required this.operations})
      : super(key: key);

  @override
  _OperationsByCategoryListViewState createState() =>
      _OperationsByCategoryListViewState();
}

class _OperationsByCategoryListViewState
    extends State<OperationsByCategoryListView> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> get _filteredOperations {
    final type = _selectedIndex == 0 ? 'Income' : 'Spendings';
    return widget.operations.where((op) => op['type'] == type).toList();
  }

  final List<Map<String, dynamic>> _incomeCategories = [
    {'name': 'Salary', 'icon': 'assets/icons/salary.svg'},
    {'name': 'Dividends', 'icon': 'assets/icons/dividends.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investment.svg'},
    {'name': 'Rent', 'icon': 'assets/icons/rent.svg'},
    {'name': 'Freelance', 'icon': 'assets/icons/freelance.svg'},
    {'name': 'Business', 'icon': 'assets/icons/business.svg'},
    {'name': 'Royalty', 'icon': 'assets/icons/royalty.svg'},
    {'name': 'Passive', 'icon': 'assets/icons/passive.svg'},
  ];

  final List<Map<String, dynamic>> _expenseCategories = [
    {'name': 'Procurement', 'icon': 'assets/icons/procurement.svg'},
    {'name': 'Food', 'icon': 'assets/icons/food.svg'},
    {'name': 'Transport', 'icon': 'assets/icons/transport.svg'},
    {'name': 'Rest', 'icon': 'assets/icons/rest.svg'},
    {'name': 'Rent', 'icon': 'assets/icons/rent.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investment.svg'},
  ];
  List<Map<String, dynamic>> get _allCategories {
    return [
      ..._incomeCategories,
      ..._expenseCategories,
    ];
  }

  Map<String, double> get _categorySums {
    final categorySums = <String, double>{};
    final categories =
        _selectedIndex == 0 ? _incomeCategories : _expenseCategories;

    for (final category in categories) {
      categorySums[category['name']] = 0.0;
    }

    for (final operation in _filteredOperations) {
      final categoryName = operation['description'];
      final amount = operation['amount'];
      final parsedAmount = double.parse(amount.toString());
      categorySums[categoryName] =
          (categorySums[categoryName] ?? 0) + parsedAmount;
    }
    return categorySums;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(10)),
          height: size.height * 0.045,
          width: size.width * 0.95,
          child: Center(
            child: ToggleButtons(
              renderBorder: false,
              fillColor: Colors.transparent,
              isSelected: [_selectedIndex == 0, _selectedIndex == 1],
              onPressed: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: size.width * 0.46,
                    height: size.height * 0.04,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: _selectedIndex == 0
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
                        _selectedIndex == 0
                            ? BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              )
                            : const BoxShadow(color: Colors.transparent),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Income category',
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
                    width: size.width * 0.46,
                    height: size.height * 0.04,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: _selectedIndex == 1
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
                        _selectedIndex == 1
                            ? BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              )
                            : const BoxShadow(color: Colors.transparent),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Expense category ',
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
        if (_filteredOperations.isEmpty)
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/alert.svg',
                  width: 24.0,
                  height: 24.0,
                ),
                const SizedBox(height: 4),
                const Text('Sorry, no info yet', style: WidgetTextStyle.title),
                const SizedBox(height: 2),
                Text('Add some operations', style: WidgetTextStyle.subtitle),
              ],
            ),
          ),
        if (_filteredOperations.isNotEmpty)
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.2,
                crossAxisCount: 2,
              ),
              itemCount:
                  (_selectedIndex == 0 ? _incomeCategories : _expenseCategories)
                      .length,
              itemBuilder: (context, index) {
                final categories = _selectedIndex == 0
                    ? _incomeCategories
                    : _expenseCategories;
                final category = categories[index]['name'];
                final totalAmount = _categorySums[category] ?? 0;

                final categoryIconPath = CategoryIcon.getIconPath(
                  category,
                  _selectedIndex == 0 ? 'Income' : 'Expenses',
                );

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (categoryIconPath != null)
                            SvgPicture.asset(
                              categoryIconPath,
                              width: 24.0,
                              height: 24.0,
                              color: Colors.black,
                            ),
                          if (categoryIconPath == null)
                            const SizedBox(
                                height: 24.0), // Placeholder for icon
                          const SizedBox(height: 10),
                          Text(category,
                              style: HomeScreenTextStyle.incomeBannerTitle),
                          const SizedBox(height: 6),
                          Text('\$ $totalAmount', style: WidgetTextStyle.title),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
