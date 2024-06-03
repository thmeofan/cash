import 'package:cash/consts/app_text_styles/constructor_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../app/widgets/input_widget.dart';

class ConstructorScreen extends StatefulWidget {
  @override
  _ConstructorScreenState createState() => _ConstructorScreenState();
}

class _ConstructorScreenState extends State<ConstructorScreen> {
  final _amountController = TextEditingController();

  String _operationType = 'Income';
  List<bool> _isSelected = [true, false];
  String _selectedCategory = '';
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

  final List<Map<String, dynamic>> _spendingCategories = [
    {'name': 'Procurement', 'icon': 'assets/icons/procurement.svg'},
    {'name': 'Food', 'icon': 'assets/icons/food.svg'},
    {'name': 'Transport', 'icon': 'assets/icons/transport.svg'},
    {'name': 'Rest', 'icon': 'assets/icons/rest.svg'},
    {'name': 'Rent', 'icon': 'assets/icons/rent.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investment.svg'},
  ];

  void _toggleOperationType(int index) {
    setState(() {
      if (index == 0) {
        _operationType = 'Income';
        _isSelected = [true, false];
      } else {
        _operationType = 'Spendings';
        _isSelected = [false, true];
      }
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _saveOperation() {
    try {
      final amount = double.tryParse(_amountController.text);

      if (_selectedCategory.isEmpty || amount == null) {
        _showErrorSnackBar('Make sure you filled all the fields');
        debugPrint(
            'Validation failed: category, amount, or name of the operation is missing.');
        return;
      }

      final operation = {
        'description': _selectedCategory,
        'amount': amount,
        'type': _operationType,
      };

      Navigator.of(context).pop(operation);
    } catch (e) {
      _showErrorSnackBar('Make sure you filled all the fields');
      debugPrint('Error in _saveOperation: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: AppColors.yellowColor),
      ),
      backgroundColor: AppColors.lightGreyColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Refill balance',
          style: SettingsTextStyle.back,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            'assets/icons/leading.svg',
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: size.height * 0.07,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ToggleButtons(
                      isSelected: _isSelected,
                      onPressed: _toggleOperationType,
                      borderRadius: BorderRadius.circular(5.0),
                      fillColor: Colors.transparent,
                      renderBorder: false,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: size.width * 0.45,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              color: _isSelected[0]
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: _isSelected[0]
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
                                _isSelected[0]
                                    ? BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      )
                                    : const BoxShadow(
                                        color: Colors.transparent),
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
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: size.width * 0.45,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              color: _isSelected[1]
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: _isSelected[1]
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
                                _isSelected[1]
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
                                'Spendings',
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
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Amount (\$)',
                        style: ConstructorTextStyle.subtitle,
                      ),
                    ),
                    const SizedBox(height: 5),
                    InputWidget(
                      controller: _amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      label: _operationType == 'Income'
                          ? 'Income Amount'
                          : 'Expense Amount',
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Expense category',
                        style: ConstructorTextStyle.subtitle,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 2.0,
                          children: _operationType == 'Income'
                              ? _incomeCategories.map((category) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _selectCategory(category['name']),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.02,
                                        vertical: size.height * 0.01,
                                      ),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            _selectedCategory ==
                                                    category['name']
                                                ? 'assets/icons/circle_check.svg'
                                                : 'assets/icons/circle.svg',
                                            width: size.width * 0.06,
                                            height: size.width * 0.06,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _selectedCategory ==
                                                      category['name']
                                                  ? AppColors.yellowColor
                                                  : AppColors.blackColor
                                                      .withOpacity(0.06),
                                            ),
                                            padding: EdgeInsets.all(
                                                size.width * 0.01),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: SvgPicture.asset(
                                                category['icon'],
                                                color: _selectedCategory ==
                                                        category['name']
                                                    ? AppColors.blackColor
                                                    : AppColors.darkGreyColor,
                                                width: size.width * 0.06,
                                                height: size.width * 0.06,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.03),
                                          Text(
                                            category['name'],
                                            style: TextStyle(
                                              color: _selectedCategory ==
                                                      category['name']
                                                  ? AppColors.blackColor
                                                  : Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList()
                              : _spendingCategories.map((category) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _selectCategory(category['name']),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.02,
                                        vertical: size.height * 0.01,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            _selectedCategory ==
                                                    category['name']
                                                ? 'assets/icons/circle_check.svg'
                                                : 'assets/icons/circle.svg',
                                            width: size.width * 0.06,
                                            height: size.width * 0.06,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: _selectedCategory ==
                                                      category['name']
                                                  ? AppColors.yellowColor
                                                  : AppColors.blackColor
                                                      .withOpacity(0.06),
                                            ),
                                            padding: EdgeInsets.all(
                                                size.width * 0.01),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: SvgPicture.asset(
                                                category['icon'],
                                                color: _selectedCategory ==
                                                        category['name']
                                                    ? AppColors.blackColor
                                                    : AppColors.darkGreyColor,
                                                width: size.width * 0.06,
                                                height: size.width * 0.06,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.03),
                                          Text(
                                            category['name'],
                                            style: TextStyle(
                                              color: _selectedCategory ==
                                                      category['name']
                                                  ? AppColors.blackColor
                                                  : Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    ChosenActionButton(
                      text: 'Make an entry',
                      onTap: _saveOperation,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
