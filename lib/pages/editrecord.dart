import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class EditRecord extends StatefulWidget {
  @override
  _EditRecordState createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  //Creates a list of items for DropdownButton category and account.
  String currentSelectedCategory = "Food";
  List<String> categoryTypes = ["Food", "Transport", "Entertainment"];

  String currentSelectedAccount = "Cash";
  List<String> accountTypes = ["Cash", "Maybank", "Credit Card"];

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SafeArea(
        child: Container(
          child: Padding(
            //Padding for the whole body content wrapped in container.
            padding: const EdgeInsets.all(6.0),
            //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
            child: ListView(
              children: [
              //Creates the 3 radio button.
                Column(
                  children: [
                    SizedBox(height: 12.0),
                    CustomRadioButton(
                      //Select default radio button value.
                      defaultSelected: 'INCOME',
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
                          //Do something
                          //Use another if else statement to indicate what action to perform for each value.
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
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              //Remove visible borders
                              border: InputBorder.none, 
                              //Enables color fill in the text form field.
                              filled: true, 
                              fillColor: Color.fromRGBO(41, 41, 41, 1),   
                              //Border when it is not focused by user input.              
                              enabledBorder: OutlineInputBorder( 
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              //Border when it is focused by user input.
                              focusedBorder: OutlineInputBorder( 
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.transparent)
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
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(41, 41, 41, 1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10.0)),
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
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                //Style the form field border.
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:BorderSide(color: Colors.transparent),
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.settings,
                                color: Color.fromRGBO(101, 101, 101, 1)
                            ),
                        ),
                          )
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
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:BorderSide(color: Colors.transparent),
                                  ),
                                  isDense: true),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: currentSelectedAccount,
                                    onChanged: (newValue) {
                                      setState(() {
                                        currentSelectedAccount = newValue;
                                      });
                                    },
                                    items: accountTypes.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    style: TextStyle(color: Colors.black),
                                    selectedItemBuilder: (BuildContext context) {
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
                                borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 15.0, top: 15),
                                child: Text(
                                  'RM',
                                  style: TextStyle(
                                  color: Color.fromRGBO(101, 101, 101, 1)
                                  ),
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
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(41, 41, 41, 1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:BorderRadius.all(Radius.circular(10.0)),
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
                                color: Color.fromRGBO(101, 101, 101, 1)
                            ),
                          )
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
                        borderRadius: BorderRadius.circular(18.0)
                        ),
                        onPressed: () {},
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
              ]
            ),
          ),
        ),
      ),
    );
  }
}
