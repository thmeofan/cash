import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
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
  int _selectedIndex = 0; // 0 = Income, 1 = Expenses

  List<Map<String, dynamic>> get _filteredOperations {
    final type = _selectedIndex == 0 ? 'Income' : 'Expenses';
    return widget.operations.where((op) => op['type'] == type).toList();
  }

  Map<String, double> get _categorySums {
    final categorySums = <String, double>{};
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
        ToggleButtons(
          isSelected: [_selectedIndex == 0, _selectedIndex == 1],
          onPressed: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Income'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Expenses'),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _categorySums.length,
            itemBuilder: (context, index) {
              final category = _categorySums.keys.toList()[index];
              final totalAmount = _categorySums[category] ?? 0;

              // Get the category icon path
              final categoryIconPath = CategoryIcon.getIconPath(
                  category, _selectedIndex == 0 ? 'Income' : 'Expenses');

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
                    Text(category),
                    Text('Total Amount: $totalAmount'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
