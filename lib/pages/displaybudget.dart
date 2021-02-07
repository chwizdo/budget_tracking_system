import 'package:budget_tracking_system/services/linechart.dart';
import 'package:budget_tracking_system/pages/selectbudget.dart';
import 'package:flutter/material.dart';

class DisplayBudget extends StatefulWidget {
  final DateTime dateTime;
  DisplayBudget({@required this.dateTime});

  @override
  _DisplayBudgetState createState() => _DisplayBudgetState(dateTime: dateTime);
}

class _DisplayBudgetState extends State<DisplayBudget> {
  DateTime dateTime;
  dynamic budget;

  _DisplayBudgetState({@required this.dateTime});

  @override
  Widget build(BuildContext context) {
    print("this is the index:" + budget.toString());
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: RaisedButton(
                      color: Color.fromRGBO(18, 18, 18, 1),
                      child: Text(
                        'Select Budget',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectBudget()));
                        setState(() {
                          budget = result;
                        });
                      },
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 500.0),
                  child: Card(
                      color: Color.fromRGBO(57, 57, 57, 1),
                      child: DisplayLineChart(
                        budget: budget,
                        dateTime: dateTime,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
