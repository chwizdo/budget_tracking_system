import 'package:budget_tracking_system/services/linechart.dart';
import 'package:budget_tracking_system/bottomNavTabs/budget.dart';
import 'package:budget_tracking_system/pages/selectbudget.dart';
import 'package:flutter/material.dart';

class DisplayBudget extends StatefulWidget {
  @override
  _DisplayBudgetState createState() => _DisplayBudgetState();
}

class _DisplayBudgetState extends State<DisplayBudget> {
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
                      onPressed: () {
                        showDialog(context: context,
                        child: Dialog(
                          child: SelectBudget(),
                        )
                        );
                      },
                    ),
                  ),
                ),
                Card(
                    color: Color.fromRGBO(57, 57, 57, 1),
                    child: DisplayLineChart()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
