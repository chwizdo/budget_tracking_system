import 'category.dart';
import 'package:meta/meta.dart';

//_allproties to list of object

class OneTimeBudget {
  String _title;
  String _type;
  Category _category;
  double _amount;
  double _amountUsed;
  DateTime _startDate;
  DateTime _endDate;
  List _allProperties;
  String _budgetStatus;

// Constructor for Add Budget
// interval (refresh), onetime (change state)
// method-refresh when start app
  OneTimeBudget({
    @required String title,
    @required String type,
    @required Category category,
    @required double amount,
    double amountUsed,
    @required DateTime startDate,
    @required DateTime endDate,
  })  : _title = title,
        _type = type,
        _category = category,
        _amount = amount,
        _amountUsed = amountUsed,
        _startDate = startDate,
        _endDate = endDate;

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

  DateTime get startDate {
    return _startDate;
  }

  DateTime get endDate {
    return _endDate;
  }

  String get budgetStatus {
    return _budgetStatus;
  }

  // get all properties
  dynamic get allProperties {
    return _allProperties = [
      _title,
      _type,
      _category,
      _amount,
      _amountUsed,
      _startDate,
      _endDate,
      _budgetStatus
    ];
  }

  // setter/update budget
  void setBudget({
    @required String title,
    @required String type,
    @required Category category,
    @required double amount,
    double amountUsed,
    @required DateTime startDate,
    @required DateTime endDate,
  }) {
    _title = title;
    _type = type;
    _category = category;
    _amount = amount;
    _amountUsed = amountUsed;
    _startDate = startDate;
    _endDate = endDate;
  }

  //change budget status(upcoming/completed/current) based on start and end date
  //loop thru all the bdget to change status (loop)
  void changeStatus() {
    if (_startDate.isBefore(DateTime.now()) &&
        _endDate.isBefore(DateTime.now())) {
      _budgetStatus = "Completed";
    } else if (_startDate.isAfter(DateTime.now()) &&
        _endDate.isAfter(DateTime.now())) {
      _budgetStatus = "Up-coming";
    } else if (_startDate.isBefore(DateTime.now()) &&
        _endDate.isAfter(DateTime.now())) {
      _budgetStatus = "Current";
    }
  }

  //return list of active budget at thta time (parameter: that time)
}
