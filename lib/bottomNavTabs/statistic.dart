import 'package:budget_tracking_system/data/piechart_data.dart';
import 'package:budget_tracking_system/pages/currencyselect.dart';
import 'package:budget_tracking_system/services/currency.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/displayincome.dart';
import 'package:budget_tracking_system/pages/displayexpenses.dart';
import 'package:budget_tracking_system/pages/displaybudget.dart';

class Statistic extends StatefulWidget {
  @override
  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  String _currentSelectedType = "Income";
  List _types = ["Income", "Expenses", "Budget"];

  String _currentSelectedCurrency = "USD";
  List _currencyTypes = Currency.fullList;

  bool isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
            children: [
              Flexible(
                flex: 1,
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
              Visibility(
                visible: isVisible,
                child: Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            value: _currentSelectedCurrency,
                            onChanged: (newValue) {
                              setState(() {
                                _currentSelectedCurrency = newValue;
                              });
                            },
                            items: _currencyTypes.map((value) {
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
                ),
              ),
            ],
          ),
        ),
        body: _currentSelectedType == 'Income'
            ? DisplayIncome()
            : _currentSelectedType == 'Expenses'
                ? DisplayExpenses()
                : DisplayBudget());
  }
}
