import 'package:flutter/material.dart';

class SearchRecord extends StatefulWidget {
  @override
  _SearchRecordState createState() => _SearchRecordState();
}

class _SearchRecordState extends State<SearchRecord> {
  bool checkedValue = false;

  String currentSelectedCategory = "Food";
  List<String> categoryTypes = ["Food", "Transport", "Entertainment"];

  String currentSelectedAccount = "Cash";
  List<String> accountTypes = ["Cash", "maybank", "credit card"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Search Records'),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            //Padding for the whole body content wrapped in container.
            padding: const EdgeInsets.all(6.0),
            //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
            child: ListView(children: [
              SizedBox(height: 20.0),
              //Display Search Text Field
              Theme(
                data: Theme.of(context).copyWith(
                  accentColor: Color.fromRGBO(255, 185, 49, 1),
                  unselectedWidgetColor:Colors.grey
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 0.0, right: 6.0),
                  title: Container(
                    margin: EdgeInsets.only(left: 12.0, right: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
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
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color.fromRGBO(101, 101, 101, 1),
                                  ),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    SizedBox(height: 12.0),

                    //Display DateTime Picker Field
                    Container(
                      margin: EdgeInsets.only(left: 12.0, right: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 80.0),
                              child: Text(
                                'Duration:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
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
                    ),

                    SizedBox(height: 12.0),

                    //Display Interval or Date Range Field based on Periodic/One-Time DropdownValue
                    Container(
                      margin: EdgeInsets.only(left: 12.0, right: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Category:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18.0),
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
                                    //Style the form field border.
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Color.fromRGBO(41, 41, 41, 1),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
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
                                            //category = newValue;
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
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return categoryTypes
                                              .map((String value) {
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18.0),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        isDense: true),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: currentSelectedAccount,
                                        onChanged: (newValue) {
                                          setState(() {
                                            currentSelectedAccount = newValue;
                                            //account = newValue;
                                          });
                                        },
                                        items: accountTypes.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        style: TextStyle(color: Colors.black),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return accountTypes.map((String value) {
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
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 80.0),
                              child: Text(
                                'Amount:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      prefixIcon: Padding(
                                        padding:
                                            EdgeInsets.only(left: 15.0, top: 15),
                                        child: Text(
                                          'RM',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  101, 101, 101, 1)),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(12.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.transparent),
                                      ),
                                      prefixIcon: Padding(
                                        padding:
                                            EdgeInsets.only(left: 15.0, top: 15),
                                        child: Text(
                                          'RM',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  101, 101, 101, 1)),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(12.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0),

                    //Display Attachment Field

                    ListTileTheme(
                      contentPadding: EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 12.0, right: 5.0),
                        child: CheckboxListTile(
                          title: Text(
                            "Attachment Present:",
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          value: checkedValue,
                          onChanged: (bool newValue) {
                            setState(() {
                              checkedValue = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing, //  <-- trailing Checkbox
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
