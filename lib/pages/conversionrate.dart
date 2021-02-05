import 'package:budget_tracking_system/services/currency.dart';
import 'package:flutter/material.dart';

class CurrencyRate {
  String mainCurrency, otherCurrency;
  double rate;

  CurrencyRate({this.mainCurrency, this.otherCurrency, this.rate});
}

class ConversionRate extends StatefulWidget {
  @override
  _ConversionRateState createState() => _ConversionRateState();
}

class _ConversionRateState extends State<ConversionRate> {
  List<Currency> currencyRate = Currency.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Conversion Rate From EUR'),
      ),
      body: SafeArea(
        //Used to add divider between lists.
        child: ListView.separated(
          itemCount: currencyRate.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${currencyRate[index].name}',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      child: TextFormField(
                        //To add a default value inside  the text field.
                        onChanged: (rate) {
                          Currency.setCurrencyRate(
                              currency: currencyRate[index],
                              rate: double.parse(rate));
                        },
                        controller: new TextEditingController(
                            text: Currency.getCurrencyRate(
                                    currency: currencyRate[index])
                                .toStringAsFixed(
                                    2)), //Fixed the number at 2 decimal places.
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          //Remove visible borders
                          border: InputBorder.none,
                          //Enables color fill in the text form field.
                          filled: true,
                          fillColor: Color.fromRGBO(41, 41, 41, 1),
                          //Border when it is not focused by user input.
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          //Border when it is focused by user input.
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          //Divider line builder.
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            );
          },
        ),
      ),
    );
  }
}
