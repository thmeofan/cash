import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../consts/app_text_styles/widget_text_style.dart';
import 'category_icon.dart';

class OperationsListView extends StatefulWidget {
  final List<Map<String, dynamic>> operations;

  const OperationsListView({super.key, required this.operations});

  @override
  _OperationsListViewState createState() => _OperationsListViewState();
}

class _OperationsListViewState extends State<OperationsListView> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> get _filteredOperations {
    if (_selectedIndex == 0) {
      return widget.operations;
    } else if (_selectedIndex == 1) {
      return widget.operations.where((op) => op['type'] == 'Income').toList();
    } else {
      return widget.operations
          .where((op) => op['type'] == 'Spendings')
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'History',
                style: HomeScreenTextStyle.titleName,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(10)),
                height: size.height * 0.045,
                width: size.width * 0.66,
                child: Center(
                  child: ToggleButtons(
                    renderBorder: false,
                    fillColor: Colors.transparent,
                    isSelected: [
                      _selectedIndex == 0,
                      _selectedIndex == 1,
                      _selectedIndex == 2
                    ],
                    onPressed: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: size.width * 0.2,
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
                              'All',
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
                          width: size.width * 0.2,
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
                              'Income',
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
                          width: size.width * 0.2,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 2
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: _selectedIndex == 2
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
                              _selectedIndex == 2
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
                              'Expense',
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
                const Text('Your balance is empty',
                    style: WidgetTextStyle.title),
                const SizedBox(height: 2),
                Text(
                    'Add Expenses or Income so you can track your financial spending.',
                    style: WidgetTextStyle.subtitle),
              ],
            ),
          ),
        if (_filteredOperations.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOperations.length,
              itemBuilder: (context, index) {
                final operation = _filteredOperations[index];
                final categoryName = operation['description'];
                final amount = operation['amount'];
                final type = operation['type'];

                final categoryIconPath =
                    CategoryIcon.getIconPath(categoryName, type);

                return ListTile(
                  leading: categoryIconPath != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.yellowColor,
                          ),
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: SvgPicture.asset(
                            categoryIconPath,
                            width: 24.0,
                            height: 24.0,
                          ),
                        )
                      : const SizedBox.shrink(),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(categoryName, style: WidgetTextStyle.title),
                      Text(type, style: WidgetTextStyle.subtitle),
                    ],
                  ),
                  trailing: Text('$amount', style: WidgetTextStyle.title),
                );
              },
            ),
          ),
      ],
    );
  }
}
