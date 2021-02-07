import 'package:budget_tracking_system/services/category.dart';
import 'package:flutter/material.dart';

class PieIncomeData {
  static List<IncomeData> data = [];

  static void createObj(DateTime date) {
    data = [];
    Category.calIncomeTotal(date).forEach((key, value) {
      Color color;
      Category.incomeList.forEach((Category category) {
        if (category.name == key) {
          color = category.color;
        }
      });
      if (value != 0) {
        data.add(IncomeData(name: key, amount: value, color: color));
      }
    });
  }
}

class IncomeData {
  String name;
  double amount;
  Color color;

  IncomeData({this.name, this.amount, this.color});
}

class PieExpensesData {
  static List<ExpensesData> data = [];

  static void createObj(DateTime date) {
    data = [];
    Category.calExpenseTotal(date).forEach((key, value) {
      print('$key: $value');
      Color color;
      Category.expenseList.forEach((Category category) {
        if (category.name == key) {
          color = category.color;
        }
      });
      if (value != 0) {
        data.add(ExpensesData(name: key, amount: value, color: color));
      }
    });
  }
}

class ExpensesData {
  String name;
  double amount;
  Color color;

  ExpensesData({this.name, this.amount, this.color});
}
