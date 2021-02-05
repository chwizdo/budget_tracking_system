import 'package:flutter/material.dart';
import 'package:budget_tracking_system/services/currency.dart';

class CurrencySelection extends StatefulWidget {
  final String uid;

  CurrencySelection({this.uid});

  @override
  _CurrencySelectionState createState() => _CurrencySelectionState(uid: uid);
}

class _CurrencySelectionState extends State<CurrencySelection> {
  String uid;
  List currencyList = Currency.fullList;

  _CurrencySelectionState({this.uid});

  displayCurrency() {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.grey),
      child: ListView.separated(
        itemCount: currencyList.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            //ListTileControlAffinity.trailing will place the checkbox at the trailing
            controlAffinity: ListTileControlAffinity.trailing,
            activeColor: Color.fromRGBO(255, 185, 49, 1),
            title: Text(
              currencyList[index].name,
              style: TextStyle(color: Colors.white),
            ),
            value: currencyList[index].isChecked,
            onChanged: (bool value) {
              setState(() {
                value
                    ? Currency.add(
                        uid: uid, currency: currencyList[index], save: true)
                    : Currency.remove(uid: uid, currency: currencyList[index]);
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            indent: 15.0,
            endIndent: 15.0,
          );
        },
      ),
    );
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
                child: Text('Currency Selection'),
              ),
            ],
          ),
        ),
        body: displayCurrency());
  }
}
