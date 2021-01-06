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
  static List<OneTimeBudget> activeList = [];
  String _budgetStatus;

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

  // TODO How to calculate amountUsed
  // take all record for that period of time
  static void calculateAmountUsed() {}
}
