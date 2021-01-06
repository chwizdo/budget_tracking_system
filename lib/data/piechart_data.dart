import 'package:flutter/material.dart';

class PieIncomeData {
  static List<IncomeData> data = [
    IncomeData(name: 'Salary', amount: 80.4, color: Colors.blue),
    IncomeData(name: 'Investment', amount: 30.3, color: Colors.pink),
  ];
}

class IncomeData {
  String name;
  double amount;
  Color color;

  IncomeData({this.name, this.amount, this.color});
}

class PieExpensesData {
  static List<ExpensesData> data = [
    ExpensesData(name: 'Transport', amount: 80.4, color: Colors.blue),
    ExpensesData(name: 'Food', amount: 30.3, color: Colors.pink),
    ExpensesData(name: 'Entertainment', amount: 20.5, color: Colors.purpleAccent),
    ExpensesData(name: 'Misc', amount: 20.5, color: Colors.green),
    ExpensesData(name: 'Work', amount: 20.5, color: Colors.yellow),
    ExpensesData(name: 'Travel', amount: 20.5, color: Colors.orange),
  ];
}

class ExpensesData {
  String name;
  double amount;
  Color color;

  ExpensesData({this.name, this.amount, this.color});
}