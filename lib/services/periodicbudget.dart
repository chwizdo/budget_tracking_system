import 'package:budget_tracking_system/services/category.dart';
import 'package:meta/meta.dart';

class PeriodicBudget {
  String _title;
  String _interval;
  Category _category;
  double _amount;
  double _amountUsed;
  static List<PeriodicBudget> _list = [];

  // Constructor for Add Budget
  // interval (refresh), onetime (change state)
  // method-refresh when start app
  PeriodicBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required String interval,
  })  : _title = title,
        _category = category,
        _amount = amount,
        _interval = interval;

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

  static List<PeriodicBudget> add(PeriodicBudget periodicBudget) {
    _list.add(periodicBudget);
    return _list;
  }

  static List<PeriodicBudget> delete(PeriodicBudget periodicBudget) {
    _list.remove(periodicBudget);
    return _list;
  }

  //TODO refresh amount used after INTERVAL
  static void refreshBudget() {}

  //TODO calculate amountUsed
  static void calculateAmountUsed() {}

  // Need to return active budget list???
}
