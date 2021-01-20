import 'package:budget_tracking_system/services/user.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/bottomNavTabs/account.dart';
import 'package:budget_tracking_system/bottomNavTabs/budget.dart';
import 'package:budget_tracking_system/bottomNavTabs/record.dart';
import 'package:budget_tracking_system/bottomNavTabs/settings.dart';
import 'package:budget_tracking_system/bottomNavTabs/statistic.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatefulWidget {
  final String uid;

  Mainpage({Key key, @required this.uid}) : super(key: key);
  @override
  _MainpageState createState() => _MainpageState(uid);
}

class _MainpageState extends State<Mainpage> {
  final String uid;

  _MainpageState(this.uid);
  //Variable initialized to store index number of each tab menu of bottom navigation bar
  int selectedIndex = 0;

  //Each page of the bottomNavTabs are represented as a class inside the list.
  //Eg: Budget() is page 2 which is having an index of 1.

  @override
  Widget build(BuildContext context) {
    // location of tabindex is changed to make sure that user.uid can be passed to specific tab
    final user = Provider.of<User>(context);
    List tabIndex = [
      Record(uid: user.uid),
      //put (uid:user.uid) afterwards
      Budget(),
      Statistic(),
      Account(uid: user.uid),
      Settings(
        uid: uid,
      ),
    ];

    return Scaffold(
      //Sets the initial page for user upon entering the main page
      //Each tab in bottom navigation bar has its own index number
      body: tabIndex.elementAt(selectedIndex),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            //Sets background color of Bottom Navigation Bar
            canvasColor: Color.fromRGBO(41, 41, 41, 1),
            //Sets active color of Bottom Navigation Bar
            primaryColor: Color.fromRGBO(255, 176, 0, 1),
            //Sets inactive color of Bottom Navigation Bar
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.grey))),
        child: SafeArea(
          child: BottomNavigationBar(
              //Assigning the selectedIndex variable which is 0 into current active Nav Bar
              currentIndex: selectedIndex,
              //Sets the Nav Bar Type into persistent style
              //So it displays icon and the title together for each tab.
              type: BottomNavigationBarType.fixed,
              iconSize: 30,
              //Adds Bottom Navigation Bar bottomNavTabs
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Record',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on),
                  label: 'Budget',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Statistic',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),
                  label: 'Account',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              //Updates the selectedIndex variable when a new active tab is selected.
              //If Settings Tab is selected, the index number will be changed from 0 to 4 assuming the first tab is record tab.
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
