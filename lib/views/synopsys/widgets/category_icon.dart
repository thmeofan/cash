import 'package:flutter/material.dart';

class CategoryIcon {
  static String? getIconPath(String category, String operationType) {
    if (operationType == 'Income') {
      final categoryMap = _incomeCategories.firstWhere(
        (cat) => cat['name'] == category,
        orElse: () => {'name': '', 'icon': ''},
      );
      return categoryMap['icon'];
    } else {
      final categoryMap = _spendingCategories.firstWhere(
        (cat) => cat['name'] == category,
        orElse: () => {'name': '', 'icon': ''},
      );
      return categoryMap['icon'];
    }
  }

  static final List<Map<String, dynamic>> _incomeCategories = [
    {'name': 'Salary', 'icon': 'assets/icons/salary.svg'},
    {'name': 'Dividends', 'icon': 'assets/icons/dividends.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investment.svg'},
    {'name': 'Rent', 'icon': 'assets/icons/rent.svg'},
    {'name': 'Freelance', 'icon': 'assets/icons/freelance.svg'},
    {'name': 'Business', 'icon': 'assets/icons/business.svg'},
    {'name': 'Royalty', 'icon': 'assets/icons/royalty.svg'},
    {'name': 'Passive', 'icon': 'assets/icons/passive.svg'},
  ];

  static final List<Map<String, dynamic>> _spendingCategories = [
    {'name': 'Procurement', 'icon': 'assets/icons/procurement.svg'},
    {'name': 'Food', 'icon': 'assets/icons/food.svg'},
    {'name': 'Transport', 'icon': 'assets/icons/transport.svg'},
    {'name': 'Rest', 'icon': 'assets/icons/rest.svg'},
    {'name': 'Rent', 'icon': 'assets/icons/rent.svg'},
    {'name': 'Investment', 'icon': 'assets/icons/investment.svg'},
  ];
}
