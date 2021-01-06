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

  // setter/update budget
  void setBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required String interval,
    DateTime startDate,
  }) {
    _title = title;
    _category = category;
    _amount = amount;
    _interval = interval;
    _startDate = startDate;
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

  //TODO calculate amountUsed
  // take all record for that period of time
  static void calculateAmountUsed() {}

  // Need to return active budget list???
  static List<PeriodicBudget> returnList(DateTime dateTime) {}
}
