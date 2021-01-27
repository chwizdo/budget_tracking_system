import 'package:budget_tracking_system/services/record.dart';
import 'package:budget_tracking_system/services/category.dart';
import 'package:meta/meta.dart';

class PeriodicBudget {
  String _title;
  String _interval;
  Category _category;
  double _amount;
  double _amountUsed;
  static List<PeriodicBudget> _list = [];
  DateTime _startDate;
  static List<PeriodicBudget> _activeList = [];

  // Constructor for Add Budget
  // interval (refresh), onetime (change state)
  // method-refresh when start app
  PeriodicBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required String interval,
    @required DateTime startDate,
  })  : _title = title,
        _category = category,
        _amount = amount,
        _interval = interval,
        _startDate = startDate;

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

  String get interval {
    return _interval;
  }

  static List<PeriodicBudget> get list {
    return _list;
  }

  DateTime get startDate {
    return _startDate;
  }

  static List<PeriodicBudget> get activeList {
    return _activeList;
  }

  // setter/update budget
  void setBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required String interval,
  }) {
    _title = title;
    _category = category;
    _amount = amount;
    _interval = interval;
  }

  // Add all periodic budget into _list
  static List<PeriodicBudget> add(PeriodicBudget periodicBudget) {
    _list.add(periodicBudget);
    return _list;
  }

  // Delete budget based on list index
  static List<PeriodicBudget> delete(int index) {
    _list.removeAt(index);
    return _list;
  }

  //TODO refresh amount used after INTERVAL
  // fetch record on that month only (eg: now January, only take January record)
  static void refreshBudget() {
    List<PeriodicBudget> monthlyBudget = [];
    List<PeriodicBudget> weeklyBudget = [];
    // Seperate monthly and weekly budget
    _list.forEach((element) {
      if (element._interval == "Monthly") {
        monthlyBudget.add(element);
      } else if (element._interval == "Weekly") {
        weeklyBudget.add(element);
      }
    });
  }

  //TODO calculate amountUsed (Weekly cannot do)
  // take all record for that period of time
  static void calculateAmountUsed(DateTime yearmonth) {
    _list.forEach((periodicbudget) {
      double sum = 0;
      double sum2 = 0;
      if (periodicbudget._interval == "Monthly") {
        List<Record> monthlyRecordList = [];
        Record.list.forEach((record) {
          if (!record.dateTime.isBefore(periodicbudget._startDate) &&
              record.type == "Expenses" &&
              record.category == periodicbudget._category &&
              record.dateTime.year == yearmonth.year &&
              record.dateTime.month == yearmonth.month) {
            monthlyRecordList.add(record);
          }
        });
        monthlyRecordList.forEach((element) {
          sum += element.amount;
        });
        periodicbudget._amountUsed = sum;
      } else if (periodicbudget._interval == "Weekly") {
        List<Record> weeklyRecordList = [];
        Record.list.forEach((record) {
          if (!record.dateTime.isBefore(periodicbudget._startDate) &&
              record.type == "Expenses" &&
              record.category == periodicbudget._category) {
            weeklyRecordList.add(record);
          }
        });
        weeklyRecordList.forEach((element) {
          sum2 += element.amount;
        });
        periodicbudget._amountUsed = sum2;
      }
      print(periodicbudget._amountUsed);
    });
  }

  // Need to return active budget list???
  static List<PeriodicBudget> returnList(DateTime dateTime) {
    _list.forEach((element) {
      if (!element.startDate.isBefore(dateTime)) {
        _activeList.add(element);
      }
    });
    return _activeList;
  }
}
