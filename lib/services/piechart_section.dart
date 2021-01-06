import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:budget_tracking_system/data/piechart_data.dart';

List<PieChartSectionData> getIncomeSections() => 
  PieIncomeData.data
  .asMap()
  .map<int, PieChartSectionData>((index, data) {
    final value = PieChartSectionData (
      color: data.color,
      value: data.amount,
      title: '${data.amount}',
      titleStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    );    
    return MapEntry(index, value);
  })
  .values
  .toList();

  List<PieChartSectionData> getExpensesSections() => 
  PieExpensesData.data
  .asMap()
  .map<int, PieChartSectionData>((index, data) {
    final value = PieChartSectionData (
      color: data.color,
      value: data.amount,
      title: '${data.amount}',
      titleStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    );    
    return MapEntry(index, value);
  })
  .values
  .toList();
