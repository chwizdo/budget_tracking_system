import 'package:budget_tracking_system/services/category.dart';
import 'package:meta/meta.dart';

class PeriodicBudget {
  String _title;
  String _type;
  String _interval;
  Category _category;
  double _amount;
  double _amountUsed;
  List _allProperties;

// Constructor for Add Budget
// interval (refresh), onetime (change state)
// method-refresh when start app
  PeriodicBudget({
    @required String title,
    @required String type,
    @required Category category,
    @required double amount,
    double amountUsed,
    @required String interval,
  })  : _title = title,
        _type = type,
        _category = category,
        _amount = amount,
        _amountUsed = amountUsed,
        _interval = interval;

  // getter for each properties
  String get title {
    return _title;
  }

  String get type {
    return _type;
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

  // get all properties
  dynamic get allProperties {
    return _allProperties = [
      _title,
      _type,
      _category,
      _amount,
      _amountUsed,
      _interval,
    ];
  }

  // setter/update budget
  void setBudget({
    @required String title,
    @required String type,
    @required Category category,
    @required double amount,
    double amountUsed,
    @required String interval,
  }) {
    _title = title;
    _type = type;
    _category = category;
    _amount = amount;
    _amountUsed = amountUsed;
    _interval = interval;
  }

  //refresh amount used after INTERVAL
  void refreshBudget() {
    if (DateTime.now().day == 1 && DateTime.now().microsecond == 1) {
      _amountUsed = 0;
    }
  }

  //create Listview based on allproperties

}
