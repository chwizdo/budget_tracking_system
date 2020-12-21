import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

//Create the Records() Class to initialize variables and create constructors to accept various inputs
class Records {
  String category, title, account, type;
  double money;
  DateTime currentDate;

  Records({this.category, this.title, this.account, this.money, this.type, this.currentDate}); 
}

//A separator class that is responsible for grouping the list based on day by creating a new container/header for each list.
class RecordGroupSeparator extends StatelessWidget {

  //Initialize variable and creating a constructor
  final DateTime date;
  RecordGroupSeparator({this.date});

  @override
  Widget build(BuildContext context) {
    //Creates a container box which has these properties
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        //The header is a row and has 2 parts
        child: Row(
          children: [         
            //The first part is to display the day of the month from date.
            //Eg: If the record was added on 2020/12/19, it will display 19. 
            Expanded(
            flex: 1,
            child: Text(
                "${this.date.day}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
              ),
            ),
            //This second part is to display the exact day of the month.
            //Eg: Tuesday
            Expanded(
            flex: 7,
            child: Text(
                DateFormat('EEEE').format(date),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0
                ),
              ),
            ),
          ],  
        ),
      ),
    );
  }
}

class Record extends StatefulWidget {
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {

  //A list to store all the records by passing the values through using the constructor from Records() Class.
  List recordView = [
    Records(category: 'Food', title: 'McD Fried Chicken', account: 'Maybank', money: 13.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 20)),
    Records(category: 'Food', title: 'Blueberry Waffle', account: 'Cash', money: 4.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 20)),
    Records(category: 'Transport', title: 'Fuel', account: 'Maybank', money: 54.60, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 20)),
    Records(category: 'Entertainment', title: 'Avenger End Game', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 19)),
    Records(category: 'Food', title: 'Starbucks Coffee', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 19)),
    Records(category: 'Food', title: 'Starbucks Coffee', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 18)),
    Records(category: 'Food', title: 'Starbucks Coffee', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 30)),
    Records(category: 'Food', title: 'Chicken Rice', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 29)),
    Records(category: 'Food', title: 'Fried Rice', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 29)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Hello'),
        centerTitle: true,
        //Actions Button inside the AppBar widget - Favourite Icon and Search Icon
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color:Colors.white,
            ),
            onPressed: () {},
          ),
            IconButton(
            icon: Icon(
              Icons.favorite,
              color:Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SafeArea(
        //GroupedListView is a widget that can help group the list view by anything
        //Eg: Can group lists based on category or date. 
        //DateTime object is explicitly stated so that it can group the records by date
          child: GroupedListView<dynamic, DateTime>(
            //Elements takes in a list of data that needs to be grouped, in this case recordView's data needs to be taken in.
            elements: recordView,
            //groupBy is a function that chooses what to group given by an element.
            //In this case, we give an element named record to represent our recordView list, and we want to group by currentDate.
            groupBy: (record) => record.currentDate,
            //This function prepares to separate the lists by date.
            //This can be done by returning a constructor of RecordGroupSeparator() that passes currentDate to date.
            //Hence the RecordGroupSeparator() class can perform its own task which is to generate respective headers for each lists.
            groupSeparatorBuilder: (DateTime currentDate) => RecordGroupSeparator(date: currentDate),
            //Arrange the grouped lists in descending order
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            separator: Divider(
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            padding: EdgeInsets.only(bottom: 100),
            //To build and display all the items of recordView list.
            itemBuilder: (context, dynamic record){
              return Container(
                height: 70.0,
                //Each list is a row and is expanded to 3 parts.
                child: Row(
                  children: [
                    //First part is to display the category.
                    Expanded(
                      flex: 4,
                      child: ListTile(
                        leading: Text(
                          record.category,
                          //Used to wrap long texts
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                    //Second part is to display the title.
                    Expanded(
                      flex: 9,
                      child: ListTile(
                        title: Text(
                          record.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          record.account,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    //Third part is to display the money.
                      Expanded(
                      flex: 5,
                      child: ListTile(
                        //An if else statement is used to check whether it is an expense or income
                        //If it is expenses, add '-' in front of money, else add '+'
                        trailing: record.type == 'Expenses' ?
                          Text(
                            "- RM " + record.money.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0
                              ),
                            )
                            :Text(
                            "+ RM " + record.money.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

      //This button can be navigated to add records page.
     floatingActionButton: FloatingActionButton(
      child: Text(
        "+",
        style: TextStyle(
          fontSize: 25.0,
          color: Color.fromRGBO(41, 41, 41, 1)
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 185, 49, 1),
      onPressed: () {
        Navigator.pushNamed(context, '/addrecord');
      },
      ),
    );
  }
}

