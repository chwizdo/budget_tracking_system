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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 0),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        margin: EdgeInsets.only(left: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 0.20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Color.fromRGBO(18, 18, 18, 1),
                            ),
                            child: DropdownButton(
                              style: TextStyle(color: Colors.white),
                              value: _currentSelectedPeriod,
                              onChanged: (newValue) {
                                setState(() {
                                  _currentSelectedPeriod = newValue;
                                });
                              },
                              items: _periodTypes.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          '< 2020 Dec >',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Card(
                color: Color.fromRGBO(57, 57, 57, 1),
                child: Row(
                  children: [
                    Expanded(
                      child: PieChart(
                        PieChartData(
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
                child: PieChartIncomeLabel(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
