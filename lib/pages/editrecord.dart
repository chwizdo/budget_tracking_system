import 'package:budget_tracking_system/services/category.dart';
import 'package:budget_tracking_system/services/account.dart';
import 'package:budget_tracking_system/services/record.dart' as service;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:intl/intl.dart';

class DisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class EditRecord extends StatefulWidget {
  final int index;
  final String uid;
  final String type;
  final String title;
  final DateTime dateTime;
  final Category category;
  final Account account;
  final double amount;
  final String note;
  final bool isFav;

  EditRecord({
    Key key,
    @required this.index,
    @required this.uid,
    @required this.type,
    @required this.title,
    @required this.dateTime,
    @required this.category,
    @required this.account,
    @required this.amount,
    @required this.note,
    @required this.isFav,
  }) : super(key: key);

  @override
  _EditRecordState createState() => _EditRecordState(
        index: index,
        uid: uid,
        type: type,
        title: title,
        dateTime: dateTime,
        category: category,
        account: account,
        amount: amount,
        note: note,
        isFav: isFav,
      );
}

class _EditRecordState extends State<EditRecord> {
  final String uid;
  _EditRecordState({
    this.index,
    this.uid,
    this.type,
    this.title,
    this.dateTime,
    this.category,
    this.account,
    this.amount,
    this.note,
    this.isFav,
  });

  var recordcollections = Firestore.instance.collection('users');

  // Initialized local variables for user input
  int index;
  String type = 'Income';
  String title = 'Untitled';
  DateTime dateTime = DateTime.utc(0000);
  Category category = Category.incomeList[0];
  Account account = Account.list[0];
  String currency = Account.list[0].currency;
  double amount = 0;
  String note = '';
  String attachment = '';
  bool isFav = false;

  //Initialize current date
  DateTime _pickedDate = DateTime.now();

  //Initialize Date Format
  DateFormat df = new DateFormat("dd-MM-yyyy");

  //Initialize controller
  TextEditingController _dateEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pickedDate = dateTime;
    //Initialize controller
    _dateEditingController =
        TextEditingController(text: "${df.format(_pickedDate)}");
  }

  pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _pickedDate = date;
        _dateEditingController.text = df.format(_pickedDate);
        dateTime = _pickedDate;
      });
    }
  }

  //Creates a list of items for DropdownButton category and account.
  String currentSelectedCategory = Category.incomeList[0].name;
  List<Category> categoryTypes = Category.incomeList;

  String currentSelectedAccount = Account.list[0].name;
  List<Account> accountTypes = Account.list;

  @override
  Widget build(BuildContext context) {
    if (type == 'Income') {
      currentSelectedCategory = Category.incomeList[0].name;
      categoryTypes = Category.incomeList;
    } else {
      currentSelectedCategory = Category.expenseList[0].name;
      categoryTypes = Category.expenseList;
    }

    currentSelectedCategory =
        category != null ? category.name : categoryTypes[0].name;
    currentSelectedAccount = account.name;
    currency = account.currency;

    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Edit Record'),
        //Action buttons for delete and favourite icon in appBar.
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              service.Record.list[index].remove();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(
                //If isFav is False, display the favorite_border icon.
                //Else display the favorite icon.
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.white),
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            //Padding for the whole body content wrapped in container.
            padding: const EdgeInsets.all(6.0),
            //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
            child: ListView(children: [
              //Creates the 3 radio button.
              Column(
                children: [
                  SizedBox(height: 12.0),
                  CustomRadioButton(
                    //Select default radio button value.
                    defaultSelected: type.toUpperCase(),
                    //Transparent border color when selecting a border.
                    selectedBorderColor: Colors.transparent,
                    //Transparent border color when a border is not selected.
                    unSelectedBorderColor: Colors.transparent,
                    //Enable rounded rectangle shape.
                    enableShape: true,
                    width: 120.0,
                    elevation: 0,
                    //Color fill when selecting a border.
                    selectedColor: Color.fromRGBO(255, 185, 49, 1),
                    //Color fill when a border is not selected.
                    unSelectedColor: Color.fromRGBO(41, 41, 41, 1),
                    //Labels for each radio button.
                    buttonLables: [
                      'Income',
                      'Expenses',
                      'Transfer',
                    ],
                    //Values representing for each radio button.
                    buttonValues: [
                      'INCOME',
                      'EXPENSES',
                      'TRANSFER',
                    ],
                    //Styling of the radio buttons.
                    buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.white,
                        textStyle: TextStyle(fontSize: 16.0)),
                    radioButtonValue: (value) {
                      if (value == 'INCOME') {
                        setState(() {
                          type = 'Income';
                          category = Category.incomeList[0];
                          currentSelectedCategory = Category.incomeList[0].name;
                          categoryTypes = Category.incomeList;
                        });
                        //Do something
                        //Use another if else statement to indicate what action to perform for each value.
                      } else if (value == 'EXPENSES') {
                        setState(() {
                          type = 'Expenses';
                          category = Category.expenseList[0];
                          currentSelectedCategory =
                              Category.expenseList[0].name;
                          categoryTypes = Category.expenseList;
                        });
                      } else if (value == 'TRANSFER') {
                        setState(() {
                          type = 'Transfer';
                        });
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 30.0),

              //Display Title Text Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Title:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          initialValue: title,
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (_val) {
                            title = _val;
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
              ),

              SizedBox(height: 12.0),

              //Display Date Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Date:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          focusNode: DisableFocusNode(),
                          controller: _dateEditingController,
                          onTap: () {
                            pickDate();
                          },
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          // onChanged: (_val) {
                          //   dateTime = DateTime.parse(_val);
                          // },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color.fromRGBO(41, 41, 41, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Color.fromRGBO(101, 101, 101, 1),
                            ),
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Category DropdownButton Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Category:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Container(
                        height: 50.0,
                        child: FormField(
                          validator: (newvalue) {
                            if (newvalue.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              //Style the form field border.
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  //Use less vertical space.
                                  isDense: true),
                              child: DropdownButtonHideUnderline(
                                //Creates DropdownButton Widget.
                                child: DropdownButton<String>(
                                  //Value for the currently selected Dropdown item.
                                  value: currentSelectedCategory,
                                  //When user selects a new item, pass newValue into current item value.
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedCategory = newValue;
                                      categoryTypes.forEach((element) {
                                        if (element.name == newValue) {
                                          category = element;
                                        }
                                      });
                                    });
                                  },
                                  //Map the items from categoryTypes lists into item menu dropdown.
                                  items: categoryTypes.map((Category value) {
                                    return DropdownMenuItem<String>(
                                      value: value.name,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  //Style the dropdown items text.
                                  style: TextStyle(color: Colors.black),
                                  selectedItemBuilder: (BuildContext context) {
                                    return categoryTypes.map((Category value) {
                                      return Text(
                                        currentSelectedCategory,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.settings,
                                color: Color.fromRGBO(101, 101, 101, 1)),
                          ),
                        )),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Budget DropdownButton Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Budget:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: FormField(
                          validator: (newvalue) {
                            if (newvalue.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  isDense: true),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: 'Budget',
                                  // value: currentSelectedAccount,
                                  // onChanged: (newValue) {
                                  // setState(() {
                                  //   currentSelectedAccount = (newValue);
                                  //   Account.list.forEach((element) {
                                  //     if (element.name == newValue) {
                                  //       account = element;
                                  //     }
                                  //   });
                                  // });
                                  // },
                                  // items: accountTypes.map((Account value) {
                                  //   return DropdownMenuItem<String>(
                                  //     value: value.name,
                                  //     child: Text(value.name),
                                  //   );
                                  // }).toList(),
                                  style: TextStyle(color: Colors.black),
                                  // selectedItemBuilder: (BuildContext context) {
                                  //   return accountTypes.map((Account value) {
                                  //     return Text(
                                  //       currentSelectedAccount,
                                  //       style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 15.0),
                                  //     );
                                  //   }).toList();
                                  // },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Category DropdownButton Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Account:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: FormField(
                          validator: (newvalue) {
                            if (newvalue.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  isDense: true),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: currentSelectedAccount,
                                  onChanged: (newValue) {
                                    setState(() {
                                      // LANDMARK
                                      currentSelectedAccount = (newValue);
                                      Account.list.forEach((element) {
                                        if (element.name == newValue) {
                                          account = element;
                                          currency = element.currency;
                                        }
                                      });
                                    });
                                  },
                                  items: accountTypes.map((Account value) {
                                    return DropdownMenuItem<String>(
                                      value: value.name,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  style: TextStyle(color: Colors.black),
                                  selectedItemBuilder: (BuildContext context) {
                                    return accountTypes.map((Account value) {
                                      return Text(
                                        currentSelectedAccount,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Amount Text Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Amount:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          initialValue: amount.toStringAsFixed(2),
                          validator: (_val3) {
                            if (_val3.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (_val3) {
                            amount = double.parse(_val3);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color.fromRGBO(41, 41, 41, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 15.0, top: 15),
                              child: Text(
                                currency,
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Notes Text Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Notes:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          initialValue: note,
                          onChanged: (value) {
                            note = value;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color.fromRGBO(41, 41, 41, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Attachment Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Attachment:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: 40.0,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.attach_file,
                                color: Color.fromRGBO(101, 101, 101, 1)),
                          )),
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
                    minWidth: 300.0,
                    child: RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        service.Record.list[index].setProperties(
                          type: type,
                          title: title,
                          dateTime: dateTime,
                          category: category,
                          account: account,
                          amount: amount,
                          note: note,
                          attachment: attachment,
                          isFav: isFav,
                        );
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
            ]),
          ),
        ),
      ),
    );
  }
}
