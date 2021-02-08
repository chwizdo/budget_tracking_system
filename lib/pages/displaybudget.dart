import 'package:budget_tracking_system/services/linechart.dart';
import 'package:budget_tracking_system/pages/selectbudget.dart';
import 'package:budget_tracking_system/services/onetimebudget.dart';
import 'package:budget_tracking_system/services/periodicbudget.dart';
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
  bool isChecked = false;
  bool type = false;

  checkbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Show Yearly Statistics",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.grey),
          child: Checkbox(
            //ListTileControlAffinity.trailing will place the checkbox at the trailing
            activeColor: Color.fromRGBO(255, 185, 49, 1),
            value: isChecked,
            onChanged: (bool value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
        ),
      ],
    );
  }

  checkType() {
    if (budget.runtimeType == PeriodicBudget) {
      type = true;
    } else if (budget.runtimeType == OneTimeBudget) {
      type = false;
    }
  }

  displayCheckbox() {
    if (type == false) {
      return SizedBox(height: 0.0);
    } else if (type == true) {
      return checkbox();
    }
  }

  _DisplayBudgetState({@required this.dateTime});

  @override
  Widget build(BuildContext context) {
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
                                builder: (context) => SelectBudget(
                                      dateTime: dateTime,
                                    )));
                        setState(() {
                          budget = result;
                          checkType();
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
                        dateTime: widget.dateTime,
                        type: isChecked,
                      )),
                ),
                displayCheckbox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
