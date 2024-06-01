import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import 'category_icon.dart';

class OperationsListView extends StatefulWidget {
  final List<Map<String, dynamic>> operations;

  const OperationsListView({Key? key, required this.operations})
      : super(key: key);

  @override
  _OperationsListViewState createState() => _OperationsListViewState();
}

class _OperationsListViewState extends State<OperationsListView> {
  int _selectedIndex = 0; // 0 = All, 1 = Income, 2 = Spendings

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
      children: [
        ToggleButtons(
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
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('All'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Income'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Spendings'),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredOperations.length,
            itemBuilder: (context, index) {
              final operation = _filteredOperations[index];
              final categoryName = operation['description'];
              final amount = operation['amount'];
              final type = operation['type'];

              // Get the category icon path
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
                    Text(categoryName),
                    Text(type),
                  ],
                ),
                trailing: Text('$amount'),
              );
            },
          ),
        ),
      ],
    );
  }
}
