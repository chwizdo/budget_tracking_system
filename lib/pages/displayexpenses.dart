import 'package:budget_tracking_system/services/piechart_section.dart';
import 'package:budget_tracking_system/services/piechart_label.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DisplayExpenses extends StatefulWidget {
  @override
  _DisplayExpensesState createState() => _DisplayExpensesState();
}

class _DisplayExpensesState extends State<DisplayExpenses> {

  @override
  Widget build(BuildContext context) {
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
                          sections: getExpensesSections())),
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
                                'RM 9332.20',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                'Expenses',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                'RM 6555.00',
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
                                '- RM 730.50',
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
                child: PieChartExpensesLabel(),
              )
            ],
          ),
        ),
      ),
    );
  }
}