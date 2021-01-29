import 'package:budget_tracking_system/services/currency.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_tracking_system/services/account.dart';

class AddAccount extends StatefulWidget {
  final String uid;
  AddAccount({Key key, @required this.uid}) : super(key: key);
  @override
  _AddAccountState createState() => _AddAccountState(uid);
}

class _AddAccountState extends State<AddAccount> {
  final String uid;
  _AddAccountState(this.uid);

  var recordcollections = Firestore.instance.collection('users');

  //local variables for user input
  String name;
  //not sure what data type suits currency
  String currency = "RM";
  double amount;
  DateTime dateTime;
  String _currentSelectedCurrency = "RM";
  List _currencyTypes = ["RM", "USD", "EUR"];

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Add Account'),
      ),
      body: Form(
        key: formkey,
        child: SafeArea(
          child: Container(
            child: ListView(
              children: [
                SizedBox(height: 30.0),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Name:',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50.0,
                          child: TextFormField(
                            validator: (_val) {
                              if (_val.isEmpty) {
                                return null;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (_val) {
                              name = _val;
                            },
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
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                ),

                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Amount:',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          //padding: EdgeInsets.only(left: 8.0),
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 0.80),
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
                                    currency = newValue;
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
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.only(left: 12.0),
                          height: 50.0,
                          child: TextFormField(
                            validator: (_val) {
                              if (_val.isEmpty) {
                                return null;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (_val) {
                              amount = double.parse(_val);
                            },
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
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                ),

                SizedBox(height: 20.0),
                //Display Save Button
                Column(
                  children: [
                    ButtonTheme(
                      height: 40.0,
                      minWidth: 350.0,
                      child: RaisedButton(
                        color: Color.fromRGBO(255, 185, 49, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        onPressed: () {
                          Account.add(Account(
                            uid: uid,
                            name: name,
                            currency: currency,
                            amount: amount,
                            save: true,
                          ));
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(41, 41, 41, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
