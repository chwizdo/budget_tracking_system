import 'package:budget_tracking_system/data/piechart_data.dart';
import 'package:budget_tracking_system/pages/currencyselect.dart';
import 'package:budget_tracking_system/services/currency.dart';
import 'package:budget_tracking_system/services/linechart.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/displayincome.dart';
import 'package:budget_tracking_system/pages/displayexpenses.dart';
import 'package:budget_tracking_system/pages/displaybudget.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Statistic extends StatefulWidget {
  @override
  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  String _currentSelectedType = "Income";
  List _types = ["Income", "Expenses", "Budget"];

  String _currentSelectedCurrency = "USD";
  List _currencyTypes = Currency.list;

  //Initialize current date and date format
  DateTime _pickedDate;
  DateFormat df = new DateFormat('yyyy MMM');

  bool isVisible = true;

  pickDate() async {
    DateTime date = await showMonthPicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: _pickedDate);

    if (date != null) {
      setState(() {
        _pickedDate = date;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pickedDate = DateTime.now();

    PieIncomeData.createObj();
    PieExpensesData.createObj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                        value: _currentSelectedType,
                        onChanged: (newValue) {
                          setState(() {
                            _currentSelectedType = newValue;
                            _currentSelectedType == 'Budget'
                                ? isVisible = false
                                : isVisible = true;
                          });
                        },
                        items: _types.map((value) {
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
              Flexible(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[700])),
                  color: Color.fromRGBO(18, 18, 18, 1),
                  onPressed: () {
                    pickDate();
                  },
                  child: Text(
                    "${df.format(_pickedDate)}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _currentSelectedType == 'Income'
            ? DisplayIncome()
            : _currentSelectedType == 'Expenses'
                ? DisplayExpenses()
                : DisplayBudget(dateTime: _pickedDate));
  }
}
