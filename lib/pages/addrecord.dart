import 'package:budget_tracking_system/services/category.dart';
import 'package:budget_tracking_system/services/account.dart';
import 'package:budget_tracking_system/services/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:budget_tracking_system/services/image_data.dart';
import 'package:budget_tracking_system/pages/image.dart';
import 'package:intl/intl.dart';

class DisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AddRecord extends StatefulWidget {
  final String uid;

  AddRecord({Key key, @required this.uid}) : super(key: key);

  @override
  _AddRecordState createState() => _AddRecordState(uid);
}

class _AddRecordState extends State<AddRecord> {
  ImageData imageData = ImageData();
  final String uid;
  _AddRecordState(this.uid);

  var recordcollections = Firestore.instance.collection('users');

  // Initialized local variables for user input
  String type = 'Income';
  String title = 'Untitled';
  DateTime dateTime = DateTime.utc(0000);
  Category category = Category.incomeList[0];
  Account account = Account.list[0];
  Account toAccount = Account.list[1];
  String currency = Account.list[0].currency;
  double amount = 0;
  String note = '';
  String attachment = '';
  bool isFav = false;

  //Initialize current date
  DateTime _pickedDate;

  //Initialize controller
  TextEditingController _dateEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Set current date on init
    _pickedDate = DateTime.now();
    DateFormat df = new DateFormat("dd-MM-yyyy HH:mm:ss");
    _dateEditingController.text = df.format(_pickedDate);

    dateTime = _pickedDate;
  }

  void selectAttachment() async {
    try {
      imageData.path =
          await FilePicker.getFilePath(type: imageData.pickingType);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    setState(() {
      imageData.fileName =
          imageData.path != null ? imageData.path.split('/').last : '';
      imageData.filePath = imageData.path;
    });
  }

  //Creates a list of items for DropdownButton category and account.
  String currentSelectedCategory = Category.incomeList[0].name;
  List<Category> categoryTypes = Category.incomeList;

  String currentSelectedAccount = Account.list[0].name;
  String currentSelectedTransferAccount = Account.list[1].name;
  List<Account> accountTypes = Account.list;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  displayWidget() {
    if (type == "Income" || type == "Expenses") {
      return Column(
        children: [
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        //Border when it is focused by user input.
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent)),
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
                      validator: (_val) {
                        if (_val.isEmpty) {
                          return null;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_val) {
                        dateTime = DateTime.parse(_val);
                      },
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
                                  // LANDMARK
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
                                // LANDMARK
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
          //Display Amount DropdownButton Field
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
                                  currentSelectedAccount = newValue;
                                  Account.list.forEach((element) {
                                    if (element.name == newValue) {
                                      account = element;
                                      currency = element.currency;
                                    }
                                  });
                                });
                              },
                              // LANDMARK
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                    child: TextField(
                      onChanged: (value) {
                        note = value;
                      },
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
                Flexible(
                  //flex: 1,
                  child: Text(
                    'Attachment:',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                        height: 40.0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  child: Dialog(
                                    child: ViewImage(filepath: imageData.path),
                                  ));
                            },
                            child: Text(
                              imageData.fileName,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                ),
                Flexible(
                  child: Container(
                      height: 40.0,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.attach_file,
                              color: Color.fromRGBO(101, 101, 101, 1)),
                          onPressed: () {
                            selectAttachment();
                          },
                        ),
                      )),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.0),

          //Display Save Button
          Column(
            children: <Widget>[
              ButtonTheme(
                height: 40.0,
                minWidth: 300.0,
                child: Column(
                  children: [
                    RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        Record.add(Record(
                          uid: uid,
                          type: type,
                          title: title,
                          account: account,
                          amount: amount,
                          category: category,
                          dateTime: dateTime,
                          note: note,
                          attachment: attachment,
                          isFav: isFav,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        //Border when it is focused by user input.
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent)),
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
                      validator: (_val) {
                        if (_val.isEmpty) {
                          return null;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_val) {
                        dateTime = DateTime.parse(_val);
                      },
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.0),

          //Display Account To: DropdownButton Field
          Container(
            margin: EdgeInsets.only(left: 12.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'From:',
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
                                  currentSelectedAccount = newValue;
                                  Account.list.forEach((element) {
                                    if (element.name == newValue) {
                                      account = element;
                                    }
                                  });
                                });
                              },
                              // LANDMARK
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
          ),

          SizedBox(height: 12.0),

          //Display Account From: DropdownButton Field
          Container(
            margin: EdgeInsets.only(left: 12.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'To:',
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
                              value: currentSelectedTransferAccount,
                              onChanged: (newValue) {
                                setState(() {
                                  // LANDMARK
                                  currentSelectedTransferAccount = newValue;
                                  Account.list.forEach((element) {
                                    if (element.name == newValue) {
                                      toAccount = element;
                                    }
                                  });
                                });
                              },
                              // LANDMARK
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
                                    currentSelectedTransferAccount,
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                      onChanged: (value) {
                        note = value;
                      },
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
            children: <Widget>[
              ButtonTheme(
                height: 40.0,
                minWidth: 300.0,
                child: Column(
                  children: [
                    RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      // onPressed: () {
                      //   Record.add(Record(
                      //     uid: uid,
                      //     type: type,
                      //     title: title,
                      //     account: account,
                      //     amount: amount,
                      //     category: category,
                      //     dateTime: dateTime,
                      //     note: note,
                      //     attachment: attachment,
                      //     isFav: isFav,
                      //     save: true,
                      //   ));
                      //   Navigator.pop(context);
                      // },
                      onPressed: () {
                        Record.add(Record(
                          uid: uid,
                          type: type,
                          title: title,
                          account: account,
                          toAccount: toAccount,
                          amount: amount,
                          dateTime: dateTime,
                          note: note,
                          attachment: attachment,
                          isFav: isFav,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Add Record'),
        //Action buttons for favourite icon in appBar.
        actions: [
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
      body: Form(
        key: formkey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            //Padding for the whole body content wrapped in container.
            //padding: const EdgeInsets.all(6.0),
            //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
            child: ListView(children: [
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
                        setState(() {
                          type = 'Income';
                          category = Category.incomeList[0];
                          currentSelectedCategory = Category.incomeList[0].name;
                          categoryTypes = Category.incomeList;
                        });
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
              displayWidget(),
            ]),
          ),
        ),
      ),
    );
  }
}
