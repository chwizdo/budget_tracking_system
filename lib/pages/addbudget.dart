import 'package:budget_tracking_system/services/category.dart';
import 'package:budget_tracking_system/services/onetimebudget.dart';
import 'package:flutter/material.dart';

class AddBudget extends StatefulWidget {
  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  // Initialized local variables for user input
  DateTime dateTime = DateTime.now();
  String title = "Untitled";
  String type = "Periodic";
  Category category = Category.list[0];
  double amount = 0;
  DateTime startDate = DateTime.now();
  DateTime endDate;
  String interval = "Monthly";

  //Creates a list of items for DropdownButton category and account.
  String currentSelectedCategory = "Food";
  List<String> categoryTypes = ["Food", "Transport", "Entertainment"];

  String currentSelectedType = "Periodic";
  List<String> budgetTypes = ["Periodic", "One-Time"];

  String currentSelectedInterval = "Weekly";
  List<String> intervalTypes = ["Weekly", "Monthly"];

  displayWidget() {
    if (currentSelectedType == 'Periodic') {
      return Container(
        margin: EdgeInsets.only(left: 12.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Interval:',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 50.0,
                child: FormField(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
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
                          isDense: true),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: currentSelectedInterval,
                          onChanged: (newValue) {
                            setState(() {
                              currentSelectedInterval = newValue;
                            });
                          },
                          items: intervalTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          style: TextStyle(color: Colors.black),
                          selectedItemBuilder: (BuildContext context) {
                            return intervalTypes.map((String value) {
                              return Text(
                                currentSelectedInterval,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
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
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 12.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(bottom: 80.0),
                child: Text(
                  'Duration:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromRGBO(41, 41, 41, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(101, 101, 101, 1),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                        hintText: "Start Date",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Text(
                    '--',
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromRGBO(41, 41, 41, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(101, 101, 101, 1),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                        hintText: "End Date",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Add Budget'),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            //Padding for the whole body content wrapped in container.
            padding: const EdgeInsets.all(6.0),
            //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
            child: ListView(children: [
              SizedBox(height: 20.0),
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

              //Display Type Dropdown Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Type:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: FormField(
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
                                  value: currentSelectedType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedType = newValue;
                                    });
                                  },
                                  items: budgetTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(color: Colors.black),
                                  selectedItemBuilder: (BuildContext context) {
                                    return budgetTypes.map((String value) {
                                      return Text(
                                        currentSelectedType,
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

              //Display Interval or Date Range Field based on Periodic/One-Time DropdownValue
              displayWidget(),

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
                                    });
                                  },
                                  //Map the items from categoryTypes lists into item menu dropdown.
                                  items: categoryTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  //Style the dropdown items text.
                                  style: TextStyle(color: Colors.black),
                                  selectedItemBuilder: (BuildContext context) {
                                    return categoryTypes.map((String value) {
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
                        child: Container(
                          margin: EdgeInsets.only(left: 6.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.settings,
                                color: Color.fromRGBO(101, 101, 101, 1)),
                          ),
                        )),
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
                                'RM',
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
                        if (type == "Periodic") {
                        } else {
                          OneTimeBudget.add(OneTimeBudget(
                              title: title,
                              category: category,
                              amount: amount,
                              startDate: startDate,
                              endDate: endDate));
                        }
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
