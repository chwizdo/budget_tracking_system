import 'package:budget_tracking_system/services/record.dart';

import 'category.dart';
import 'package:meta/meta.dart';

class OneTimeBudget {
  String _title;
  Category _category;
  double _amount;
  double _amountUsed;
  DateTime _startDate;
  DateTime _endDate;
  static List<OneTimeBudget> _list = [];
  static List<OneTimeBudget> _activeList = [];
  String _budgetStatus;
  static List<Record> _budgetRecordList = [];

// Constructor for Add Budget
// interval (refresh), onetime (change state)
// method-refresh when start app
  OneTimeBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required DateTime startDate,
    @required DateTime endDate,
  })  : _title = title,
        _category = category,
        _amount = amount,
        _startDate = startDate,
        _endDate = endDate;

  // getter for each properties
  String get title {
    return _title;
  }

  Category get category {
    return _category;
  }

  double get amount {
    return _amount;
  }

  double get amountUsed {
    return _amountUsed;
  }

  DateTime get startDate {
    return _startDate;
  }

  DateTime get endDate {
    return _endDate;
  }

  String get budgetStatus {
    return _budgetStatus;
  }

  static List<OneTimeBudget> get list {
    return _list;
  }

  static List<OneTimeBudget> get activeList {
    return _activeList;
  }

  // setter/update budget
  void setBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required DateTime startDate,
    @required DateTime endDate,
  }) {
    _title = title;
    _category = category;
    _amount = amount;
    _startDate = startDate;
    _endDate = endDate;
  }

  //change budget status(upcoming/completed/current) based on start and end date
  //loop thru all the one time budget to change status
  static void changeStatus() {
    _list.forEach((element) {
      if (element._startDate.isBefore(DateTime.now()) &&
          element._endDate.isBefore(DateTime.now())) {
        element._budgetStatus = "Completed";
      } else if (element._startDate.isAfter(DateTime.now()) &&
          element._endDate.isAfter(DateTime.now())) {
        element._budgetStatus = "Up-coming";
      } else if (element._startDate.isBefore(DateTime.now()) &&
          element._endDate.isAfter(DateTime.now())) {
        element._budgetStatus = "Current";
      }
    });
  }

  // Add all periodic budget into _list
  static List<OneTimeBudget> add(OneTimeBudget oneTimeBudget) {
    _list.add(oneTimeBudget);
    return _list;
  }

  static List<OneTimeBudget> delete(int index) {
    _list.removeAt(index);
    return _list;
  }

  //return list of active budget at thta time (parameter: that time)
  static List<OneTimeBudget> returnList(DateTime dateTime) {
    _list.forEach((element) {
      if (!element.startDate.isAfter(dateTime) &&
          !element.endDate.isBefore(dateTime)) {
        activeList.add(element);
      }
    });
    return activeList;
  }

  // Add all RELATED record into budget specific list
  static List<Record> budgetRecordList(
      Category category, DateTime startDate, DateTime endDate) {
    Record.list.forEach((record) {
      if (!record.dateTime.isBefore(startDate) &&
          !record.dateTime.isAfter(endDate) &&
          record.type == "Expenses" &&
          record.category == category) {
        print(record.title);
        _budgetRecordList.add(record);
      }
    });
    return _budgetRecordList;
  }

  // TODO How to calculate amountUsed
  // take all record for that period of time (between start and end date)
  // is budget's record only come from user selection? if user no choose, will it count into budget?
  // if yes (only come from choose) {amountused can get from a list of record in that budget (no need condition)}
  // if no (can both user choose and auto)
  static void calculateAmountUsed() {
    _list.forEach((onetimebudget) {
      print(onetimebudget._title);
      List<Record> recordList = [];
      double sum = 0;
      Record.list.forEach((record) {
        if (!record.dateTime.isBefore(onetimebudget._startDate) &&
            !record.dateTime.isAfter(onetimebudget._endDate) &&
            record.type == "Expenses" &&
            record.category == onetimebudget._category) {
          recordList.add(record);
        }
      }); // Record loop
      recordList.forEach((element) {
        sum += element.amount;
      }); // recordList loop
      onetimebudget._amountUsed = sum;
      print(onetimebudget._amountUsed);
    }); // _list loop
  }
}
