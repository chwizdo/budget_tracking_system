import 'package:budget_tracking_system/services/record.dart';
import 'package:budget_tracking_system/services/piechart_section.dart';
import 'package:budget_tracking_system/services/piechart_label.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DisplayIncome extends StatefulWidget {
  @override
  _DisplayIncomeState createState() => _DisplayIncomeState();
}

class _DisplayIncomeState extends State<DisplayIncome> {
  String _currentSelectedPeriod = "M";
  List _periodTypes = ["M", "W", "D"];
  String currency = 'USD';
  List statistics;

  @override
  Widget build(BuildContext context) {
    statistics = Record.calculate(currency: currency);

    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 0),
          child: ListView(
            children: [
              Card(
                color: Color.fromRGBO(57, 57, 57, 1),
                child: Row(
                  children: [
                    Expanded(
                      child: PieChart(PieChartData(
                          borderData: FlBorderData(show: false),
                          centerSpaceRadius: 60,
                          sections: getIncomeSections())),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(18, 18, 18, 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                'Income',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                '$currency ${statistics[0].toString()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                'Expense',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                '$currency ${statistics[1].toString()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                'Balance',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                '$currency ${statistics[2].toString()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: PieChartIncomeLabel(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
